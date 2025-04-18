import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherLottie {
  static Widget getWeatherAnimation(String condition, {double size = 200}) {
    String assetPath;

    switch (condition.toLowerCase()) {
      case 'thunderstorm':
      case 'thunder':
        assetPath = 'assets/weather/thunder.json';
        break;
      case 'rain':
      case 'drizzle':
        assetPath = 'assets/weather/rain.json';
        break;
      case 'clear':
        assetPath = 'assets/weather/sunny.json';
        break;
      case 'clouds':
      case 'cloudy':
        assetPath = 'assets/weather/cloud.json';
        break;
      default:
        assetPath = 'assets/weather/sunny.json'; // default
    }

    return Lottie.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.error_outline,
        size: size,
        color: Colors.blue,
      ),
    );
  }
}