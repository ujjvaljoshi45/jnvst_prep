import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiController {
  String apiKey = "";
  late GenerativeModel gemini;
  late ChatSession session;
  GeminiController._internal();
  static GeminiController instance = GeminiController._internal();

  void initGemini() {
    gemini = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
      systemInstruction: Content.system(
          "Respond ONLY to Queries Releated To JNVST Exam and it's preparation And Use Emojis"),
      generationConfig: GenerationConfig(temperature: 0.9),
      safetySettings: [
        SafetySetting(
          HarmCategory.hateSpeech,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.harassment,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.dangerousContent,
          HarmBlockThreshold.none,
        ),
        SafetySetting(
          HarmCategory.sexuallyExplicit,
          HarmBlockThreshold.none,
        ),
      ],
    );
    session = gemini.startChat();
  }

  Future<String> promptAi(String text) async {
    try {
      GenerateContentResponse response =
          await session.sendMessage(Content.text(text));
      if (response.text != null) {
        return response.text!;
      } else {
        return "Unable To Answer that!";
      }
    } catch (e) {
      return "Unable To Answer that!";
    }
  }
}
