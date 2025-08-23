import 'package:flutter/material.dart';
import 'package:rice_app/config/size_config.dart';

class CureDisplayCard extends StatelessWidget {
  final String cure;

  const CureDisplayCard({Key? key, required this.cure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
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
                  Icons.healing,
                  color: Color(0xFF1976D2),
                  size: SizeConfig.imageSizeMultiplier * 6,
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                Text(
                  'Cure / Treatment',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.2,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
              ],
            ),
            Divider(height: SizeConfig.blockSizeVertical * 3),
            Text(
              cure,
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
