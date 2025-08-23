import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class RiceDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Bacterial Blight',
    1: 'Blast',
    2: 'Brown Spot',
    3: 'Tungro',
    4: 'Healthy',
    5: 'Leaf Scald',
  };

  static const Map<String, String> _descriptions = {
    'Bacterial Blight':
        'A serious bacterial disease that causes wilting of seedlings and yellowing and drying of leaves.',
    'Blast':
        'A fungal disease that affects leaves, stems, peduncles, panicles, seeds and roots.',
    'Brown Spot':
        'A fungal disease that produces brown lesions or spots on the leaves and glumes of rice.',
    'Tungro':
        'A viral disease transmitted by leafhoppers, causing yellow or orange discoloration of leaves.',
    'Healthy': 'No visible symptoms of disease.',
    'Leaf Scald':
        'A fungal disease that causes water-soaked lesions on leaves, leading to premature leaf death.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Bacterial Blight': '''1. Use resistant rice varieties.
2. Apply balanced fertilizer, especially potassium.
3. Avoid excessive use of nitrogen.
4. Remove and destroy infected plant debris.
5. Maintain proper field drainage.''',
    'Blast': '''1. Plant resistant varieties and certified seeds.
2. Apply fungicides such as tricyclazole at early signs.
3. Avoid high nitrogen fertilizer rates.
4. Maintain proper spacing to reduce humidity.
5. Remove and destroy infected plant residues.''',
    'Brown Spot': '''1. Use disease-free seeds and resistant varieties.
2. Apply balanced fertilizers, especially potassium and zinc.
3. Improve field drainage and avoid water stress.
4. Apply fungicides if necessary.
5. Practice crop rotation.''',
    'Tungro': '''1. Use resistant rice varieties.
2. Control green leafhopper populations with insecticides.
3. Remove and destroy infected plants.
4. Transplant healthy seedlings only.
5. Avoid overlapping crops to break pest cycles.''',
    'Healthy':
        'No treatment needed. Maintain good field hygiene and monitor regularly.',
    'Leaf Scald': '''1. Use resistant varieties if available.
2. Avoid excessive nitrogen application.
3. Remove and destroy infected plant debris.
4. Improve field drainage and avoid waterlogging.
5. Apply fungicides if disease pressure is high.''',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return RiceDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class RiceDiseaseModel extends DiseaseModel {
  RiceDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
