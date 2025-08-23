import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_app/config/app_constants.dart';
import 'package:rice_app/config/size_config.dart';
import 'package:rice_app/models/disease_model.dart';
import 'package:rice_app/services/disease_service.dart';
import 'package:rice_app/services/image_service.dart';
import 'package:rice_app/widgets/image_display_card.dart';
import 'package:rice_app/widgets/result_display_card.dart';

class DiseaseClassifierScreen extends StatefulWidget {
  final int cropId;
  final String cropName;

  const DiseaseClassifierScreen({
    Key? key,
    required this.cropId,
    required this.cropName,
  }) : super(key: key);

  @override
  _DiseaseClassifierScreenState createState() =>
      _DiseaseClassifierScreenState();
}

class _DiseaseClassifierScreenState extends State<DiseaseClassifierScreen>
    with SingleTickerProviderStateMixin {
  File? _image;
  String _result = '';
  DiseaseModel? _diseaseModel; // Add this line to store the disease model
  bool _isLoading = false;
  bool _isProcessingImage = false;
  double _processingProgress = 0.0;
  String _processingText = 'Processing...';

  late AnimationController _animationController;
  late Animation<double> _animation;

  final ImageService _imageService = ImageService();
  final DiseaseService _diseaseService = DiseaseService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SizeConfig.init(context);
    });
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

  // Capture an image and analyze
  Future<void> pickAndAnalyzeImage(ImageSource source) async {
    try {
      setState(() {
        _result = '';
        _diseaseModel = null; // Reset the disease model
      });

      // Pick image from camera or gallery
      File? pickedFile = await _imageService.pickImage(source);
      if (pickedFile == null) return;

      // Show original image immediately
      setState(() {
        _image = pickedFile;
      });

      // Update progress UI and resize image
      _updateProcessingProgress();
      File resizedFile = await _imageService.resizeImage(pickedFile);

      // Update UI with resized image and start loading
      setState(() {
        _image = resizedFile;
        _isLoading = true;
      });

      // Send to API
      setState(() {
        _processingText = 'Analyzing leaf pattern...';
      });

      // Get prediction from service
      final diseaseModel = await _diseaseService.predictDisease(
        resizedFile,
        widget.cropId,
      );

      // Update UI with result
      setState(() {
        _result = diseaseModel.name;
        _diseaseModel = diseaseModel; // Store the disease model
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
      _diseaseModel = null; // Reset disease model on error
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
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crop Disease Detector',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 2.2,
          ),
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppConstants.primaryColor.withOpacity(0.3), Colors.white],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                _buildHeader(),
                SizedBox(height: SizeConfig.blockSizeVertical * 3),

                // Image Display Card
                ImageDisplayCard(
                  image: _image,
                  isProcessingImage: _isProcessingImage,
                  processingProgress: _processingProgress,
                  processingText: _processingText,
                  animation: _animation,
                ),

                SizedBox(height: SizeConfig.blockSizeVertical * 3),

                // Buttons for Image Selection
                _buildImageSelectionButtons(),

                SizedBox(height: SizeConfig.blockSizeVertical * 3),

                // Result Section
                _buildResultSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Identify ${widget.cropName} Diseases',
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 3,
            fontWeight: FontWeight.bold,
            color: AppConstants.secondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Text(
          'Take or select a photo of leaves to identify diseases',
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 2,
            color: AppConstants.neutral1,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImageSelectionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.camera_alt,
              size: SizeConfig.imageSizeMultiplier * 5,
            ),
            label: Text(
              'Camera',
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
            ),
            onPressed:
                (_isLoading || _isProcessingImage)
                    ? null
                    : () => pickAndAnalyzeImage(ImageSource.camera),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1.5,
              ),
              disabledBackgroundColor: Colors.grey.shade400,
            ),
          ),
        ),
        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.photo_library,
              size: SizeConfig.imageSizeMultiplier * 5,
            ),
            label: Text(
              'Gallery',
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.8),
            ),
            onPressed:
                (_isLoading || _isProcessingImage)
                    ? null
                    : () => pickAndAnalyzeImage(ImageSource.gallery),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66BB6A),
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1.5,
              ),
              disabledBackgroundColor: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    if (_isLoading && !_isProcessingImage) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Text(
              _processingText,
              style: TextStyle(
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textMultiplier * 1.8,
              ),
            ),
          ],
        ),
      );
    } else if (_result.isNotEmpty && _diseaseModel != null) {
      return ResultDisplayCard(diseaseModel: _diseaseModel!);
    } else {
      return SizedBox.shrink();
    }
  }
}
