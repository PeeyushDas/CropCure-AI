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
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Brown Rust': '''1. Grow resistant wheat varieties.
2. Apply fungicides such as triazoles at the first sign of disease.
3. Remove and destroy crop residues after harvest.
4. Practice crop rotation to reduce disease pressure.''',
    'Healthy':
        'No treatment needed. Maintain good field hygiene and monitor regularly.',
    'Loose Smut': '''1. Use certified, disease-free seed.
2. Treat seeds with systemic fungicides before sowing.
3. Remove and destroy infected plants.
4. Practice crop rotation and field sanitation.''',
    'Septoria': '''1. Grow resistant varieties if available.
2. Apply fungicides such as strobilurins or triazoles at early stages.
3. Remove and destroy infected crop debris.
4. Avoid overhead irrigation and ensure good field drainage.''',
    'Yellow Rust': '''1. Plant resistant wheat varieties.
2. Apply fungicides such as triazoles or strobilurins at the first sign.
3. Monitor fields regularly, especially in cool, wet weather.
4. Remove volunteer wheat plants and weeds.''',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return WheatDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class WheatDiseaseModel extends DiseaseModel {
  WheatDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
