import 'package:flutter/material.dart';

import '../models/trail.dart';
import '../widgets/trail_card.dart';
import 'trail_detail_page.dart';
import 'trail_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Trail> _trails = [];

  Future<void> _navigateAndProcessForm([Trail? trail]) async {
    final result = await Navigator.push<Trail>(
      context,
      MaterialPageRoute(
        builder: (context) => TrailFormPage(trailToEdit: trail),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      final index = _trails.indexWhere((t) => t.id == result.id);
      if (index >= 0) {
        _trails[index] = result; // Atualiza item existente
      } else {
        _trails.add(result); // Adiciona novo item
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${result.name} salvo com sucesso!')),
    );
  }

  void _navigateToDetail(Trail trail) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrailDetailPage(
          trail: trail,
          onEdit: () => _navigateAndProcessForm(trail),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caminhos de Minas'), centerTitle: true),
      body: _trails.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.landscape, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhuma trilha registrada ainda.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _navigateAndProcessForm(),
                    child: const Text('Adicionar Primeira Trilha'),
                  ),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                // Se a tela for larga, exibe em grade (2 colunas)
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                        ),
                    itemCount: _trails.length,
                    itemBuilder: (context, index) {
                      final trail = _trails[index];
                      return TrailCard(
                        key: ValueKey(trail.id),
                        trail: trail,
                        onTap: () => _navigateToDetail(trail),
                      );
                    },
                  );
                }
                // Se for tela de celular, exibe em lista simples
                return ListView.builder(
                  itemCount: _trails.length,
                  itemBuilder: (context, index) {
                    final trail = _trails[index];
                    return TrailCard(
                      key: ValueKey(trail.id),
                      trail: trail,
                      onTap: () => _navigateToDetail(trail),
                    );
                  },
                );
              },
            ),
      floatingActionButton: _trails.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _navigateAndProcessForm(),
              tooltip: 'Adicionar nova trilha',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
