import 'package:flutter/material.dart';

class ShortcutsCard extends StatelessWidget {
  final VoidCallback? onOpenLessons;
  final VoidCallback? onOpenQuiz;
  final VoidCallback? onOpenDictionary;
  final VoidCallback? onOpenChatbot;

  const ShortcutsCard({
    super.key,
    this.onOpenLessons,
    this.onOpenQuiz,
    this.onOpenDictionary,
    this.onOpenChatbot,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Raccourcis',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 3.4,
              children: [
                _buildShortcutButton(
                  context,
                  Icons.school_outlined,
                  'Leçons',
                  onOpenLessons,
                ),
                _buildShortcutButton(
                  context,
                  Icons.quiz_outlined,
                  'Quiz',
                  onOpenQuiz,
                ),
                _buildShortcutButton(
                  context,
                  Icons.menu_book_outlined,
                  'Dictionnaire',
                  onOpenDictionary,
                ),
                _buildShortcutButton(
                  context,
                  Icons.smart_toy_outlined,
                  'Chatbot',
                  onOpenChatbot,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(20),
        foregroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
      ),
    );
  }
}
