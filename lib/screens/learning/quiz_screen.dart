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
  bool _isAnswered = false;
  int? _selectedAnswerIndex;

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
        _selectedAnswerIndex = null;
      });
    } else {
      // Fin du quiz
      _showResultDialog();
    }
  }

  void _answerQuestion(int selectedIndex) {
    if (_isAnswered) return; // Empêche de répondre plusieurs fois

    final isCorrect =
        selectedIndex ==
        widget.quizQuestions[_currentQuestionIndex].correctAnswerIndex;

    setState(() {
      _isAnswered = true;
      _selectedAnswerIndex = selectedIndex;
      if (isCorrect) {
        _score++;
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Résultats du Quiz'),
        content: Text('Votre score : $_score / ${widget.quizQuestions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme la boîte de dialogue
              Navigator.pop(context); // Revient à l'écran de la leçon
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quizQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: Text('Pas de questions pour ce quiz.')),
      );
    }

    final currentQuestion = widget.quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz : Question ${_currentQuestionIndex + 1}/${widget.quizQuestions.length}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            ...List.generate(currentQuestion.options.length, (index) {
              Color buttonColor = Colors.grey.shade300;
              if (_isAnswered) {
                if (index == currentQuestion.correctAnswerIndex) {
                  buttonColor = Colors.green;
                } else if (index == _selectedAnswerIndex) {
                  buttonColor = Colors.red;
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(index),
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  child: Text(currentQuestion.options[index]),
                ),
              );
            }),
            const Spacer(),
            if (_isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(
                  _currentQuestionIndex < widget.quizQuestions.length - 1
                      ? 'Question suivante'
                      : 'Voir les résultats',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
