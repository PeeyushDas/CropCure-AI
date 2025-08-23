// lib/crops/potato_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class PotatoDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Late Blight',
    1: 'Early Blight',
    2: 'Black Leg',
  };

  static const Map<String, String> _descriptions = {
    'Late Blight':
        'A serious fungal disease that causes dark lesions on leaves and stems, leading to plant death.',
    'Early Blight':
        'A fungal disease that causes dark spots on leaves, leading to premature leaf drop.',
    'Black Leg':
        'A bacterial disease that causes blackening of the stem and wilting of the plant.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return PotatoDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class PotatoDiseaseModel extends DiseaseModel {
  PotatoDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
