import 'package:flutter/material.dart';
import 'package:rice_app/config/app_constants.dart';
import 'package:rice_app/config/size_config.dart';
import 'package:rice_app/models/crop_model.dart';
import 'package:rice_app/screens/disease_classifier_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConstants.primaryColor.withOpacity(0.3), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                Text(
                  'Select a Crop',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                Text(
                  'Choose the crop type to identify diseases',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    color: AppConstants.neutral1,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 4),

                // Grid of crop options
                Expanded(child: _buildCropGrid(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCropGrid(BuildContext context) {
    // Define list of crops
    final List<CropModel> crops = [
      CropModel(id: 0, name: 'Rice', imageAsset: 'assets/Rice.jpg'),
      CropModel(id: 1, name: 'Wheat', imageAsset: 'assets/Wheat.jpg'),
      CropModel(id: 2, name: 'Maize', imageAsset: 'assets/Maize.jpg'),
      CropModel(id: 3, name: 'Potato', imageAsset: 'assets/Potato.jpg'),
      CropModel(id: 4, name: 'Tomato', imageAsset: 'assets/Tomato.jpeg'),
      CropModel(id: 5, name: 'Soybean', imageAsset: 'assets/Soybean.jpg'),
      CropModel(id: 6, name: 'Orange', imageAsset: 'assets/Orange.jpg'),
      CropModel(id: 7, name: 'Apple', imageAsset: 'assets/Apple.jpg'),
      CropModel(id: 8, name: 'Mango', imageAsset: 'assets/Mango.jpg'),
    ];

    // Calculate responsive grid based on screen size
    int crossAxisCount;
    double childAspectRatio;

    if (SizeConfig.screenWidth < 600) {
      crossAxisCount = 2; // For phones
      childAspectRatio = 1.0;
    } else if (SizeConfig.screenWidth < 900) {
      crossAxisCount = 3; // For tablets
      childAspectRatio = 1.1;
    } else {
      crossAxisCount = 4; // For larger screens
      childAspectRatio = 1.2;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: SizeConfig.blockSizeHorizontal * 3,
        mainAxisSpacing: SizeConfig.blockSizeVertical * 3,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: crops.length,
      itemBuilder: (context, index) {
        return _buildCropCard(context, crops[index]);
      },
    );
  }

  Widget _buildCropCard(BuildContext context, CropModel crop) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
      ),
      child: InkWell(
        onTap: () => _navigateToDiseaseScreen(context, crop),
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image occupying 70% of the card
            Expanded(
              flex: 7, // 70% of available space
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(SizeConfig.blockSizeHorizontal * 4),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(SizeConfig.blockSizeHorizontal * 4),
                  ),
                  child: Image.asset(
                    crop.imageAsset,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            // Text area occupying 30% of the card
            Expanded(
              flex: 3, // 30% of available space
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: Center(
                  child: Text(
                    crop.name,
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.2,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.secondaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDiseaseScreen(BuildContext context, CropModel crop) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                DiseaseClassifierScreen(cropId: crop.id, cropName: crop.name),
      ),
    );
  }
}
