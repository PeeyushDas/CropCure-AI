import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class PotatoDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Late Blight',
    1: 'Early Blight',
    2: 'Black Leg',
    3: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Late Blight':
        'A serious fungal disease that causes dark lesions on leaves and stems, leading to plant death.',
    'Early Blight':
        'A fungal disease that causes dark spots on leaves, leading to premature leaf drop.',
    'Black Leg':
        'A bacterial disease that causes blackening of the stem and wilting of the plant.',
    'Healthy': 'No visible symptoms of disease.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Late Blight': '''1. Use certified disease-free seed potatoes.
2. Apply fungicides such as mancozeb or chlorothalonil at regular intervals.
3. Remove and destroy infected plants and tubers.
4. Practice crop rotation and avoid overhead irrigation.''',
    'Early Blight': '''1. Use resistant potato varieties if available.
2. Apply fungicides like chlorothalonil or azoxystrobin at first sign of disease.
3. Remove and destroy infected plant debris after harvest.
4. Avoid overhead irrigation and ensure good field drainage.''',
    'Black Leg': '''1. Use only healthy, certified seed potatoes.
2. Remove and destroy infected plants immediately.
3. Avoid planting in poorly drained soils.
4. Practice crop rotation and sanitize equipment regularly.''',
    'Healthy':
        'No treatment needed. Maintain good field hygiene and monitor regularly.',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return PotatoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class PotatoDiseaseModel extends DiseaseModel {
  PotatoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
