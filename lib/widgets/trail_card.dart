import 'package:flutter/material.dart';

import '../models/trail.dart';

class TrailCard extends StatelessWidget {
  final Trail trail;
  final VoidCallback onTap;

  const TrailCard({super.key, required this.trail, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(
          Icons.nature_people,
          semanticLabel: 'Ícone de atividade ao ar livre', // Importante para acessibilidade
        ),
        title: Text(
          trail.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${trail.distance.toStringAsFixed(1)} km • ${trail.difficulty}',
        ),
        onTap: onTap,
      ),
    );
  }
}
