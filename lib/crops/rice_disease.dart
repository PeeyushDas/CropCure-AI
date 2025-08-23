// lib/crops/rice_diseases.dart
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
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return RiceDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class RiceDiseaseModel extends DiseaseModel {
  RiceDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
