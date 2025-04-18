import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:midterm_project/models/weather_model.dart';

class WeatherService {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
    print("Fetching weather for: $cityName");

    try {
      final response = await http.get(url);
      print("📦 API Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception(' Failed to load weather data! Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print(" Detailed error in getWeather: $e");
      throw e;
    }
  }

  Future<String> getCurrentCity() async {
    try {
      // Check and request permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return "Astana"; // fallback to Astana
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return "Astana"; // fallback if permissions denied
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return "Astana"; // fallback if permissions permanently denied
      }

      // Get current position with timeout
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).timeout(const Duration(seconds: 10));

      // Reverse geocoding with timeout
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 10));

      // More robust city extraction
      String? city = placemarks.firstWhere(
            (placemark) => placemark.locality != null && placemark.locality!.isNotEmpty,
        orElse: () => Placemark(locality: "Astana"),
      ).locality;

      print("Actual coordinates: ${position.latitude}, ${position.longitude}");
      print("Full placemark data: ${placemarks.first.toJson()}");

      return city ?? "Astana";
    } catch (e) {
      print(" Location error details: $e");
      return "Astana"; // fallback to Astana
    }
  }
}
