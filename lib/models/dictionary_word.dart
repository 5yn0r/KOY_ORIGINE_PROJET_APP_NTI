class DictionaryWord {
  final WordDetails baoule;
  final WordDetails french;
  final String? audioUrl;
  final List<Example> examples;
  final String category;
  final int difficulty;
  final WordStats stats;
  bool isFavorite;

  DictionaryWord({
    required this.baoule,
    required this.french,
    this.audioUrl,
    required this.examples,
    required this.category,
    required this.difficulty,
    required this.stats,
    this.isFavorite = false, // Par défaut, un mot n'est pas un favori
  });
}

class WordDetails {
  final String word;
  final String? pronunciation;

  WordDetails({required this.word, this.pronunciation});
}

class Example {
  final String baoule;
  final String french;

  Example({required this.baoule, required this.french});
}

class WordStats {
  int views;
  int correctAnswers;

  WordStats({this.views = 0, this.correctAnswers = 0});
}
