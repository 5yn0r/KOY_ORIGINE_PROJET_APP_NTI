import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/lesson_model.dart';
import 'package:myapp/screens/modules/lesson_detail_screen.dart';
import 'package:myapp/screens/quiz/quiz_screen.dart';
import 'package:myapp/services/lesson_service.dart';

class LessonsListScreen extends StatefulWidget {
  final String moduleId;

  const LessonsListScreen({super.key, required this.moduleId});

  @override
  State<LessonsListScreen> createState() => _LessonsListScreenState();
}

class _LessonsListScreenState extends State<LessonsListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LessonService lessonService = LessonService();
    final Color primaryColor = Color(0xFF6B4FAD);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leçons',
          style: GoogleFonts.zillaSlab(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryColor,
                Color(0xFF9C6FD8),
              ],
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F7FF).withOpacity(0.95),
              Color(0xFFE8E0FF).withOpacity(0.95),
            ],
          ),
        ),
        child: StreamBuilder<List<Lesson>>(
          stream: lessonService.getLessons(widget.moduleId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Une erreur est survenue lors du chargement des leçons.',
                  style: GoogleFonts.lato(color: Colors.red.shade700),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Aucune leçon disponible pour ce module.',
                  style: GoogleFonts.lato(fontSize: 16),
                ),
              );
            }

            final lessons = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(
                      index * 0.1,
                      0.6 + (index * 0.1),
                      curve: Curves.easeOut,
                    ),
                  ),
                );
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.3, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: _buildLessonTile(context, lesson, primaryColor),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLessonTile(
    BuildContext context,
    Lesson lesson,
    Color primaryColor,
  ) {
    final iconColor = lesson.type == 'quiz' 
        ? Colors.purple.shade300  // Violet clair pour les quiz
        : primaryColor;  // Couleur primaire pour les autres
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: primaryColor.withOpacity(0.2),
          highlightColor: primaryColor.withOpacity(0.1),
          onTap: () {
            _navigateToLesson(context, lesson);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(
                  color: lesson.type == 'quiz' ? Colors.purple : primaryColor,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        iconColor.withOpacity(0.3),
                        iconColor.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Icon(
                    _getIconForLessonType(lesson.type),
                    color: iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.type == 'quiz' ? 'Quiz de révision' : 'Leçon détaillée',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: primaryColor.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToLesson(BuildContext context, Lesson lesson) {
    if (lesson.type == 'quiz') {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => QuizScreen(
            questions: lesson.quizQuestions,
            quizId: lesson.id,
            lessonName: lesson.title,
            moduleName: widget.moduleId,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) =>
              LessonDetailScreen(lesson: lesson),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;

            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  IconData _getIconForLessonType(String type) {
    switch (type) {
      case 'quiz':
        return Icons.quiz;
      case 'reading':
        return Icons.book;
      case 'video':
        return Icons.videocam;
      default:
        return Icons.school;
    }
  }
}
