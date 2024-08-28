import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic>? _weatherData;
  String? _city;

  Map<String, dynamic>? get weatherData => _weatherData;
  String? get city => _city;

  Future<void> fetchWeather(String city) async {
    _city = city;
    _weatherData = await WeatherService().fetchWeather(city);
    notifyListeners();
  }
}
