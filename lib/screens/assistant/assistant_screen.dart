import 'package:flutter/material.dart';
import 'package:myapp/services/ai_assistant_service.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final AiAssistantService _assistantService = AiAssistantService();
  final TextEditingController _textController = TextEditingController();
  final List<AssistantMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ajouter un message de bienvenue initial de l'assistant
    _messages.add(
      AssistantMessage(
        text:
            'Bonjour ! Je suis votre assistant N\'TI. Posez-moi une question sur la langue ou la culture Baoulé.',
        isUser: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('N\'TI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          _buildChatComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(AssistantMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildChatComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Posez votre question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = AssistantMessage(text: text, isUser: true);
    setState(() {
      _messages.insert(0, userMessage);
      _isLoading = true;
    });

    _textController.clear();

    try {
      final response = await _assistantService.generateResponse(text);
      final assistantMessage = AssistantMessage(text: response, isUser: false);
      setState(() {
        _messages.insert(0, assistantMessage);
      });
    } catch (e) {
      final errorMessage = AssistantMessage(
        text: 'Désolé, une erreur est survenue.',
        isUser: false,
      );
      setState(() {
        _messages.insert(0, errorMessage);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class AssistantMessage {
  final String text;
  final bool isUser;

  AssistantMessage({required this.text, required this.isUser});
}
