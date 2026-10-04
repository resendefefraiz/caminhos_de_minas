import 'package:flutter/material.dart';

import '../models/trail.dart';

class TrailFormPage extends StatefulWidget {
  final Trail? trailToEdit;

  const TrailFormPage({super.key, this.trailToEdit});

  @override
  State<TrailFormPage> createState() => _TrailFormPageState();
}

class _TrailFormPageState extends State<TrailFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _distanceController;

  String _difficulty = 'Fácil';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Se recebermos uma trilha para editar, iniciamos os controllers com os dados dela
    _nameController = TextEditingController(
      text: widget.trailToEdit?.name ?? '',
    );
    _distanceController = TextEditingController(
      text: widget.trailToEdit != null
          ? widget.trailToEdit!.distance.toString()
          : '',
    );
    if (widget.trailToEdit != null) {
      _difficulty = widget.trailToEdit!.difficulty;
    }
  }

  @override
  void dispose() {
    // É obrigatório descartar os controllers para evitar vazamento de memória
    _nameController.dispose();
    _distanceController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_isSubmitting) return; // Guarda para evitar duplo clique

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSubmitting = true);

      final newTrail = Trail(
        // Preserva o ID na edição, ou gera um novo na criação
        id:
            widget.trailToEdit?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        distance: double.parse(_distanceController.text.trim()),
        difficulty: _difficulty,
      );

      // Devolve o objeto criado/editado para a tela anterior
      Navigator.pop(context, newTrail);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.trailToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar Trilha' : 'Nova Trilha')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do local',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o nome do local'; // Mensagem de erro útil
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _distanceController,
              decoration: const InputDecoration(
                labelText: 'Distância (km)',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _saveForm(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe a distância';
                }
                if (double.tryParse(value.trim()) == null) {
                  return 'Informe um número válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _difficulty,
              decoration: const InputDecoration(
                labelText: 'Nível de Dificuldade',
                border: OutlineInputBorder(),
              ),
              items: ['Fácil', 'Moderado', 'Difícil']
                  .map(
                    (label) =>
                        DropdownMenuItem(value: label, child: Text(label)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _difficulty = value);
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _saveForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
