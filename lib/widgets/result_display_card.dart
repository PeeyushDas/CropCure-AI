import 'package:flutter/material.dart';
import 'package:rice_app/config/size_config.dart';
import 'package:rice_app/models/disease_model.dart';

class ResultDisplayCard extends StatelessWidget {
  final String diseaseName;
  final int cropId; // Added cropId parameter

  const ResultDisplayCard({
    Key? key,
    required this.diseaseName,
    required this.cropId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get description using the existing method
    final description = DiseaseModel.getDescriptionForDisease(
      diseaseName,
      cropId,
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Color(0xFF4CAF50),
                  size: SizeConfig.imageSizeMultiplier * 6,
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                Text(
                  'Analysis Result',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            Divider(height: SizeConfig.blockSizeVertical * 3),
            Text(
              'Detected Disease:',
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                color: Color(0xFF757575),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            Text(
              diseaseName,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.8,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    color: Color(0xFF757575),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 1),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
