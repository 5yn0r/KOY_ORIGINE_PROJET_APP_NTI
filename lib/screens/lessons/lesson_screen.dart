import 'package:flutter/material.dart';
import 'package:myapp/models/quiz_question.dart';
import 'package:myapp/screens/quiz/quiz_screen.dart';

// Modèle de données
class Lesson {
  final String title;
  final String content;
  final List<String> examples;
  final List<QuizQuestion> quiz;
  final String moduleName;

  const Lesson({
    required this.title,
    required this.content,
    required this.examples,
    required this.quiz,
    required this.moduleName,
  });
}

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lesson.title,
          style: const TextStyle(fontSize: 18),
        ), // Taille de police ajustée
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.content,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 32),
            _buildExamplesSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildStartQuizButton(context),
    );
  }

  Widget _buildExamplesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exemples :',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // On passe maintenant le context à la méthode _buildExampleCard
        ...lesson.examples.map(
          (example) => _buildExampleCard(context, example),
        ),
      ],
    );
  }

  // La méthode accepte maintenant le BuildContext
  Widget _buildExampleCard(BuildContext context, String example) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          example,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildStartQuizButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                questions: lesson.quiz,
                quizId: lesson.title,
                lessonName: lesson.title,
                moduleName: lesson.moduleName,
              ),
            ),
          );
        },
        child: const Text('Commencer le Quiz'),
      ),
    );
  }
}
