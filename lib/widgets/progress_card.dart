import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final Map<String, dynamic> userProgress;

  const ProgressCard({super.key, required this.userProgress});

  @override
  Widget build(BuildContext context) {
    final double overallProgress = (userProgress['overallProgress'] ?? 0.0)
        .toDouble();
    final int modulesCompleted = (userProgress['modulesCompleted'] ?? 0)
        .toInt();
    final int totalModules = (userProgress['totalModules'] ?? 1)
        .toInt(); // Évite la division par zéro

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Votre Progression',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProgressIndicator(context, overallProgress),
                _buildProgressStats(context, modulesCompleted, totalModules),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, double progress) {
    return SizedBox(
      width: 74,
      height: 74,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 7,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStats(BuildContext context, int completed, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Modules Terminés', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 4),
        Text(
          '$completed / $total',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
