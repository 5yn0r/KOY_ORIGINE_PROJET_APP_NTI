import 'package:flutter/material.dart';
import 'package:myapp/models/learning_models.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> quizQuestions;

  const QuizScreen({super.key, required this.quizQuestions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex ==
        widget.quizQuestions[_currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < widget.quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Afficher les résultats
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quiz Terminé'),
          content: Text(
            'Votre score : $_score / ${widget.quizQuestions.length}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quizQuestions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}/${widget.quizQuestions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion.question,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 32),
            ...currentQuestion.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              return ElevatedButton(
                onPressed: () => _answerQuestion(index),
                child: Text(option),
              );
            }),
          ],
        ),
      ),
    );
  }
}
