import 'package:flutter/material.dart';
import '../models/boss.dart';

typedef DefeatedChangeCallback = void Function(bool isDefeated);

class BossItem extends StatefulWidget {
  final Boss boss;
  final DefeatedChangeCallback onDefeatedChange;

  BossItem({required this.boss, required this.onDefeatedChange});

  @override
  _BossItemState createState() => _BossItemState();
}

class _BossItemState extends State<BossItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.boss.image.isNotEmpty
              ? Image.network(widget.boss.image)
              : Container(
                  height: 200,
                  color: Colors.grey,
                  child: Center(child: Text('Sin imagen')),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.boss.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(widget.boss.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Ubicación: ${widget.boss.location}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Puntos de salud: ${widget.boss.healthPoints}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Recompensas: ${widget.boss.drops.isNotEmpty ? widget.boss.drops.join(', ') : 'Sin recompensas'}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
              title: Text('Derrotado'),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
                widget.onDefeatedChange(_isChecked);
              },
            ),
          ),
        ],
      ),
    );
  }
}
