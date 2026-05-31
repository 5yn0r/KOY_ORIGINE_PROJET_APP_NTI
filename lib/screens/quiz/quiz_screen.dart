import 'package:flutter/material.dart';
import 'package:myapp/models/quiz_question.dart';
import 'package:myapp/services/firestore_service.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> questions;
  final String quizId;
  final String lessonName;
  final String moduleName;

  const QuizScreen({
    super.key,
    required this.questions,
    required this.quizId,
    required this.lessonName,
    required this.moduleName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _showConfetti = false;

  void _answerQuestion(int selectedIndex) {
    setState(() {
      _selectedAnswerIndex = selectedIndex;
      if (selectedIndex ==
          widget.questions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return; // Vérification si le widget est toujours monté
      if (_currentQuestionIndex < widget.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswerIndex = null;
        });
      } else {
        _showResults();
      }
    });
  }

  Future<ModuleValidationResult> _updateUserProgress() async {
    return _firestoreService.recordQuizResult(
      moduleId: widget.moduleName,
      quizId: widget.quizId,
      quizName: widget.lessonName,
      score: _score,
      totalQuestions: widget.questions.length,
    );
  }

  void _showResults() {
    _updateUserProgress().then((result) {
      if (!mounted) return; // Vérification si le widget est toujours monté
      if (result.newlyValidated) {
        setState(() => _showConfetti = true);
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(
            result.newlyValidated
                ? 'Module validé !'
                : result.quizPassed
                ? 'Quiz réussi !'
                : 'Quiz terminé',
          ),
          content: Text(_buildResultMessage(result)),
          actions: [
            TextButton(
              onPressed: () {
                setState(() => _showConfetti = false);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Retour aux modules'),
            ),
          ],
        ),
      );
    });
  }

  String _buildResultMessage(ModuleValidationResult result) {
    final scoreLine = 'Votre score : $_score / ${widget.questions.length}.';
    if (result.newlyValidated) {
      return '$scoreLine\n\nBravo, tous les quiz requis du module sont réussis. La progression a été mise à jour.';
    }
    if (result.moduleValidated) {
      return '$scoreLine\n\nCe module était déjà validé. La progression ne s’incrémente pas une deuxième fois.';
    }
    if (result.quizPassed) {
      return '$scoreLine\n\nQuiz réussi. Terminez les autres quiz du module avec au moins la moitié des réponses justes pour valider le module.';
    }
    return '$scoreLine\n\nIl faut réussir au moins la moitié des questions pour que ce quiz compte dans la validation du module.';
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz - Question ${_currentQuestionIndex + 1}/${widget.questions.length}',
            style: const TextStyle(fontSize: 18),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ...List.generate(question.options.length, (index) {
                    return _buildOption(
                      context,
                      index,
                      question.options[index],
                    );
                  }),
                ],
              ),
            ),
            if (_showConfetti) const _ConfettiCelebration(),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, String text) {
    Color? tileColor;
    if (_selectedAnswerIndex != null) {
      if (index == widget.questions[_currentQuestionIndex].correctAnswerIndex) {
        tileColor = Colors.green.shade100;
      } else if (index == _selectedAnswerIndex) {
        tileColor = Colors.red.shade100;
      }
    }

    return Card(
      color: tileColor,
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        // Utilisation de bodyLarge pour le texte des options
        title: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onTap: _selectedAnswerIndex == null
            ? () => _answerQuestion(index)
            : null,
      ),
    );
  }
}

class _ConfettiCelebration extends StatefulWidget {
  const _ConfettiCelebration();

  @override
  State<_ConfettiCelebration> createState() => _ConfettiCelebrationState();
}

class _ConfettiCelebrationState extends State<_ConfettiCelebration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const List<_ConfettiPiece> _pieces = [
    _ConfettiPiece(0.08, Colors.purple, 0.1),
    _ConfettiPiece(0.18, Colors.orange, 0.32),
    _ConfettiPiece(0.28, Colors.green, 0.18),
    _ConfettiPiece(0.38, Colors.blue, 0.44),
    _ConfettiPiece(0.52, Colors.pink, 0.24),
    _ConfettiPiece(0.64, Colors.teal, 0.38),
    _ConfettiPiece(0.76, Colors.amber, 0.12),
    _ConfettiPiece(0.88, Colors.redAccent, 0.3),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: _pieces.map((piece) {
              final screen = MediaQuery.of(context).size;
              final fall = (_controller.value + piece.delay) % 1;
              return Positioned(
                left: screen.width * piece.x,
                top: screen.height * fall,
                child: Transform.rotate(
                  angle: fall * 6.28,
                  child: Container(
                    width: 10,
                    height: 16,
                    decoration: BoxDecoration(
                      color: piece.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _ConfettiPiece {
  final double x;
  final Color color;
  final double delay;

  const _ConfettiPiece(this.x, this.color, this.delay);
}
