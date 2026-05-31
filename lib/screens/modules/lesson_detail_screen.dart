import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:myapp/models/lesson_model.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({super.key, required this.lesson});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen>
    with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLoadingAudio = false;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Lesson get lesson => widget.lesson;

  @override
  void initState() {
    super.initState();
    
    // Animation de fade-in
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    // Animation de slide
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    
    // Démarrer les animations
    _fadeController.forward();
    _slideController.forward();
    
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() => _isPlaying = false);
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6B4FAD),
                Color(0xFF9C6FD8),
              ],
            ),
          ),
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
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(),
                  const SizedBox(height: 20),
                  if (lesson.audioUrl != null && lesson.audioUrl!.isNotEmpty) ...[
                    _buildAudioCard(),
                    const SizedBox(height: 20),
                  ],
                  _buildContentSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6B4FAD).withOpacity(0.1),
            Color(0xFF9C6FD8).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF6B4FAD).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Text(
        lesson.title,
        style: GoogleFonts.zillaSlab(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF6B4FAD),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6B4FAD).withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        lesson.content,
        style: GoogleFonts.lato(
          fontSize: 16,
          height: 1.8,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAudioCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isPlaying
                  ? [Colors.blue.shade400, Colors.blue.shade600]
                  : [Colors.blue.shade300, Colors.blue.shade500],
            ),
            boxShadow: _isPlaying
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: IconButton.filledTonal(
            tooltip: _isPlaying ? 'Pause' : 'Lire',
            onPressed: _isLoadingAudio ? null : _toggleAudio,
            icon: _isLoadingAudio
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
          ),
        ),
        title: Text(
          'Audio de la leçon',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        subtitle: Text(
          'Écoutez la prononciation en baoulé.',
          style: GoogleFonts.lato(
            fontSize: 12,
            color: Colors.blue.shade600,
          ),
        ),
        trailing: _isPlaying
            ? AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return IconButton(
                    tooltip: 'Arrêter',
                    onPressed: () async {
                      await _audioPlayer.stop();
                      if (mounted) {
                        setState(() => _isPlaying = false);
                      }
                    },
                    icon: const Icon(Icons.stop, color: Colors.redAccent),
                  );
                },
              )
            : null,
      ),
    );
  }

  Future<void> _toggleAudio() async {
    final audioUrl = lesson.audioUrl;
    if (audioUrl == null || audioUrl.isEmpty || _isLoadingAudio) return;

    setState(() => _isLoadingAudio = true);
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        if (mounted) {
          setState(() => _isPlaying = false);
        }
      } else {
        await _audioPlayer.play(UrlSource(audioUrl));
        if (mounted) {
          setState(() => _isPlaying = true);
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible de lire cet audio.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingAudio = false);
      }
    }
  }
}
