import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/models/learning_models.dart';
import 'package:myapp/services/learning_service.dart';

class ModulesScreen extends StatefulWidget {
  final String userLevel;

  const ModulesScreen({super.key, required this.userLevel});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final LearningService _learningService = LearningService();
  late Future<List<LearningModule>> _modulesFuture;

  @override
  void initState() {
    super.initState();
    _modulesFuture = _learningService.getModulesByLevel(widget.userLevel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modules d\'apprentissage')),
      body: FutureBuilder<List<LearningModule>>(
        future: _modulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun module trouvé.'));
          }

          final modules = snapshot.data!;
          return ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(module.title),
                  subtitle: Text(module.description ?? ''),
                  onTap: () {
                    // Naviguer vers l'écran de la liste des leçons pour ce module
                    context.go('/dashboard/modules/${module.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
