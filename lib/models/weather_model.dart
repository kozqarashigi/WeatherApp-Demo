class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int? humidity;
  final double? windSpeed;
  final double? feelsLike;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    this.humidity,
    this.windSpeed,
    this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name']?.toString() ?? 'Unknown City',
      temperature: double.parse(json['main']?['temp']?.toString() ?? '0'),
      mainCondition: json['weather']?[0]?['main']?.toString() ?? 'Unknown',
      humidity: json['main']?['humidity']?.toInt(),
      windSpeed: json['wind']?['speed']?.toDouble(),
      feelsLike: json['main']?['feels_like']?.toDouble(),
    );
  }
}