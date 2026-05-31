import 'package:myapp/data/all_lessons.dart';
import 'package:myapp/data/baoule_knowledge_base.dart';
import 'package:myapp/data/dictionary_data.dart';

class BaouleKnowledgeService {
  String buildContextForQuestion(String question) {
    final normalizedQuestion = _normalize(question);
    final sections = <String>[];

    final knowledgeMatches = _searchKnowledgeBase(normalizedQuestion);
    if (knowledgeMatches.isNotEmpty) {
      sections.add(_formatKnowledgeMatches(knowledgeMatches));
    }

    final dictionaryMatches = _searchDictionary(normalizedQuestion);
    if (dictionaryMatches.isNotEmpty) {
      sections.add(_formatDictionaryMatches(dictionaryMatches));
    }

    final lessonMatches = _searchLessons(normalizedQuestion);
    if (lessonMatches.isNotEmpty) {
      sections.add(_formatLessonMatches(lessonMatches));
    }

    if (sections.isEmpty) {
      return 'Aucune donnee locale pertinente trouvee pour cette question.';
    }

    return sections.join('\n\n');
  }

  List<BaouleKnowledgeEntry> _searchKnowledgeBase(String normalizedQuestion) {
    final matches = baouleKnowledgeBase.where((entry) {
      final searchable = _normalize(
        [
          entry.baoule,
          entry.french,
          entry.category,
          entry.note,
          ...entry.variants,
          ...entry.examples,
        ].join(' '),
      );
      return _hasUsefulOverlap(normalizedQuestion, searchable);
    }).toList();

    return matches.take(8).toList();
  }

  List<dynamic> _searchDictionary(String normalizedQuestion) {
    final matches = dictionaryWords.where((word) {
      final searchable = _normalize(
        [
          word.baoule.word,
          word.baoule.pronunciation ?? '',
          word.french.word,
          word.category,
          ...word.examples.map(
            (example) => '${example.baoule} ${example.french}',
          ),
        ].join(' '),
      );
      return _hasUsefulOverlap(normalizedQuestion, searchable);
    }).toList();

    return matches.take(8).toList();
  }

  List<_LessonMatch> _searchLessons(String normalizedQuestion) {
    final matches = <_LessonMatch>[];

    for (final moduleEntry in allLessons.entries) {
      for (final lesson in moduleEntry.value) {
        final searchable = _normalize(
          '${lesson.title} ${lesson.content} ${lesson.moduleId}',
        );
        if (_hasUsefulOverlap(normalizedQuestion, searchable)) {
          matches.add(
            _LessonMatch(
              moduleId: moduleEntry.key,
              title: lesson.title,
              content: _shorten(lesson.content),
            ),
          );
        }
      }
    }

    return matches.take(5).toList();
  }

  String _formatKnowledgeMatches(List<BaouleKnowledgeEntry> entries) {
    final buffer = StringBuffer('Base ajoutee manuellement:');
    for (final entry in entries) {
      buffer.writeln(
        '- ${entry.baoule} = ${entry.french}'
        '${entry.variants.isEmpty ? '' : ' | variantes: ${entry.variants.join(', ')}'}'
        '${entry.note.isEmpty ? '' : ' | note: ${entry.note}'}',
      );
      if (entry.examples.isNotEmpty) {
        buffer.writeln('  Exemples: ${entry.examples.join(' / ')}');
      }
    }
    return buffer.toString();
  }

  String _formatDictionaryMatches(List<dynamic> words) {
    final buffer = StringBuffer('Dictionnaire local:');
    for (final word in words) {
      buffer.writeln(
        '- ${word.baoule.word} = ${word.french.word}'
        '${word.baoule.pronunciation == null ? '' : ' | prononciation: ${word.baoule.pronunciation}'}'
        ' | categorie: ${word.category}',
      );
      if (word.examples.isNotEmpty) {
        final examples = word.examples
            .map((example) => '${example.baoule} = ${example.french}')
            .join(' / ');
        buffer.writeln('  Exemples: $examples');
      }
    }
    return buffer.toString();
  }

  String _formatLessonMatches(List<_LessonMatch> lessons) {
    final buffer = StringBuffer('Lecons locales:');
    for (final lesson in lessons) {
      buffer.writeln(
        '- ${lesson.moduleId} | ${lesson.title}: ${lesson.content}',
      );
    }
    return buffer.toString();
  }

  bool _hasUsefulOverlap(String question, String source) {
    final tokens = question
        .split(RegExp(r'\s+'))
        .where((token) => token.length >= 3)
        .toSet();
    if (tokens.isEmpty) return false;

    return tokens.any(source.contains);
  }

  String _normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll(RegExp(r'[àáâãäå]'), 'a')
        .replaceAll(RegExp(r'[èéêë]'), 'e')
        .replaceAll(RegExp(r'[ìíîï]'), 'i')
        .replaceAll(RegExp(r'[òóôõö]'), 'o')
        .replaceAll(RegExp(r'[ùúûü]'), 'u')
        .replaceAll(RegExp(r'[ç]'), 'c')
        .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _shorten(String value) {
    final cleaned = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (cleaned.length <= 520) return cleaned;
    return '${cleaned.substring(0, 520)}...';
  }
}

class _LessonMatch {
  final String moduleId;
  final String title;
  final String content;

  const _LessonMatch({
    required this.moduleId,
    required this.title,
    required this.content,
  });
}
