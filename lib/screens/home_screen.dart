import 'package:flutter/material.dart';
import '../models/boss.dart';
import '../services/api_service.dart';
import '../widgets/boss_item.dart';
import 'map_screen.dart';
import 'items_screen.dart';
import 'zones_screen.dart';
import '../widgets/boss_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Boss>>? _bossList;
  List<Boss> _bosses = [];
  int _totalBosses = 0;
  int _defeatedBosses = 0;

  @override
  void initState() {
    super.initState();
    _bossList = ApiService.fetchAllBosses();
    _bossList?.then((value) {
      setState(() {
        _bosses = value;
        _totalBosses = value.length;
      });
    });
  }

  void _updateDefeatedCount(bool isDefeated) {
    setState(() {
      if (isDefeated) {
        _defeatedBosses++;
      } else {
        _defeatedBosses--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Lista de Verificación de Jefes ($_defeatedBosses/$_totalBosses)'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BossSearchDelegate(
                  bosses: _bosses,
                  onDefeatedChange: _updateDefeatedCount,
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Elden Ring',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Mapa Interactivo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Objetos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.landscape),
              title: Text('Zonas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZonesScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Boss>>(
        future: _bossList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron jefes'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return BossItem(
                  boss: snapshot.data![index],
                  onDefeatedChange: _updateDefeatedCount,
                );
              },
            );
          }
        },
      ),
    );
  }
}
