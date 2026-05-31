import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/lesson_history.dart'; // Import du nouveau modèle

// Le modèle de données a été déplacé dans son propre fichier : lib/models/lesson_history.dart

class RecentActivityCard extends StatelessWidget {
  final List<LessonHistory> lessonHistory;

  const RecentActivityCard({super.key, required this.lessonHistory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activité Récente',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Construit la liste des activités
            ...lessonHistory.map(
              (activity) => _buildActivityRow(context, activity),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, LessonHistory activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.lessonName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  'Module : ${activity.moduleName}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd/MM/yy').format(activity.completedDate),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
