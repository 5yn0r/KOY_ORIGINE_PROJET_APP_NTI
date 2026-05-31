import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/providers/chatbot_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatbotProvider _chatbotProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _chatbotProvider = context.read<ChatbotProvider>();
        _chatbotProvider.setCurrentUserId(user.uid);
        _chatbotProvider.loadChatHistory(user.uid);
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    _chatbotProvider.sendMessage(message);
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F7FF).withValues(alpha: 0.95),
              Color(0xFFE8E0FF).withValues(alpha: 0.95),
            ],
          ),
        ),
        child: Stack(
          children: [
            Consumer<ChatbotProvider>(
              builder: (context, chatbotProvider, _) {
                _chatbotProvider = chatbotProvider;

                return Column(
                  children: [
                    // Messages
                    Expanded(
                      child: chatbotProvider.messages.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF6B4FAD).withValues(alpha: 0.1),
                                          Color(0xFF9C6FD8).withValues(alpha: 0.1),
                                        ],
                                      ),
                                    ),
                                    child: SpinKitWave(
                                      color: Theme.of(context).colorScheme.primary,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Bienvenue chez N\'ti IA !',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6B4FAD),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 8.0,
                              ),
                              itemCount: chatbotProvider.messages.length,
                              itemBuilder: (context, index) {
                                final message = chatbotProvider.messages[index];
                                final isUserMessage = message.sender == 'user';
                                
                                return ScaleTransition(
                                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: AlwaysStoppedAnimation(1.0),
                                      curve: Curves.easeOut,
                                    ),
                                  ),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(isUserMessage ? 0.3 : -0.3, 0),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: AlwaysStoppedAnimation(1.0),
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                    child: _buildMessageBubble(
                                      context,
                                      message,
                                      isUserMessage,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    // Affichage des erreurs
                    if (chatbotProvider.error != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                chatbotProvider.error!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Zone de saisie
                    _buildInputArea(context, chatbotProvider),
                  ],
                );
              },
            ),

            // Bouton flottant ⋮
            Positioned(
              top: 16,
              right: 16,
              child: PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _showClearConfirmDialog(context);
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.delete_outline, size: 20),
                        SizedBox(width: 8),
                        Text('Effacer la conversation'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    dynamic message,
    bool isUserMessage,
  ) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          gradient: isUserMessage
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6B4FAD),
                    Color(0xFF9C6FD8),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Color(0xFFF0F0FF).withValues(alpha: 0.9),
                  ],
                ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: (isUserMessage ? Color(0xFF6B4FAD) : Colors.black)
                  .withValues(alpha: 0.15),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Column(
          crossAxisAlignment:
              isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            SelectableText(
              message.text,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black87,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                fontSize: 11,
                color: isUserMessage
                    ? Colors.white.withValues(alpha: 0.7)
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(
    BuildContext context,
    ChatbotProvider chatbotProvider,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8E0FF).withValues(alpha: 0.95),
            Colors.white.withValues(alpha: 0.95),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: Color(0xFF6B4FAD).withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0xFFF8F7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6B4FAD).withValues(alpha: 0.1),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Posez une question en français ou baoulé...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 12.0,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
                enabled: !chatbotProvider.isLoading,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: chatbotProvider.isLoading
                    ? [
                        Color(0xFF6B4FAD).withValues(alpha: 0.6),
                        Color(0xFF9C6FD8).withValues(alpha: 0.6),
                      ]
                    : [
                        Color(0xFF6B4FAD),
                        Color(0xFF9C6FD8),
                      ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF6B4FAD).withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: IconButton(
              onPressed:
                  chatbotProvider.isLoading ? null : _sendMessage,
              icon: chatbotProvider.isLoading
                  ? SpinKitRing(
                      color: Colors.white,
                      lineWidth: 2,
                      size: 24,
                    )
                  : const Icon(Icons.send),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '${time.day}/${time.month} ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _showClearConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Effacer la conversation'),
          content: const Text(
            'Êtes-vous sûr de vouloir supprimer tout l\'historique de la conversation ? '
            'Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _chatbotProvider.clearConversation();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Conversation effacée'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Effacer'),
            ),
          ],
        );
      },
    );
  }
}