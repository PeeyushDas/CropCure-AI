// lib/crops/mango_diseases.dart
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
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return MangoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class MangoDiseaseModel extends DiseaseModel {
  MangoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
