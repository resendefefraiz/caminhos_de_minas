import 'package:flutter/material.dart';

import '../models/trail.dart';

class TrailDetailPage extends StatelessWidget {
  final Trail trail;
  final VoidCallback onEdit;

  const TrailDetailPage({super.key, required this.trail, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(trail.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Distância', style: Theme.of(context).textTheme.titleMedium),
            Text('${trail.distance.toStringAsFixed(1)} km'),
            const SizedBox(height: 16),
            Text('Dificuldade', style: Theme.of(context).textTheme.titleMedium),
            Text(trail.difficulty),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context); // Volta para a lista
          onEdit(); // Dispara a edição a partir da lista
        },
        tooltip: 'Editar trilha',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
