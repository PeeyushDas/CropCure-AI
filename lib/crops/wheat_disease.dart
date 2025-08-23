// lib/crops/wheat_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class WheatDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Brown Rust',
    1: 'Healthy',
    2: 'Loose Smut',
    3: 'Septoria',
    4: 'Yellow Rust',
  };

  static const Map<String, String> _descriptions = {
    'Brown Rust':
        'A fungal disease characterized by brown pustules on leaves, stems, and spikes.',
    'Healthy': 'No visible symptoms of disease.',
    'Loose Smut':
        'A fungal disease that causes the heads of wheat to be replaced with a mass of black spores.',
    'Septoria':
        'A fungal disease that causes leaf spots and premature leaf drop, reducing yield.',
    'Yellow Rust':
        'A fungal disease that produces yellow pustules on leaves, leading to reduced photosynthesis.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return WheatDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class WheatDiseaseModel extends DiseaseModel {
  WheatDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
