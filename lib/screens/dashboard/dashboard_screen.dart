import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/screens/chatbot/chatbot_screen.dart';
import 'package:myapp/screens/community/call_screen.dart';
import 'package:myapp/screens/dictionary/dictionary_screen.dart';
import 'package:myapp/screens/home/home_screen.dart';
import 'package:myapp/screens/modules/modules_screen.dart';
import 'package:myapp/screens/peer_to_peer/peer_to_peer_screen.dart';
import 'package:myapp/screens/profile/profile_screen.dart';
import 'package:myapp/models/event_model.dart';
import 'package:myapp/services/call_service.dart';
import 'package:myapp/services/event_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/auth_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  final CallService _callService = CallService();
  final EventService _eventService = EventService();
  StreamSubscription<Map<String, dynamic>?>? _incomingCallSubscription;
  String? _visibleIncomingCallId;
  final Set<String> _handledIncomingCallIds = {};

  final List<String> _titles = const [
    'Accueil',
    'Modules',
    'Dictionnaire',
    'Chatbot',
    'Peers',
  ];

  @override
  void initState() {
    super.initState();
    _eventService.initializeDefaultEvents();
    _incomingCallSubscription = _callService.getIncomingCallStream().listen((
      call,
    ) {
      if (call == null || !mounted) return;

      final callId = call['callId'] as String;
      if (_visibleIncomingCallId == callId ||
          _handledIncomingCallIds.contains(callId)) {
        return;
      }
      _visibleIncomingCallId = callId;
      _handledIncomingCallIds.add(callId);

      _showIncomingCallDialog(call);
    });
  }

  @override
  void dispose() {
    _incomingCallSubscription?.cancel();
    super.dispose();
  }

  Future<void> _showIncomingCallDialog(Map<String, dynamic> call) async {
    final callId = call['callId'] as String;
    final callerId = call['callerId'] as String;
    final calleeId = call['calleeId'] as String;
    final callerName = call['callerName'] as String;

    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Appel entrant'),
        content: Text('$callerName vous appelle en vidéo.'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.of(context).pop(false),
            icon: const Icon(Icons.call_end),
            label: const Text('Refuser'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.videocam),
            label: const Text('Répondre'),
          ),
        ],
      ),
    );

    _visibleIncomingCallId = null;
    if (!mounted) return;

    if (accepted == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            callerId: callerId,
            calleeId: calleeId,
            callId: callId,
          ),
        ),
      );
    } else {
      await _callService.declineCall(callId);
    }
  }

  void _setCurrentIndex(int index) {
    setState(() => _currentIndex = index);
  }

  List<Widget> get _screens => [
    HomeScreen(onNavigateToTab: _setCurrentIndex),
    ModulesScreen(),
    DictionaryScreen(),
    ChatbotScreen(),
    PeerToPeerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              final userName =
                  authProvider.userData?['displayName'] ?? 'Utilisateur';
              final userInitial = userName.isNotEmpty
                  ? userName[0].toUpperCase()
                  : 'U';
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: StreamBuilder<List<CulturalEvent>>(
                  stream: _eventService.getEventsStream(),
                  builder: (context, snapshot) {
                    final eventCount = snapshot.data?.length ?? 0;

                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: Text(
                                userInitial,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (eventCount > 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$eventCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Assure que la barre est toujours visible
        currentIndex: _currentIndex,
        onTap: _setCurrentIndex,
        selectedItemColor: Theme.of(
          context,
        ).primaryColor, // Couleur de l'icône et du texte sélectionnés
        unselectedItemColor:
            Colors.grey, // Couleur des icônes et des textes non sélectionnés
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Modules'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Dictionnaire',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Peers'),
        ],
      ),
    );
  }
}
