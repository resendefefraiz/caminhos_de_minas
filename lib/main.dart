import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const CaminhosDeMinasApp());
}

class CaminhosDeMinasApp extends StatelessWidget {
  const CaminhosDeMinasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caminhos de Minas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
