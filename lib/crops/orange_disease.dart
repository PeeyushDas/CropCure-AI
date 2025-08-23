import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class OrangeDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Citrus Canker',
    1: 'Citrus Greening',
    2: 'Citrus Mealybugs',
    3: 'Die black',
    4: 'Foilage Damaged',
    5: 'Healthy',
    6: 'Powdery Mildew',
    7: 'Shot Hole',
    8: 'Spiny Whitefly',
    9: 'Yellow Dragon',
    10: 'Yellow leaves',
  };

  static const Map<String, String> _descriptions = {
    'Citrus Canker':
        'A bacterial disease that causes lesions on leaves, stems, and fruit, leading to premature drop.',
    'Citrus Greening':
        'A viral disease that causes yellowing of leaves and stunted growth, transmitted by psyllids.',
    'Citrus Mealybugs':
        'Pests that cause yellowing and wilting of leaves, leading to reduced yield.',
    'Die black':
        'A fungal disease that causes blackening of leaves and stems, leading to plant death.',
    'Foilage Damaged':
        'Damage to foliage caused by pests or diseases, leading to reduced photosynthesis.',
    'Healthy': 'No visible symptoms of disease.',
    'Powdery Mildew':
        'A fungal disease that produces a white powdery coating on leaves and stems.',
    'Shot Hole':
        'A fungal disease that causes holes in leaves, often due to environmental stress.',
    'Spiny Whitefly':
        'A pest that causes yellowing and wilting of leaves, leading to reduced yield.',
    'Yellow Dragon':
        'A viral disease that causes yellowing and stunted growth of plants.',
    'Yellow leaves':
        'Yellowing of leaves often due to nutrient deficiencies or environmental stress.',
    'Unknown Disease':
        'Information about this disease is currently unavailable.',
  };

  static const Map<String, String> _cures = {
    'Citrus Canker': '''1. Remove and destroy infected plant material.
2. Apply copper-based bactericides regularly during the growing season.
3. Avoid working in wet conditions to prevent disease spread.
4. Use disease-free planting material.''',
    'Citrus Greening':
        '''1. Remove and destroy infected trees to prevent spread.
2. Control psyllid vectors using insecticides.
3. Use disease-free nursery stock for new plantings.
4. Monitor regularly and report new cases to authorities.''',
    'Citrus Mealybugs': '''1. Release natural predators such as lady beetles.
2. Apply horticultural oils or insecticidal soaps to infested areas.
3. Prune and destroy heavily infested branches.
4. Maintain orchard hygiene and remove weeds.''',
    'Die black': '''1. Prune and destroy affected branches and twigs.
2. Apply appropriate fungicides to wounds and cut surfaces.
3. Improve air circulation by proper spacing and pruning.
4. Avoid waterlogging and ensure good drainage.''',
    'Foilage Damaged':
        '''1. Identify and control the underlying pest or disease.
2. Remove and destroy damaged leaves.
3. Apply recommended pesticides or fungicides as needed.
4. Maintain plant nutrition and reduce stress factors.''',
    'Healthy':
        'No treatment needed. Maintain good orchard hygiene and regular monitoring.',
    'Powdery Mildew':
        '''1. Apply sulfur-based or systemic fungicides at first sign of disease.
2. Prune overcrowded branches to improve air flow.
3. Avoid excessive nitrogen fertilization.
4. Remove and destroy infected plant parts.''',
    'Shot Hole': '''1. Remove and destroy affected leaves and twigs.
2. Apply copper-based fungicides during wet weather.
3. Avoid overhead irrigation to reduce leaf wetness.
4. Maintain good orchard sanitation.''',
    'Spiny Whitefly': '''1. Release natural enemies such as Encarsia species.
2. Apply insecticidal soaps or horticultural oils to infested leaves.
3. Prune and destroy heavily infested plant parts.
4. Monitor regularly and control ant populations.''',
    'Yellow Dragon': '''1. Remove and destroy infected plants immediately.
2. Control psyllid vectors with insecticides.
3. Use certified disease-free planting material.
4. Monitor and report new cases promptly.''',
    'Yellow leaves':
        '''1. Test soil and correct nutrient deficiencies, especially nitrogen, magnesium, or iron.
2. Ensure proper watering and avoid waterlogging.
3. Remove and destroy severely affected leaves.
4. Apply foliar fertilizers if needed.''',
    'Unknown Disease': 'Consult a local agricultural extension for advice.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ?? _descriptions['Unknown Disease']!;
    final cure = _cures[diseaseName] ?? _cures['Unknown Disease']!;
    return OrangeDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
      cure: cure,
    );
  }
}

class OrangeDiseaseModel extends DiseaseModel {
  OrangeDiseaseModel({
    required String name,
    required String description,
    required int cropId,
    required String cure,
  }) : super(name: name, description: description, cropId: cropId, cure: cure);
}
