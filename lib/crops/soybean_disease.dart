// lib/crops/soybean_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class SoybeanDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Soybean Rust',
    1: 'Bacterial Blight',
    2: 'Frogeye Leaf Spot',
    3: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Soybean Rust':
        'A fungal disease that causes reddish-brown pustules on leaves, reducing yield.',
    'Bacterial Blight':
        'A bacterial disease that causes water-soaked lesions on leaves and stems.',
    'Frogeye Leaf Spot':
        'A fungal disease that produces circular spots with a dark border on leaves.',
    'Healthy': 'No visible symptoms of disease.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return SoybeanDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class SoybeanDiseaseModel extends DiseaseModel {
  SoybeanDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(
         name: name,
         description: description,
         cropId: cropId,
         cure: "cure",
       );
}
