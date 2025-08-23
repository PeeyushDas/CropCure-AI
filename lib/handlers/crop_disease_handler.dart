// lib/handlers/crop_disease_handler.dart
import '../models/disease_model.dart';

abstract class CropDiseaseHandler {
  DiseaseModel createDisease(int prediction, int cropId);
}
