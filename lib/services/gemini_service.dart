import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:rice_app/config/api_constants.dart';

class GeminiService {
  late final GenerativeModel _model;
  ChatSession? _chat;
  bool _isInitialized = false;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: ApiConstants.GEMINI_API_KEY,
    );
  }

  Future<void> initializeChat(String diseaseName, String cropName) async {
    if (!_isInitialized) {
      _chat = _model.startChat(
        history: [
          Content.text(
            'You are an AI assistant helping farmers with crop diseases. '
            'The current crop under discussion is: $cropName. '
            'The current disease being discussed is: $diseaseName. '
            'Please provide specific, actionable advice.'
            'The response should be short and concise.',
          ),
        ],
      );
      _isInitialized = true;
    }
  }

  Future<String> getChatResponse(
    String prompt,
    String diseaseName,
    String cropName,
  ) async {
    try {
      await initializeChat(diseaseName, cropName);

      final response = await _chat!.sendMessage(Content.text(prompt));
      return response.text ?? 'Sorry, I could not generate a response.';
    } catch (e) {
      print('Gemini Error: $e');
      return 'Error: Unable to generate response';
    }
  }

  void resetChat() {
    _chat = null;
    _isInitialized = false;
  }
}
