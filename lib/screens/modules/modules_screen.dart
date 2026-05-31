import 'package:flutter/material.dart';
import 'package:myapp/screens/learning/lessons_list_screen.dart';
import 'package:myapp/services/firestore_service.dart';

// Le modèle de données inclut maintenant un `id` et un `level`
class Module {
  final String id; // Ajout de l'identifiant unique
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String level; // Nouveau : niveau (Débutant, Intermédiaire, Avancé)

  const Module({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.level,
  });
}

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});
  static final FirestoreService _firestoreService = FirestoreService();

  // La liste statique inclut maintenant des `id` pour chaque module
  static const List<Module> _modules = [
    Module(
      id: 'm01_phonetique',
      title: 'M01 – Phonétique et prononciation',
      description: 'Comprendre les sons et les tons du baoulé.',
      icon: Icons.audiotrack_outlined,
      color: Colors.blue,
      level: 'Débutant',
    ),
    Module(
      id: 'm02_salutations',
      title: 'M02 – Salutations et politesse',
      description: 'Apprenez les formules de salutation et de respect.',
      icon: Icons.waving_hand_outlined,
      color: Colors.teal,
      level: 'Débutant',
    ),
    Module(
      id: 'm03_nombres',
      title: 'M03 – Nombres et quantités',
      description:
          'Comptez et utilisez les nombres dans des situations réelles.',
      icon: Icons.format_list_numbered,
      color: Colors.purple,
      level: 'Débutant',
    ),
    Module(
      id: 'm04_famille',
      title: 'M04 – Famille et entourage',
      description: 'Découvrez les mots pour parler de votre famille.',
      icon: Icons.family_restroom_outlined,
      color: Colors.green,
      level: 'Débutant',
    ),
    Module(
      id: 'm05_nature',
      title: 'M05 – Nature et environnement',
      description: 'Vocabulaire des animaux, des plantes et du climat.',
      icon: Icons.park_outlined,
      color: Colors.teal,
      level: 'Débutant',
    ),
    Module(
      id: 'm06_cuisine',
      title: 'M06 – Nourriture et cuisine baoulé',
      description: 'Apprenez les aliments et les traditions culinaires.',
      icon: Icons.restaurant_menu_outlined,
      color: Colors.orange,
      level: 'Débutant',
    ),
    Module(
      id: 'm07_grammaire',
      title: 'M07 – Grammaire : structure de la phrase',
      description: 'Approfondissez l’ordre des mots et les pronoms.',
      icon: Icons.rule_folder,
      color: Colors.blueGrey,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm08_quotidien',
      title: 'M08 – Vie quotidienne et déplacements',
      description: 'Parlez du marché, des transports et du quotidien.',
      icon: Icons.location_on_outlined,
      color: Colors.indigo,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm09_interactions',
      title: 'M09 – Interactions sociales',
      description: 'Dialogues simples pour inviter, accepter et refuser.',
      icon: Icons.forum_outlined,
      color: Colors.lightBlue,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm10_proverbes',
      title: 'M10 – Proverbes et expressions',
      description: 'Apprenez la sagesse populaire baoulé.',
      icon: Icons.book_outlined,
      color: Colors.brown,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm11_verbes',
      title: 'M11 – Verbes d’action et conjugaison',
      description: 'Maîtrisez les verbes principaux et leur usage.',
      icon: Icons.autorenew,
      color: Colors.deepPurple,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm12_communication',
      title: 'M12 – Communication avancée',
      description: 'Exprimez vos besoins et vos idées dans la vie quotidienne.',
      icon: Icons.chat_bubble_outline,
      color: Colors.blue,
      level: 'Intermédiaire',
    ),
    Module(
      id: 'm13_culture',
      title: 'M13 – Histoire et culture',
      description: 'Comprenez le contexte culturel baoulé.',
      icon: Icons.landscape_outlined,
      color: Colors.green,
      level: 'Avancé',
    ),
    Module(
      id: 'm14_narration',
      title: 'M14 – Récits et narration',
      description: 'Apprenez à raconter une histoire simple.',
      icon: Icons.menu_book_outlined,
      color: Colors.indigo,
      level: 'Avancé',
    ),
    Module(
      id: 'm15_argumentation',
      title: 'M15 – Argumentation et débats',
      description: 'Exprimez une opinion et discutez avec respect.',
      icon: Icons.record_voice_over_outlined,
      color: Colors.redAccent,
      level: 'Avancé',
    ),
    Module(
      id: 'm16_formel',
      title: 'M16 – Expressions formelles',
      description: 'Parlez dans un registre plus soutenu.',
      icon: Icons.business_center_outlined,
      color: Colors.blueGrey,
      level: 'Avancé',
    ),
    Module(
      id: 'm17_correspondance',
      title: 'M17 – Langue écrite et correspondance',
      description: 'Rédigez des messages et des formules simples.',
      icon: Icons.edit_note_outlined,
      color: Colors.deepOrange,
      level: 'Avancé',
    ),
    Module(
      id: 'm18_perfectionnement',
      title: 'M18 – Perfectionnement oral',
      description: 'Renforcez votre aisance à l’oral.',
      icon: Icons.mic_outlined,
      color: Colors.blue,
      level: 'Avancé',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final debutantCount = _modules.where((m) => m.level == 'Débutant').length;
    final intermediaireCount = _modules
        .where((m) => m.level == 'Intermédiaire')
        .length;
    final avanceCount = _modules.where((m) => m.level == 'Avancé').length;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: 'Débutant ($debutantCount)'),
                Tab(text: 'Intermédiaire ($intermediaireCount)'),
                Tab(text: 'Avancé ($avanceCount)'),
              ],
            ),
          ),
        ),
        body: StreamBuilder<List<String>>(
          stream: _firestoreService.getCompletedModulesStream(),
          builder: (context, snapshot) {
            final completedModules = snapshot.data ?? [];
            return TabBarView(
              children: [
                _buildModuleList('Débutant', completedModules),
                _buildModuleList('Intermédiaire', completedModules),
                _buildModuleList('Avancé', completedModules),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildModuleList(String level, List<String> completedModules) {
    final levelModules = _modules
        .where((module) => module.level == level)
        .toList();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: levelModules.length,
      itemBuilder: (context, index) {
        final module = levelModules[index];
        final isCompleted = completedModules.contains(module.id);
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: CircleAvatar(
              backgroundColor: module.color.withAlpha(25),
              child: Icon(module.icon, color: module.color, size: 30),
            ),
            title: Text(
              module.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              module.description,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: isCompleted
                ? Chip(
                    avatar: const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 16,
                    ),
                    label: const Text('Validé'),
                    labelStyle: const TextStyle(fontSize: 12),
                    backgroundColor: Colors.green.withAlpha(25),
                    side: BorderSide.none,
                  )
                : const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonsListScreen(moduleId: module.id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
