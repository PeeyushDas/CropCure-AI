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
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Apple Scab': '''1. Remove and destroy infected leaves and fruit.
2. Apply fungicides such as captan or myclobutanil at early signs of disease.
3. Prune trees to improve air circulation and reduce humidity.''',
    'Cedar Apple Rust': '''1. Remove nearby cedar trees if possible.
2. Apply fungicides (e.g., myclobutanil) at pink bud stage and repeat as needed.
3. Remove and destroy infected leaves.''',
    'Powdery Mildew': '''1. Prune affected areas and improve air circulation.
2. Apply sulfur-based or potassium bicarbonate fungicides.
3. Avoid overhead watering.''',
    'Healthy': 'No treatment needed. Maintain good orchard hygiene.',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return AppleDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class AppleDiseaseModel extends DiseaseModel {
  AppleDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
