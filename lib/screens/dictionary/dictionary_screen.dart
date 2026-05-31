import 'package:flutter/material.dart';
import 'package:myapp/data/dictionary_data.dart';
import 'package:myapp/models/dictionary_word.dart';
import 'package:myapp/screens/dictionary/word_detail_screen.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  late List<DictionaryWord> _filteredWords;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredWords = List.from(dictionaryWords);
    _searchController.addListener(_filterWords);
  }

  void _filterWords() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWords = dictionaryWords.where((word) {
        final baouleMatch = word.baoule.word.toLowerCase().contains(query);
        final frenchMatch = word.french.word.toLowerCase().contains(query);
        return baouleMatch || frenchMatch;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredWords.length,
            itemBuilder: (context, index) {
              final word = _filteredWords[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                child: ListTile(
                  title: Text(
                    word.baoule.word,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(word.french.word),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WordDetailScreen(word: word),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Rechercher un mot...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
