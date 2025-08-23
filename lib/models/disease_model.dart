// lib/models/disease_model.dart
import 'package:rice_app/factories/crop_disease_factory.dart';

abstract class DiseaseModel {
  final String name;
  final String description;
  final int cropId;
  final String cure;

  DiseaseModel({
    required this.name,
    required this.description,
    required this.cropId,
    required this.cure,
  });

  factory DiseaseModel.fromPrediction(int prediction, int cropId) {
    return CropDiseaseFactory.createDisease(prediction, cropId);
  }
}
