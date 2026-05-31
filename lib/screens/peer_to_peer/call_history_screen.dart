import 'package:flutter/material.dart';
import 'package:myapp/services/call_service.dart';

class CallHistoryScreen extends StatefulWidget {
  final String searchQuery;

  const CallHistoryScreen({super.key, this.searchQuery = ''});

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  final CallService _callService = CallService();

  @override
  void initState() {
    super.initState();
    _callService.markMissedCallsAsSeen();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _callService.getCallHistoryStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return _CallEmptyState(
            icon: Icons.cloud_off_outlined,
            title: 'Impossible de charger les appels',
            subtitle: 'Vérifiez la connexion ou les règles Firestore.',
          );
        }

        final query = widget.searchQuery.toLowerCase();
        final callHistory = (snapshot.data ?? []).where((call) {
          final otherUserName = (call['otherUserName'] as String?) ?? '';
          final callStatus = (call['callStatus'] as String?) ?? '';
          final callType = (call['callType'] as String?) ?? '';
          return otherUserName.toLowerCase().contains(query) ||
              callStatus.toLowerCase().contains(query) ||
              callType.toLowerCase().contains(query);
        }).toList();

        if (callHistory.isEmpty) {
          return _CallEmptyState(
            icon: Icons.call_missed_outgoing,
            title: widget.searchQuery.isEmpty
                ? 'Aucun appel'
                : 'Aucun résultat',
            subtitle: widget.searchQuery.isEmpty
                ? 'Les appels passés depuis Peers apparaîtront ici.'
                : 'Essayez avec un autre nom.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          itemCount: callHistory.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final call = callHistory[index];
            final otherUserName = call['otherUserName'] as String;
            final callType = call['callType'] as String; // 'audio' or 'video'
            final callStatus =
                call['callStatus']
                    as String; // 'completed', 'missed', 'cancelled'
            final timestamp = call['timestamp'] as DateTime;
            final duration = call['duration'] as Duration?;

            IconData callIcon;
            Color callColor;

            switch (callStatus) {
              case 'completed':
                callIcon = callType == 'video' ? Icons.videocam : Icons.call;
                callColor = Colors.green;
                break;
              case 'ringing':
                callIcon = Icons.ring_volume;
                callColor = Colors.blue;
                break;
              case 'missed':
                callIcon = Icons.call_missed;
                callColor = Colors.red;
                break;
              case 'declined':
                callIcon = Icons.phone_disabled;
                callColor = Colors.red;
                break;
              case 'cancelled':
                callIcon = Icons.call_end;
                callColor = Colors.orange;
                break;
              default:
                callIcon = Icons.call;
                callColor = Colors.grey;
            }

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
                leading: CircleAvatar(
                  backgroundColor: callColor.withValues(alpha: 0.14),
                  child: Icon(callIcon, color: callColor),
                ),
                title: Text(
                  otherUserName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${callType == 'video' ? 'Appel vidéo' : 'Appel audio'} • ${_statusLabel(callStatus)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (duration != null)
                        Text(
                          'Durée: ${_formatDuration(duration)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                trailing: Text(
                  _formatTimestamp(timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} j';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }

    return '$minutes:$seconds';
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'completed':
        return 'Terminé';
      case 'ringing':
        return 'En cours';
      case 'missed':
        return 'Manqué';
      case 'declined':
        return 'Refusé';
      case 'cancelled':
        return 'Annulé';
      default:
        return status;
    }
  }
}

class _CallEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CallEmptyState({
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
