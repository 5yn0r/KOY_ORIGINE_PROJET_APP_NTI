import 'package:flutter/material.dart';
import 'package:myapp/models/dictionary_word.dart';
import 'package:audioplayers/audioplayers.dart';

class WordDetailScreen extends StatefulWidget {
  final DictionaryWord word;

  const WordDetailScreen({super.key, required this.word});

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  Future<void> _playAudio() async {
    if (widget.word.audioUrl != null && widget.word.audioUrl!.isNotEmpty) {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(widget.word.audioUrl!));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun fichier audio disponible pour ce mot.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.baoule.word),
        actions: [
          IconButton(
            icon: Icon(
              widget.word.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () {
              setState(() {
                widget.word.isFavorite = !widget.word.isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainWords(context),
            const SizedBox(height: 24),
            _buildAudioPlayer(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Exemples'),
            ...widget.word.examples.map((ex) => _buildExampleCard(ex)),
            const SizedBox(height: 24),
            _buildInfoChips(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainWords(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.word.baoule.word,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (widget.word.baoule.pronunciation != null)
          Text(
            '[${widget.word.baoule.pronunciation!}]',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
          ),
        const SizedBox(height: 8),
        Text(
          widget.word.french.word,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildAudioPlayer(BuildContext context) {
    return Center(
      child: IconButton.filled(
        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        iconSize: 48,
        onPressed: widget.word.audioUrl != null ? _playAudio : null,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildExampleCard(Example example) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example.baoule,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            Text(
              example.french,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChips() {
    return Wrap(
      spacing: 8.0,
      children: [
        Chip(
          label: Text(widget.word.category),
          avatar: const Icon(Icons.category_outlined),
        ),
        Chip(
          label: Text('Niveau ${widget.word.difficulty}'),
          avatar: const Icon(Icons.school_outlined),
          backgroundColor: Colors.blue.shade100,
        ),
      ],
    );
  }
}
