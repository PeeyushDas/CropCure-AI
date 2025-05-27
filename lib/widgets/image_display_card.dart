import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rice_app/config/app_constants.dart';
import 'package:rice_app/config/size_config.dart';

class ImageDisplayCard extends StatelessWidget {
  final File? image;
  final bool isProcessingImage;
  final double processingProgress;
  final String processingText;
  final Animation<double> animation;

  const ImageDisplayCard({
    Key? key,
    required this.image,
    required this.isProcessingImage,
    required this.processingProgress,
    required this.processingText,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.blockSizeHorizontal * 5,
          ),
          border: Border.all(
            color: AppConstants.primaryColor.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            SizeConfig.blockSizeHorizontal * 4.5,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image or placeholder
              image != null
                  ? Image.file(
                    image!,
                    height: SizeConfig.blockSizeVertical * 35,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                  : Container(
                    height: SizeConfig.blockSizeVertical * 35,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeTransition(
                          opacity: animation,
                          child: Icon(
                            Icons.agriculture_outlined,
                            size: SizeConfig.imageSizeMultiplier * 20,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical * 2),
                        Text(
                          'No image selected',
                          style: TextStyle(
                            color: Color(0xFF757575),
                            fontSize: SizeConfig.textMultiplier * 2,
                          ),
                        ),
                      ],
                    ),
                  ),

              // Processing overlay
              if (isProcessingImage)
                Container(
                  height: SizeConfig.blockSizeVertical * 35,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_search,
                        color: AppConstants.primaryColor,
                        size: SizeConfig.imageSizeMultiplier * 10,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      Text(
                        processingText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 50,
                        child: LinearProgressIndicator(
                          value: processingProgress,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppConstants.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 2,
                          ),
                          minHeight: SizeConfig.blockSizeVertical * 1,
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                      Text(
                        '${(processingProgress * 100).toInt()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.textMultiplier * 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
