import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img; // For image resizing

void main() {
  runApp(const RiceDiseaseClassifierApp());
}

class RiceDiseaseClassifierApp extends StatelessWidget {
  const RiceDiseaseClassifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rice Disease Classifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF4CAF50),
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const DiseaseClassifierScreen(),
    );
  }
}

class DiseaseClassifierScreen extends StatefulWidget {
  const DiseaseClassifierScreen({super.key});

  @override
  _DiseaseClassifierScreenState createState() =>
      _DiseaseClassifierScreenState();
}

class _DiseaseClassifierScreenState extends State<DiseaseClassifierScreen>
    with SingleTickerProviderStateMixin {
  File? _image;
  String _result = '';
  bool _isLoading = false;
  bool _isProcessingImage = false; // Flag for image processing
  double _processingProgress = 0.0; // Progress indicator value
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Processing state text messages
  String _processingText = 'Processing...';

  // Disease information map
  final Map<String, String> _diseaseInfo = {
    'Bacterial Blight':
        'A serious bacterial disease that causes wilting of seedlings and yellowing and drying of leaves.',
    'Blast':
        'A fungal disease that affects leaves, stems, peduncles, panicles, seeds and roots.',
    'BrownSpot':
        'A fungal disease that produces brown lesions or spots on the leaves and glumes of rice.',
    'Tungro':
        'A viral disease transmitted by leafhoppers, causing yellow or orange discoloration of leaves.',
    'Unknown Disease':
        'The disease could not be identified. Please try again with a clearer image.',
  };

  // Server endpoint - replace with your actual server URL
  static const String SERVER_URL =
      "https://rice-server-j666.onrender.com/predict/";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Simulate progress for image processing
  void _updateProcessingProgress() async {
    // Simulate the image processing steps with progress updates
    setState(() {
      _isProcessingImage = true;
      _processingProgress = 0.0;
      _processingText = 'Loading image...';
    });

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    setState(() {
      _processingProgress = 0.3;
      _processingText = 'Decoding image...';
    });

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      _processingProgress = 0.5;
      _processingText = 'Resizing image...';
    });

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    setState(() {
      _processingProgress = 0.8;
      _processingText = 'Optimizing for analysis...';
    });

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      _processingProgress = 1.0;
      _processingText = 'Processing complete';
    });

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      _isProcessingImage = false;
      _processingProgress = 0.0;
    });
  }

  // Resize image to 224x224 using the image package
  Future<File> resizeImage(File file) async {
    // Start processing progress animation
    _updateProcessingProgress();

    final bytes = await file.readAsBytes();
    // Decode image
    img.Image? image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception("Unable to decode image.");
    }
    // Resize the image to 224x224
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);
    // Encode the image back to JPEG
    final resizedBytes = img.encodeJpg(resizedImage);
    // Save resized image to a temporary file
    final tempDir = file.parent;
    final resizedFile = File(
      '${tempDir.path}/resized_${file.uri.pathSegments.last}',
    );
    await resizedFile.writeAsBytes(resizedBytes);
    return resizedFile;
  }

  // Capture an image using the camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        setState(() {
          _result = '';
        });

        File originalFile = File(pickedFile.path);

        // Show original image immediately
        setState(() {
          _image = originalFile;
        });

        // Resize the image to 224x224 before uploading
        File resizedFile = await resizeImage(originalFile);

        // Update UI with resized image
        setState(() {
          _image = resizedFile; // Show the resized image in the app
          _isLoading = true;
        });

        await uploadImage(resizedFile);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  // Upload image to server and get prediction
  Future<void> uploadImage(File imageFile) async {
    try {
      setState(() {
        _processingText = 'Sending to server...';
      });

      var request = http.MultipartRequest('POST', Uri.parse(SERVER_URL));
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      setState(() {
        _processingText = 'Analyzing leaf pattern...';
      });

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      // Parse the response
      var result = json.decode(responseData);
      print(result); // Debugging line to check the response

      String predictionText;
      int prediction = result['prediction'];
      switch (prediction) {
        case 0:
          predictionText = 'Bacterial Blight';
          break;
        case 1:
          predictionText = 'Blast';
          break;
        case 2:
          predictionText = 'BrownSpot';
          break;
        case 3:
          predictionText = 'Tungro';
          break;
        default:
          predictionText = 'Unknown Disease';
      }

      setState(() {
        _result = predictionText;
        _isLoading = false;
      });
    } catch (e) {
      _handleError(e);
    }
  }

  // Error handling method
  void _handleError(dynamic error) {
    setState(() {
      _isLoading = false;
      _isProcessingImage = false;
      _result = 'Error';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: ${error.toString()}'),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rice Disease Detector',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF4CAF50).withOpacity(0.3), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header section
                  const Text(
                    'Identify Rice Plant Diseases',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Take or select a photo of rice leaves to identify diseases',
                    style: TextStyle(fontSize: 16, color: Color(0xFF616161)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Image Display Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF4CAF50).withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Image or placeholder
                            _image != null
                                ? Image.file(
                                  _image!,
                                  height: 300,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                                : Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FadeTransition(
                                        opacity: _animation,
                                        child: const Icon(
                                          Icons.agriculture_outlined,
                                          size: 80,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'No image selected',
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            // Processing overlay
                            if (_isProcessingImage)
                              Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.7),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image_search,
                                      color: Color(0xFF4CAF50),
                                      size: 40,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _processingText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: 200,
                                      child: LinearProgressIndicator(
                                        value: _processingProgress,
                                        backgroundColor: Colors.white24,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFF4CAF50),
                                            ),
                                        borderRadius: BorderRadius.circular(8),
                                        minHeight: 8,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${(_processingProgress * 100).toInt()}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Buttons for Image Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                          onPressed:
                              (_isLoading || _isProcessingImage)
                                  ? null
                                  : () => pickImage(ImageSource.camera),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            disabledBackgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                          onPressed:
                              (_isLoading || _isProcessingImage)
                                  ? null
                                  : () => pickImage(ImageSource.gallery),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF66BB6A),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            disabledBackgroundColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Result Section
                  if (_isLoading && !_isProcessingImage)
                    Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _processingText,
                            style: const TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (_result.isNotEmpty)
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.analytics, color: Color(0xFF4CAF50)),
                                SizedBox(width: 8),
                                Text(
                                  'Analysis Result',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 24),
                            const Text(
                              'Detected Disease:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF757575),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _result,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_diseaseInfo.containsKey(_result))
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF757575),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _diseaseInfo[_result]!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
