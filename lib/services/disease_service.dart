import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rice_app/models/disease_model.dart';

class DiseaseService {
  // API endpoints for different crops
  static const Map<int, String> _apiEndpoints = {
    0: "https://server-rice.onrender.com/predict/",
    1: "https://server-wheat.onrender.com/predict/",
    2: "https://server-maize.onrender.com/predict/",
    3: "https://potato-server.onrender.com/predict/",
    4: "https://server-tomato.onrender.com/predict/",
    5: "https://soybean.onrender.com/predict/",
    6: "https://server-orange.onrender.com/predict/",
    7: "https://server-apple.onrender.com/predict/",
    8: "https://server-mango.onrender.com/predict/",
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
