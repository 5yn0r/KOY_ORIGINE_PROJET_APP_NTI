import 'package:flutter/material.dart';
import 'package:myapp/widgets/progress_card.dart';
import 'package:myapp/widgets/shortcuts_card.dart';
import 'package:myapp/widgets/recent_activity_card.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/models/lesson_history.dart';
import 'package:myapp/screens/learning/lessons_list_screen.dart';
import 'package:myapp/data/baoule_knowledge_base.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic>? _userProgress;
  List<LessonHistory> _lessonHistory = [];
  bool _isLoading = true;
  late TabController _tabController;

  // Modèles de modules
  static const List<ModuleItem> _modules = [
    ModuleItem(
      id: 'm01_phonetique',
      title: 'Phonétique',
      icon: Icons.audiotrack_outlined,
      color: Colors.blue,
      level: 'Débutant',
    ),
    ModuleItem(
      id: 'm02_salutations',
      title: 'Salutations',
      icon: Icons.waving_hand_outlined,
      color: Colors.teal,
      level: 'Débutant',
    ),
    ModuleItem(
      id: 'm03_nombres',
      title: 'Nombres',
      icon: Icons.format_list_numbered,
      color: Colors.purple,
      level: 'Débutant',
    ),
    ModuleItem(
      id: 'm04_famille',
      title: 'Famille',
      icon: Icons.family_restroom_outlined,
      color: Colors.green,
      level: 'Débutant',
    ),
    ModuleItem(
      id: 'm07_grammaire',
      title: 'Grammaire',
      icon: Icons.rule_folder,
      color: Colors.blueGrey,
      level: 'Intermédiaire',
    ),
    ModuleItem(
      id: 'm08_quotidien',
      title: 'Vie quotidienne',
      icon: Icons.location_on_outlined,
      color: Colors.indigo,
      level: 'Intermédiaire',
    ),
    ModuleItem(
      id: 'm13_culture',
      title: 'Culture',
      icon: Icons.landscape_outlined,
      color: Colors.green,
      level: 'Avancé',
    ),
    ModuleItem(
      id: 'm14_narration',
      title: 'Narration',
      icon: Icons.menu_book_outlined,
      color: Colors.indigo,
      level: 'Avancé',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    // Pas de changement ici, les fonctions retournent déjà les bons types
    final progress = await _firestoreService.getUserProgress();
    final history = await _firestoreService.getLessonHistory(limit: 3);
    setState(() {
      _userProgress = progress;
      _lessonHistory = history; // Maintenant, les types correspondent
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progression
            if (_userProgress != null)
              ProgressCard(userProgress: _userProgress!),
            const SizedBox(height: 14),

            // Mot du jour
            _buildWordOfDayCard(),
            const SizedBox(height: 14),

            // Raccourcis
            ShortcutsCard(
              onOpenLessons: () => widget.onNavigateToTab?.call(1),
              onOpenQuiz: () => widget.onNavigateToTab?.call(1),
              onOpenDictionary: () => widget.onNavigateToTab?.call(2),
              onOpenChatbot: () => widget.onNavigateToTab?.call(3),
            ),
            const SizedBox(height: 14),

            // Section Explorer les Modules
            _buildModulesSection(context),
            const SizedBox(height: 14),

            // Activité récente
            if (_lessonHistory.isNotEmpty)
              RecentActivityCard(lessonHistory: _lessonHistory),
          ],
        ),
      ),
    );
  }

  Widget _buildWordOfDayCard() {
    // Sélectionner un mot aléatoire
    final randomIndex = Random().nextInt(baouleKnowledgeBase.length);
    final wordOfDay = baouleKnowledgeBase[randomIndex];

    return GestureDetector(
      onTap: () {
        // Afficher les détails du mot
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.95,
            builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Indicateur de dragage
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Titre
                    Text(
                      'Mot du jour',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6B4FAD),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Mot en Baoulé
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6B4FAD), Color(0xFF9C6FD8)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Baoulé',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wordOfDay.baoule,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Traduction
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Traduction',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wordOfDay.french,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Catégorie
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.label_outline,
                            color: const Color(0xFF6B4FAD),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            wordOfDay.category,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B4FAD),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Note
                    if (wordOfDay.note.isNotEmpty) ...[
                      Text(
                        'Note',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        wordOfDay.note,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                    ],
                    // Exemples
                    if (wordOfDay.examples.isNotEmpty) ...[
                      Text(
                        'Exemples',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...wordOfDay.examples.map((example) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Expanded(
                              child: Text(
                                example,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B4FAD), Color(0xFF9C6FD8)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6B4FAD).withAlpha(30),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mot du jour',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              wordOfDay.baoule,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              wordOfDay.french,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    wordOfDay.category,
                    style: const TextStyle(fontSize: 11, color: Color(0xFF6B4FAD), fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E8FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.school_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Explorer les Modules',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // TabBar avec onglets
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5EEFF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicatorPadding: const EdgeInsets.all(3),
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey.shade700,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withAlpha(70),
              ),
            ),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  'Débutant',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  'Intermédiaire',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9.0),
                child: Text(
                  'Avancé',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Contenu des onglets
        SizedBox(
          height: 128,
          child: StreamBuilder<List<String>>(
            stream: _firestoreService.getCompletedModulesStream(),
            builder: (context, snapshot) {
              final completedModules = snapshot.data ?? [];
              return TabBarView(
                controller: _tabController,
                children: [
                  _buildModuleGrid('Débutant', context, completedModules),
                  _buildModuleGrid('Intermédiaire', context, completedModules),
                  _buildModuleGrid('Avancé', context, completedModules),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModuleGrid(
    String level,
    BuildContext context,
    List<String> completedModules,
  ) {
    final levelModules = _modules
        .where((m) => m.level == level)
        .take(2)
        .toList();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.75,
      ),
      itemCount: levelModules.length,
      itemBuilder: (context, index) {
        final module = levelModules[index];
        return _buildModuleCard(
          module,
          context,
          completedModules.contains(module.id),
        );
      },
    );
  }

  Widget _buildModuleCard(
    ModuleItem module,
    BuildContext context,
    bool isCompleted,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonsListScreen(moduleId: module.id),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: module.color.withAlpha(55)),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: module.color.withAlpha(22),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: module.color.withAlpha(45),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(module.icon, color: module.color, size: 19),
                  ),
                  if (isCompleted)
                    const Positioned(
                      right: -3,
                      bottom: -3,
                      child: Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      isCompleted ? 'Validé' : module.level,
                      style: TextStyle(
                        fontSize: 10,
                        color: isCompleted
                            ? Colors.green.shade700
                            : Colors.grey.shade700,
                        fontWeight: isCompleted
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isCompleted)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 11,
                  color: Colors.grey.shade500,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleItem {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final String level;

  const ModuleItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.level,
  });
}
