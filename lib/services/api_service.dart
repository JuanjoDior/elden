import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/boss.dart';

class ApiService {
  static const String _baseUrl = 'https://eldenring.fanapis.com/api/bosses';
  static const int _limit =
      20; // Puedes ajustar este límite según sea necesario

  static Future<List<Boss>> fetchAllBosses() async {
    List<Boss> allBosses = [];
    int page = 0;
    bool hasMoreData = true;

    while (hasMoreData) {
      final response =
          await http.get(Uri.parse('$_baseUrl?limit=$_limit&page=$page'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> data = jsonData['data'];

        if (data.isNotEmpty) {
          allBosses.addAll(data.map((json) => Boss.fromJson(json)).toList());
          page++;
        } else {
          hasMoreData = false;
        }
      } else {
        throw Exception('Error al cargar los datos');
      }
    }

    return allBosses;
  }
}
