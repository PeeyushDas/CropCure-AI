import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageService {
  final ImagePicker _picker = ImagePicker();

  // Capture an image using the camera or gallery
  Future<File?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Resize image to 224x224 using the image package
  Future<File> resizeImage(File file) async {
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

  // Process image for analysis (pick and resize)
  Future<File?> processImageForAnalysis(ImageSource source) async {
    File? originalFile = await pickImage(source);
    if (originalFile == null) return null;

    // Resize the image
    return await resizeImage(originalFile);
  }
}
