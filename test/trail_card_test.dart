import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caminhos_de_minas/models/trail.dart';
import 'package:caminhos_de_minas/widgets/trail_card.dart';

void main() {
  testWidgets('TrailCard renderiza o título e a distância corretamente', (
    WidgetTester tester,
  ) async {
    // 1. Prepara os dados (Arrange)
    final testTrail = Trail(
      id: '1',
      name: 'Pico do Itacolomi',
      distance: 12.5,
      difficulty: 'Difícil',
    );

    // 2. Constrói o widget na tela de teste (Act)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrailCard(trail: testTrail, onTap: () {}),
        ),
      ),
    );

    // 3. Verifica se os elementos estão presentes (Assert)
    expect(find.text('Pico do Itacolomi'), findsOneWidget);
    expect(find.text('12.5 km • Difícil'), findsOneWidget);
    expect(find.byIcon(Icons.nature_people), findsOneWidget);
  });
}
