import 'package:flutter/material.dart';
import 'package:myapp/models/learning_models.dart';
import 'package:myapp/screens/learning/quiz_screen.dart'; // Importer l'écran du quiz

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contenu de la leçon',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Permettre le défilement si le contenu est long
            Expanded(child: SingleChildScrollView(child: Text(lesson.content))),
            const SizedBox(height: 24),
            // Centrer le bouton du quiz
            if (lesson.quiz.isNotEmpty)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Naviguer vers l'écran du quiz
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizScreen(quizQuestions: lesson.quiz),
                      ),
                    );
                  },
                  child: const Text('Commencer le Quiz'),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
