// lib/crops/tomato_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class TomatoDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Bacterial Spot',
    1: 'Early Blight',
    2: 'Late Blight',
    3: 'Leaf Mold',
    4: 'Septoria Leaf Spot',
    5: 'Spider Mites',
    6: 'Target Spot',
    7: 'Tomato Yellow Leaf Curl Virus',
    8: 'Tomato Mosaic Virus',
    9: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Bacterial Spot':
        'A bacterial disease that causes dark, water-soaked spots on leaves and stems.',
    'Early Blight':
        'A fungal disease that causes dark spots on leaves, leading to premature leaf drop.',
    'Late Blight':
        'A serious fungal disease that causes dark lesions on leaves and stems, leading to plant death.',
    'Leaf Mold':
        'A fungal disease that causes yellowing and wilting of leaves, often in humid conditions.',
    'Septoria Leaf Spot':
        'A fungal disease that produces small, circular spots on leaves, leading to reduced yield.',
    'Spider Mites':
        'A pest that causes stippling and discoloration of leaves, leading to reduced photosynthesis.',
    'Target Spot':
        'A fungal disease that produces dark spots with concentric rings on leaves.',
    'Tomato Yellow Leaf Curl Virus':
        'A viral disease that causes yellowing and curling of leaves, reducing yield.',
    'Tomato Mosaic Virus':
        'A viral disease that causes mottling and discoloration of leaves and fruit.',
    'Healthy': 'No visible symptoms of disease.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Bacterial Spot': '''1. Use certified disease-free seeds and transplants.
2. Apply copper-based bactericides at first sign of disease.
3. Avoid overhead irrigation and working with wet plants.
4. Remove and destroy infected plant debris.''',
    'Early Blight': '''1. Use resistant tomato varieties if available.
2. Apply fungicides such as chlorothalonil or mancozeb at first sign of disease.
3. Remove and destroy infected leaves and plant debris.
4. Practice crop rotation and avoid overhead irrigation.''',
    'Late Blight': '''1. Use resistant varieties and certified seeds.
2. Apply fungicides such as chlorothalonil or mancozeb at regular intervals.
3. Remove and destroy infected plants immediately.
4. Avoid overhead irrigation and practice crop rotation.''',
    'Leaf Mold': '''1. Improve air circulation by pruning and proper spacing.
2. Apply fungicides such as chlorothalonil or copper-based products.
3. Avoid overhead watering and reduce humidity in greenhouses.
4. Remove and destroy infected leaves.''',
    'Septoria Leaf Spot': '''1. Remove and destroy infected leaves.
2. Apply fungicides such as chlorothalonil or mancozeb.
3. Avoid overhead irrigation and water early in the day.
4. Practice crop rotation and maintain field hygiene.''',
    'Spider Mites': '''1. Spray plants with water to dislodge mites.
2. Use insecticidal soap or horticultural oil.
3. Introduce natural predators such as ladybugs.
4. Remove and destroy heavily infested leaves.''',
    'Target Spot': '''1. Remove and destroy infected leaves.
2. Apply fungicides such as chlorothalonil or mancozeb.
3. Ensure good air circulation and avoid overhead irrigation.
4. Practice crop rotation.''',
    'Tomato Yellow Leaf Curl Virus':
        '''1. Control whitefly populations with insecticides or yellow sticky traps.
2. Remove and destroy infected plants.
3. Use resistant tomato varieties if available.
4. Use insect-proof nets in nurseries.''',
    'Tomato Mosaic Virus': '''1. Remove and destroy infected plants.
2. Disinfect tools and hands after handling plants.
3. Avoid tobacco use near tomato plants.
4. Use resistant varieties if available.''',
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
    return TomatoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class TomatoDiseaseModel extends DiseaseModel {
  TomatoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
