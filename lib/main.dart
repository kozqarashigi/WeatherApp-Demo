import 'pages/weather_page.dart' show WeatherPage;
import 'package:flutter/material.dart';
import 'package:midterm_project/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome!',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const WelcomePage(), // Start with WelcomePage
    );
  }
}