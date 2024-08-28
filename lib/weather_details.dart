import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final String city;

  const WeatherDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 2, 88, 5),
        title: Text(
          'Weather Details for $city',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await weatherProvider.fetchWeather(city);
        },
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            if (weatherProvider.weatherData == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              
              return FutureBuilder(
                  future: weatherProvider.fetchWeather(city),
                  builder: (context, snapshot) 
                  {
                    final weather = weatherProvider.weatherData!;
                    return ListView(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weather['name']}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${weather['main']['temp']} °C / ${(weather['main']['temp'] * 9 / 5 + 32).toStringAsFixed(2)} °F',
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                '${weather['weather'][0]['description']}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Humidity: ${weather['main']['humidity']}%',
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                'Wind Speed: ${weather['wind']['speed']} m/s',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
