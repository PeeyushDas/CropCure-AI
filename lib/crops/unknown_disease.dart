// lib/crops/unknown_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class UnknownDiseaseHandler implements CropDiseaseHandler {
  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    return UnknownDiseaseModel(
      name: 'Unknown Disease',
      description: 'Information about this disease is currently unavailable.',
      cropId: cropId,
    );
  }
}

class UnknownDiseaseModel extends DiseaseModel {
  UnknownDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
