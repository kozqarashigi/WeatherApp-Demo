import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:midterm_project/services/weather_service.dart';
import 'package:midterm_project/models/weather_model.dart';
import 'package:midterm_project/models/constants.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('8c3a9900ffc920d4cf18e5c63608b283');
  final Constants myConstants = Constants();
  Weather? _weather;
  String? _error;
  String _selectedCity = 'Nur-Sultan'; // Default starting city
  final TextEditingController _cityController = TextEditingController();

  Widget _getWeatherAnimation(String condition) {
    final assetPath = switch (condition.toLowerCase()) {
      'thunderstorm' => 'assets/thunder.json',
      'rain' || 'drizzle' => 'assets/rain.json',
      'clouds' || 'cloudy' => 'assets/cloud.json',
      _ => 'assets/sunny.json',
    };

    return Lottie.asset(
      assetPath,
      width: 200,
      height: 200,
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.error_outline,
        size: 50,
        color: Colors.blueGrey,
      ),
    );
  }

  Future<void> _fetchWeather() async {
    try {
      setState(() {
        _weather = null;
      });

      final weather = await _weatherService.getWeather(_selectedCity);

      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = "Failed to get weather data: ${e.toString()}";
      });
    }
  }

  void _searchCity() {
    if (_cityController.text.isNotEmpty) {
      setState(() {
        _selectedCity = _cityController.text;
        _cityController.clear();
      });
      _fetchWeather();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myConstants.primaryColor,
        title: const Text('Weather App'),
      ),
      body: Center(
        child: _error != null
            ? Text(_error!)
            : _weather == null
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: 'Enter city name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchCity,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _getWeatherAnimation(_weather!.mainCondition),
            const SizedBox(height: 20),
            Text(
              _weather!.cityName,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '${_weather!.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 48),
            ),
            Text(
              _weather!.mainCondition,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}