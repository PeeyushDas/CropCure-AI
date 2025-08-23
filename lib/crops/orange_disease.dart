// lib/crops/orange_diseases.dart
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
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return OrangeDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class OrangeDiseaseModel extends DiseaseModel {
  OrangeDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
