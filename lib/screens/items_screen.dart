import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Objetos'),
      ),
      body: Center(
        child: Text('Aquí se mostrarán los Objetos'),
      ),
    );
  }
}
