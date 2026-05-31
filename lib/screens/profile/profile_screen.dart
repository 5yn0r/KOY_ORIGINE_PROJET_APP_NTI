import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/event_model.dart';
import 'package:myapp/providers/auth_provider.dart';
import 'package:myapp/services/auth_service.dart';
import 'package:myapp/services/event_service.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final EventService _eventService = EventService();
  final FirestoreService _firestoreService = FirestoreService();
  late final TextEditingController _displayNameController;

  bool _isSaving = false;
  String? _selectedLevel;

  static const List<String> _levels = ['Débutant', 'Intermédiaire', 'Avancé'];

  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    final displayName = authProvider.userData?['displayName'] ?? '';
    _selectedLevel = authProvider.userData?['level'] ?? 'Débutant';
    _displayNameController = TextEditingController(text: displayName);
    _eventService.initializeDefaultEvents();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  int _levelRank(String level) {
    switch (level) {
      case 'Intermédiaire':
        return 1;
      case 'Avancé':
        return 2;
      default:
        return 0;
    }
  }

  String _nextLevel(String level) {
    switch (level) {
      case 'Débutant':
        return 'Intermédiaire';
      case 'Intermédiaire':
        return 'Avancé';
      default:
        return 'Avancé';
    }
  }

  int _requiredModulesForLevel(String level) {
    if (level == 'Débutant' || level == 'Intermédiaire') {
      return 3;
    }
    return 0;
  }

  int _completedCountForLevel(List<String> completedModules, String level) {
    final ids = <String>[];
    if (level == 'Débutant') {
      ids.addAll([
        'm01_phonetique',
        'm02_salutations',
        'm03_nombres',
        'm04_famille',
        'm05_nature',
        'm06_cuisine',
      ]);
    } else if (level == 'Intermédiaire') {
      ids.addAll([
        'm07_grammaire',
        'm08_quotidien',
        'm09_interactions',
        'm10_proverbes',
        'm11_verbes',
        'm12_communication',
      ]);
    } else {
      ids.addAll([
        'm13_culture',
        'm14_narration',
        'm15_argumentation',
        'm16_formel',
        'm17_correspondance',
        'm18_perfectionnement',
      ]);
    }
    return ids.where(completedModules.contains).length;
  }

  bool _canMoveToLevel({
    required String currentLevel,
    required String targetLevel,
    required List<String> completedModules,
  }) {
    final currentRank = _levelRank(currentLevel);
    final targetRank = _levelRank(targetLevel);

    if (targetRank <= currentRank) {
      return true;
    }
    if (targetRank - currentRank > 1) {
      return false;
    }
    if (currentLevel == 'Avancé') {
      return false;
    }

    final completedOnCurrent = _completedCountForLevel(
      completedModules,
      currentLevel,
    );
    return completedOnCurrent >= _requiredModulesForLevel(currentLevel);
  }

  Future<void> _saveProfile(List<String> completedModules) async {
    final authProvider = context.read<AuthProvider>();
    final userId = authProvider.user?.uid;
    if (userId == null) return;

    final newDisplayName = _displayNameController.text.trim();
    if (newDisplayName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le nom ne peut pas être vide.')),
      );
      return;
    }

    final currentLevel = authProvider.userData?['level'] ?? 'Débutant';
    final selectedLevel = _selectedLevel ?? currentLevel;
    final canUpdateLevel = _canMoveToLevel(
      currentLevel: currentLevel,
      targetLevel: selectedLevel,
      completedModules: completedModules,
    );

    if (!canUpdateLevel) {
      final requiredCount = _requiredModulesForLevel(currentLevel);
      final currentCount = _completedCountForLevel(
        completedModules,
        currentLevel,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Valide $requiredCount modules du niveau $currentLevel avant de passer à ${_nextLevel(currentLevel)} ($currentCount/$requiredCount).',
          ),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final authService = AuthService();
      final levelToUpdate = selectedLevel != currentLevel
          ? selectedLevel
          : null;
      await authService.updateUserProfile(
        userId,
        newDisplayName,
        level: levelToUpdate,
      );

      if (!mounted) return;
      await authProvider.refreshUserData();
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil mis à jour avec succès.')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<AuthProvider>().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon Profil',
          style: GoogleFonts.zillaSlab(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final user = authProvider.user;
          final userData = authProvider.userData;

          if (user == null) {
            return const Center(child: Text('Non connecté'));
          }

          final displayName = userData?['displayName'] ?? 'Utilisateur';
          final level = userData?['level'] ?? 'Débutant';
          final email = user.email ?? '';

          if (_displayNameController.text != displayName && !_isSaving) {
            _displayNameController.text = displayName;
          }
          if (_selectedLevel != level && !_isSaving) {
            _selectedLevel = level;
          }

          return SafeArea(
            bottom: true,
            child: StreamBuilder<List<String>>(
              stream: _firestoreService.getCompletedModulesStream(),
              builder: (context, progressSnapshot) {
                final completedModules = progressSnapshot.data ?? <String>[];
                final completedOnCurrentLevel = _completedCountForLevel(
                  completedModules,
                  level,
                );
                final requiredForNext = _requiredModulesForLevel(level);
                final canGoNext =
                    requiredForNext > 0 &&
                    completedOnCurrentLevel >= requiredForNext;
                final maxAllowedLevel = canGoNext ? _nextLevel(level) : level;
                final maxAllowedRank = _levelRank(maxAllowedLevel);
                final datePadding = MediaQuery.of(context).viewPadding.bottom;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 24 + datePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor: colorScheme.primary,
                              child: Text(
                                displayName.isNotEmpty
                                    ? displayName[0].toUpperCase()
                                    : 'U',
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              displayName,
                              style: GoogleFonts.lato(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              email,
                              style: GoogleFonts.lato(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colorScheme.outlineVariant),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Informations personnelles',
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextField(
                                controller: _displayNameController,
                                enabled: !_isSaving,
                                decoration: InputDecoration(
                                  labelText: 'Nom d\'affichage',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                key: ValueKey(_selectedLevel),
                                initialValue: _selectedLevel,
                                decoration: const InputDecoration(
                                  labelText: 'Niveau',
                                  prefixIcon: Icon(Icons.school_outlined),
                                  border: OutlineInputBorder(),
                                ),
                                items: _levels
                                    .where(
                                      (item) =>
                                          _levelRank(item) <= maxAllowedRank,
                                    )
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      ),
                                    )
                                    .toList(),
                                onChanged: _isSaving
                                    ? null
                                    : (value) {
                                        setState(() => _selectedLevel = value);
                                      },
                              ),
                              const SizedBox(height: 10),
                              if (requiredForNext > 0)
                                Text(
                                  'Progression vers ${_nextLevel(level)}: $completedOnCurrentLevel/$requiredForNext modules validés.',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: _isSaving
                                          ? null
                                          : () {
                                              setState(() {
                                                _displayNameController.text =
                                                    displayName;
                                                _selectedLevel = level;
                                              });
                                            },
                                      child: const Text('Réinitialiser'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: _isSaving
                                          ? null
                                          : () =>
                                                _saveProfile(completedModules),
                                      child: _isSaving
                                          ? SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: colorScheme.onPrimary,
                                              ),
                                            )
                                          : const Text('Sauvegarder'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      StreamBuilder<List<CulturalEvent>>(
                        stream: _eventService.getEventsStream(),
                        builder: (context, snapshot) {
                          final events = snapshot.data ?? <CulturalEvent>[];
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Événements culturels',
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                            99,
                                          ),
                                        ),
                                        child: Text(
                                          '${events.length}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  else if (events.isEmpty)
                                    Text(
                                      'Aucun événement pour le moment.',
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    )
                                  else
                                    ...events.map((event) {
                                      return Card(
                                        margin: const EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        elevation: 0,
                                        color: colorScheme.surfaceContainer,
                                        child: ExpansionTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.red.shade50,
                                            child: const Icon(
                                              Icons.event,
                                              color: Colors.red,
                                            ),
                                          ),
                                          title: Text(
                                            event.title,
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${event.category} • ${event.location}',
                                          ),
                                          childrenPadding:
                                              const EdgeInsets.fromLTRB(
                                                16,
                                                0,
                                                16,
                                                16,
                                              ),
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                event.description,
                                                style: TextStyle(
                                                  color: colorScheme
                                                      .onSurfaceVariant,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Date: ${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      FilledButton.tonalIcon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Déconnexion'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          minimumSize: const Size.fromHeight(46),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
