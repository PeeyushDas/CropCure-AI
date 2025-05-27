import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rice_app/models/disease_model.dart';

class DiseaseService {
  // API endpoints for different crops
  static const Map<int, String> _apiEndpoints = {
    0: "https://rice-server-j666.onrender.com/predict/",
    1: "https://wheat-server.onrender.com/predict/",
    2: "https://maize-server.onrender.com/predict/",
    3: "https://cereals-server.onrender.com/predict/",
    4: "https://shree-ann-server.onrender.com/predict/",
    5: "https://tur-server.onrender.com/predict/",
    6: "https://gram-server.onrender.com/predict/",
  };

  // Get the appropriate API endpoint for a crop
  String _getApiEndpointForCrop(int cropId) {
    return _apiEndpoints[cropId] ?? _apiEndpoints[0]!;
  }

  // Upload image to server and get prediction
  Future<DiseaseModel> predictDisease(File imageFile, int cropId) async {
    try {
      String apiEndpoint = _getApiEndpointForCrop(cropId);

      var request = http.MultipartRequest('POST', Uri.parse(apiEndpoint));
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      // Parse the response
      var result = json.decode(responseData);
      int prediction = result['prediction'];

      // Convert prediction to disease model with crop type
      return DiseaseModel.fromPrediction(prediction, cropId);
    } catch (e) {
      rethrow;
    }
  }
}
