import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apikey = 'api key here ';
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?q=$city&appid=$apikey'),
      );

      if (response.statusCode == 200) {
        debugPrint("response: ${response.body}");
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load weather data: $e');
    }
  }
}
