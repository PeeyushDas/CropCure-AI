import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class MaizeDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Blight',
    1: 'Common Rust',
    2: 'Gray Leaf Spot',
    3: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Blight':
        'A fungal disease that causes rapid wilting and death of the plant, often affecting the leaves.',
    'Common Rust':
        'A fungal disease that produces reddish-brown pustules on leaves, reducing photosynthesis.',
    'Gray Leaf Spot':
        'A fungal disease that causes gray lesions on leaves, leading to reduced yield.',
    'Healthy': 'No visible symptoms of disease.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Blight': '''1. Use disease-free seeds and resistant maize varieties.
2. Rotate crops to reduce pathogen buildup in the soil.
3. Apply appropriate fungicides at the first sign of disease.
4. Remove and destroy infected plant debris after harvest.''',
    'Common Rust': '''1. Plant resistant maize hybrids.
2. Apply fungicides such as strobilurins or triazoles if rust appears early.
3. Remove and destroy infected leaves and plant debris.
4. Practice crop rotation to minimize disease recurrence.''',
    'Gray Leaf Spot': '''1. Rotate crops and avoid continuous maize planting.
2. Use resistant hybrids and ensure good field drainage.
3. Apply fungicides if disease pressure is high.
4. Remove and destroy infected crop residue after harvest.''',
    'Healthy':
        'No treatment needed. Maintain good field hygiene and monitor regularly.',
    'Unknown Disease':
        'Consult a local agricultural extension for advice on treatment.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return MaizeDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class MaizeDiseaseModel extends DiseaseModel {
  MaizeDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
