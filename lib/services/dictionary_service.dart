import 'dart:math';
import 'package:myapp/models/dictionary_model.dart';

class DictionaryService {
  // Simuler une base de données locale ou un appel API
  final List<DictionaryEntry> _dictionary = [
    DictionaryEntry(
      word: 'Flutter',
      definition:
          'Un framework de développement d\'interface utilisateur open-source créé par Google.',
      examples: [
        'Flutter permet de créer des applications compilées nativement pour mobile, web et bureau à partir d\'une seule base de code.',
        'J\'apprends le développement Flutter.',
      ],
    ),
    DictionaryEntry(
      word: 'Widget',
      definition:
          'L\'élément de base de la construction d\'interface utilisateur dans Flutter.',
      examples: [
        'Tout dans Flutter est un widget, des éléments structurels comme Button aux éléments de mise en page comme Column.',
        'J\'ai créé un widget personnalisé pour mon application.',
      ],
    ),
    DictionaryEntry(
      word: 'Dart',
      definition:
          'Le langage de programmation utilisé pour développer des applications Flutter.',
      examples: [
        'Dart est optimisé pour le développement d\'interface utilisateur rapide.',
        'Ce code est écrit en Dart.',
      ],
    ),
    DictionaryEntry(
      word: 'Hot Reload',
      definition:
          'Une fonctionnalité de Flutter qui permet d\'injecter rapidement le code source mis à jour dans une VM Dart en cours d\'exécution.',
      examples: [
        'Le Hot Reload accélère considérablement le cycle de développement.',
      ],
    ),
  ];

  // Récupérer toutes les entrées du dictionnaire
  Future<List<DictionaryEntry>> getAllEntries() async {
    // Simule une attente de réseau
    await Future.delayed(const Duration(milliseconds: 300));
    return _dictionary;
  }

  // Rechercher des entrées dont le mot commence par la requête
  Future<List<DictionaryEntry>> searchEntries(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.isEmpty) {
      return [];
    }
    final lowerCaseQuery = query.toLowerCase();
    return _dictionary
        .where((entry) => entry.word.toLowerCase().startsWith(lowerCaseQuery))
        .toList();
  }

  // Récupérer une entrée de dictionnaire aléatoire pour le "Mot du Jour"
  Future<DictionaryEntry> getWordOfTheDay() async {
    // Simule une attente de réseau
    await Future.delayed(const Duration(milliseconds: 200));
    final random = Random();
    return _dictionary[random.nextInt(_dictionary.length)];
  }

  Future<List<DictionaryEntry>>? searchWord(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (query.isEmpty) {
      return [];
    }
    final lowerCaseQuery = query.toLowerCase();
    return _dictionary
        .where((entry) => entry.word.toLowerCase().contains(lowerCaseQuery))
        .toList();
  }
}
