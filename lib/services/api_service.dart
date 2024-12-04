import 'dart:convert';
import 'package:http/http.dart' as http;
import '../planet.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:3000';

  Future<List<Planet>> fetchPlanets() async {
    final response = await http.get(Uri.parse('$_baseUrl/getPlanets'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((planetJson) => Planet.fromJson(planetJson)).toList();
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Future<List<Planet>> getPlanets() async {
    final response = await http.get(Uri.parse('$_baseUrl/getPlanets'));

    if (response.statusCode == 200) {
      // Parse the response body and convert it to a list of planets
      final List<dynamic> planetList = json.decode(response.body);
      return planetList
          .map((planetData) => Planet.fromJson(planetData))
          .toList();
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Future<void> addPlanet(Map<String, dynamic> planetData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/addPlanet'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(planetData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add planet');
    }
  }

  Future<void> addQuizQuestion(Map<String, dynamic> questionData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/addQuizQuestion'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(questionData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add quiz question');
    }
  }
}
