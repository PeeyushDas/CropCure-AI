// lib/crops/apple_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class AppleDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Apple Scab',
    1: 'Cedar Apple Rust',
    2: 'Powdery Mildew',
    3: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Apple Scab':
        'A fungal disease that causes dark, olive-green spots on leaves and fruit.',
    'Cedar Apple Rust':
        'A fungal disease that causes yellow-orange spots on leaves, transmitted by cedar trees.',
    'Powdery Mildew':
        'A fungal disease that produces a white powdery coating on leaves and stems.',
    'Healthy': 'No visible symptoms of disease.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return AppleDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class AppleDiseaseModel extends DiseaseModel {
  AppleDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
