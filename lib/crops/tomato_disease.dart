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
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return TomatoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class TomatoDiseaseModel extends DiseaseModel {
  TomatoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
