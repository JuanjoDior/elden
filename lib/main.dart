import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(EldenRingBossChecklistApp());
}

class EldenRingBossChecklistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Verificación de Jefes - Elden Ring',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
