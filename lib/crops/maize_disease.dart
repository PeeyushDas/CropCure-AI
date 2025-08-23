// lib/crops/maize_diseases.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';

class MaizeDiseaseHandler implements CropDiseaseHandler {
  static const Map<int, String> _diseaseNames = {
    0: 'Blight',
    1: 'Common Rust',
    2: 'Gray Leaf Spot',
    3: 'Healthy',
  };

  static const Map<String, String> _descriptions = {
    'Blight':
        'A fungal disease that causes rapid wilting and death of the plant, often affecting the leaves.',
    'Common Rust':
        'A fungal disease that produces reddish-brown pustules on leaves, reducing photosynthesis.',
    'Gray Leaf Spot':
        'A fungal disease that causes gray lesions on leaves, leading to reduced yield.',
    'Healthy': 'No visible symptoms of disease.',
  };

  @override
  DiseaseModel createDisease(int prediction, int cropId) {
    final diseaseName = _diseaseNames[prediction] ?? 'Unknown Disease';
    final description =
        _descriptions[diseaseName] ??
        'Information about this disease is currently unavailable.';

    return MaizeDiseaseModel(
      name: diseaseName,
      description: description,
      cropId: cropId,
    );
  }
}

class MaizeDiseaseModel extends DiseaseModel {
  MaizeDiseaseModel({
    required String name,
    required String description,
    required int cropId,
  }) : super(name: name, description: description, cropId: cropId);
}
