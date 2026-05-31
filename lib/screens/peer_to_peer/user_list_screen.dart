import 'package:flutter/material.dart';
import 'package:myapp/screens/peer_to_peer/chat_screen.dart';
import 'package:myapp/services/firestore_service.dart';
import 'package:myapp/services/call_service.dart'; // Importer CallService
import 'package:myapp/screens/community/call_screen.dart';

// Le modèle P2PUser reste le même
class P2PUser {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  const P2PUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
  });
}

class UserListScreen extends StatefulWidget {
  final String searchQuery;

  const UserListScreen({super.key, this.searchQuery = ''});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final CallService _callService = CallService(); // Instancier CallService

  @override
  Widget build(BuildContext context) {
    final currentUserId = _callService.getCurrentUserId();
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<List<P2PUser>>(
      stream: _firestoreService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _PeerEmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Impossible de charger les apprenants',
            subtitle: 'Vérifiez la connexion ou les règles Firestore.',
          );
        }

        final query = widget.searchQuery.toLowerCase();
        final users = (snapshot.data ?? [])
            .where((user) => user.id != currentUserId)
            .where((user) => user.name.toLowerCase().contains(query))
            .toList();

        if (users.isEmpty) {
          return _PeerEmptyState(
            icon: Icons.people_outline,
            title: widget.searchQuery.isEmpty
                ? 'Aucun apprenant disponible'
                : 'Aucun résultat',
            subtitle: widget.searchQuery.isEmpty
                ? 'Les autres comptes inscrits apparaîtront ici.'
                : 'Essayez un autre nom.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          itemCount: users.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 0,
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                leading: _PeerAvatar(user: user),
                title: Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(user.isOnline ? 'En ligne' : 'Hors ligne'),
                ),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton.filledTonal(
                      tooltip: 'Message',
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(user: user),
                          ),
                        );
                      },
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Appel',
                      icon: const Icon(Icons.call_outlined),
                      onPressed: currentUserId == null
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CallScreen(
                                    callerId: currentUserId,
                                    calleeId: user.id,
                                  ),
                                ),
                              );
                            },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: user),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _PeerAvatar extends StatelessWidget {
  final P2PUser user;

  const _PeerAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    final initial = user.name.trim().isEmpty ? '?' : user.name.trim()[0];

    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: user.avatarUrl.isNotEmpty
              ? NetworkImage(user.avatarUrl)
              : null,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: user.avatarUrl.isEmpty
              ? Text(
                  initial.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: user.isOnline ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PeerEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PeerEmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
