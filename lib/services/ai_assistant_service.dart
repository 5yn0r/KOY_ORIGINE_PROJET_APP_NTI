// Représente un message dans le chat.
class AssistantMessage {
  final String text;
  final bool isFromUser;

  AssistantMessage({required this.text, required this.isFromUser});
}

class AiAssistantService {
  // Génère une réponse statique pour contourner le problème de build.
  Future<String> getResponse(String userInput) async {
    // Simule une petite attente réseau
    await Future.delayed(const Duration(milliseconds: 500));

    userInput = userInput.toLowerCase();

    if (userInput.contains("bonjour") || userInput.contains("salut")) {
      return "Akwaaba ! Je suis N'TI, votre assistant pour l'apprentissage du Baoulé. Comment puis-je vous aider aujourd'hui ?";
    } else if (userInput.contains("merci")) {
      return "Ani so ! De rien. N'hésitez pas si vous avez d'autres questions.";
    } else {
      return "C'est une excellente question. La fonctionnalité de l'assistant IA est en cours de développement. Pour l'instant, je ne peux pas répondre à des questions complexes. Revenez bientôt pour découvrir la version complète !";
    }
  }

  Future generateResponse(String text) async {}
}
