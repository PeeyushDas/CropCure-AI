import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class MangoDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Anthracnose',
    1: 'Bacterial Canker',
    2: 'Cutting Weevil',
    3: 'Die Back',
    4: 'Gall Midge',
    5: 'Healthy',
    6: 'Powdery Mildew',
    7: 'Sooty Mould',
  };

  static const Map<String, String> _descriptions = {
    'Anthracnose':
        'A fungal disease that causes dark, sunken lesions on fruit and leaves.',
    'Bacterial Canker':
        'A bacterial disease that causes wilting and dieback of branches and leaves.',
    'Cutting Weevil':
        'A pest that causes damage to stems and leaves, leading to reduced yield.',
    'Die Back':
        'A condition where the tips of branches die back, often due to environmental stress.',
    'Gall Midge':
        'A pest that causes galls on leaves, leading to reduced photosynthesis.',
    'Healthy': 'No visible symptoms of disease.',
    'Powdery Mildew':
        'A fungal disease that produces a white powdery coating on leaves and stems.',
    'Sooty Mould':
        'A fungal disease that produces a black coating on leaves, often due to honeydew from pests.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Anthracnose': '''1. Prune and destroy infected plant parts.
2. Apply copper-based fungicides during flowering and fruit set.
3. Avoid overhead irrigation and ensure good air circulation.''',
    'Bacterial Canker': '''1. Prune and destroy affected branches.
2. Apply copper oxychloride sprays after pruning.
3. Disinfect pruning tools between cuts.''',
    'Cutting Weevil': '''1. Collect and destroy infested plant parts.
2. Apply recommended insecticides to affected areas.
3. Practice field sanitation and remove weeds.''',
    'Die Back': '''1. Prune dead and affected branches.
2. Apply fungicides such as carbendazim to cut surfaces.
3. Improve tree vigor with balanced fertilization and irrigation.''',
    'Gall Midge': '''1. Remove and destroy infested leaves and shoots.
2. Apply suitable insecticides at the early stage of infestation.
3. Maintain field hygiene and monitor regularly.''',
    'Healthy': 'No treatment needed. Maintain good orchard hygiene.',
    'Powdery Mildew':
        '''1. Apply sulfur-based or systemic fungicides at first sign of disease.
2. Prune overcrowded branches to improve air flow.
3. Avoid excessive nitrogen fertilization.''',
    'Sooty Mould':
        '''1. Control sap-sucking insects (like aphids, mealybugs) with insecticides.
2. Wash affected leaves with water if practical.
3. Prune and destroy heavily infested plant parts.''',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return MangoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class MangoDiseaseModel extends DiseaseModel {
  MangoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
