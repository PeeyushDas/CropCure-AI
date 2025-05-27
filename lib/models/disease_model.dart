class DiseaseModel {
  final String name;
  final String description;
  final int cropId;

  DiseaseModel({
    required this.name,
    required this.description,
    required this.cropId,
  });

  // Factory method to create a disease model from a prediction code and crop ID
  factory DiseaseModel.fromPrediction(int prediction, int cropId) {
    String name;

    // Select disease based on crop type and prediction
    switch (cropId) {
      case 0: // Rice
        switch (prediction) {
          case 0:
            name = 'Bacterial Blight';
            break;
          case 1:
            name = 'Blast';
            break;
          case 2:
            name = 'Brown Spot';
            break;
          case 3:
            name = 'Tungro';
            break;
          default:
            name = 'Unknown Disease';
        }
        break;
      case 1: // Wheat
        switch (prediction) {
          case 0:
            name = 'Leaf Rust';
            break;
          case 1:
            name = 'Powdery Mildew';
            break;
          case 2:
            name = 'Septoria';
            break;
          default:
            name = 'Unknown Disease';
        }
        break;
      // Add cases for other crops
      default:
        name = 'Unknown Disease';
    }

    return DiseaseModel(
      name: name,
      description: getDescriptionForDisease(name, cropId),
      cropId: cropId,
    );
  }

  // Get description based on disease name and crop ID
  static String getDescriptionForDisease(String diseaseName, int cropId) {
    // Rice disease descriptions
    final Map<String, String> riceDescriptions = {
      'Bacterial Blight':
          'A serious bacterial disease that causes wilting of seedlings and yellowing and drying of leaves.',
      'Blast':
          'A fungal disease that affects leaves, stems, peduncles, panicles, seeds and roots.',
      'Brown Spot':
          'A fungal disease that produces brown lesions or spots on the leaves and glumes of rice.',
      'Tungro':
          'A viral disease transmitted by leafhoppers, causing yellow or orange discoloration of leaves.',
    };

    // Wheat disease descriptions
    final Map<String, String> wheatDescriptions = {
      'Leaf Rust':
          'A fungal disease appearing as orange-brown pustules on leaves, reducing photosynthesis.',
      'Powdery Mildew':
          'A fungal disease creating white powdery spots on leaves and stems.',
      'Septoria':
          'A fungal disease causing distinctive leaf blotches with brown margins.',
    };

    // Select description map based on crop ID
    Map<String, String> descriptionMap;
    switch (cropId) {
      case 0:
        descriptionMap = riceDescriptions;
        break;
      case 1:
        descriptionMap = wheatDescriptions;
        break;
      // Add cases for other crops
      default:
        descriptionMap = {};
    }

    // Return description or default message
    return descriptionMap[diseaseName] ??
        'Information about this disease is currently unavailable.';
  }
}
