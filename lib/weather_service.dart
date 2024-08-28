import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
   static const String apikey = '304d3c4e1a4a5bc9ab1f59a28c0e501e';
  static const String baseUrl = "https://api.openweathermap.org/data/3.0/onecall";

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?$city&appid=$apikey'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
