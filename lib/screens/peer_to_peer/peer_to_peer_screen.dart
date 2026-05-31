import 'package:flutter/material.dart';
import 'package:myapp/screens/peer_to_peer/user_list_screen.dart';
import 'package:myapp/screens/peer_to_peer/chat_list_screen.dart';
import 'package:myapp/screens/peer_to_peer/call_history_screen.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/services/call_service.dart';

class PeerToPeerScreen extends StatefulWidget {
  const PeerToPeerScreen({super.key});

  @override
  State<PeerToPeerScreen> createState() => _PeerToPeerScreenState();
}

class _PeerToPeerScreenState extends State<PeerToPeerScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final CallService _callService = CallService();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _callService.markMissedCallsAsSeen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          color: colorScheme.surface,
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: _selectedIndex == 2
                      ? 'Rechercher un appel...'
                      : 'Rechercher un apprenant...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Effacer',
                          icon: const Icon(Icons.close),
                          onPressed: _searchController.clear,
                        ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 12),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: _firestoreService.getChatRoomsStream(),
                builder: (context, chatSnapshot) {
                  final unreadChats = _countUnreadChats(
                    chatSnapshot.data ?? [],
                  );

                  return StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _callService.getCallHistoryStream(),
                    builder: (context, callSnapshot) {
                      final missedCalls = _countMissedCalls(
                        callSnapshot.data ?? [],
                      );

                      return SegmentedButton<int>(
                        segments: [
                          const ButtonSegment(
                            value: 0,
                            icon: Icon(Icons.people_outline),
                            label: Text('Peers'),
                          ),
                          ButtonSegment(
                            value: 1,
                            icon: _buildSegmentIcon(
                              baseIcon: Icons.chat_bubble_outline,
                              badgeCount: unreadChats,
                            ),
                            label: const Text('Chats'),
                          ),
                          ButtonSegment(
                            value: 2,
                            icon: _buildSegmentIcon(
                              baseIcon: Icons.call_outlined,
                              badgeCount: missedCalls,
                            ),
                            label: const Text('Appels'),
                          ),
                        ],
                        selected: {_selectedIndex},
                        onSelectionChanged: (selection) {
                          _onItemTapped(selection.first);
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(child: _buildSelectedScreen()),
      ],
    );
  }

  Widget _buildSelectedScreen() {
    switch (_selectedIndex) {
      case 1:
        return ChatListScreen(searchQuery: _searchQuery);
      case 2:
        return CallHistoryScreen(searchQuery: _searchQuery);
      default:
        return UserListScreen(searchQuery: _searchQuery);
    }
  }

  int _countUnreadChats(List<Map<String, dynamic>> rooms) {
    return rooms.fold<int>(0, (sum, room) {
      final count = (room['unreadCount'] as int?) ?? 0;
      return sum + count;
    });
  }

  int _countMissedCalls(List<Map<String, dynamic>> calls) {
    return calls.where((call) => call['missedUnread'] == true).length;
  }

  Widget _buildSegmentIcon({
    required IconData baseIcon,
    required int badgeCount,
  }) {
    if (badgeCount <= 0) {
      return Icon(baseIcon);
    }

    final countLabel = badgeCount > 99 ? '99+' : '$badgeCount';
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(baseIcon),
        Positioned(
          right: -8,
          top: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(minWidth: 18, minHeight: 16),
            child: Text(
              countLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
