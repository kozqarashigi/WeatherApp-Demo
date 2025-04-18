import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:midterm_project/pages/weather_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            Lottie.asset(
              'assets/logo.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.error_outline,
                size: 50,
                color: Colors.blueGrey,
              ),
            ),

            const Text(
              'WeatherApp',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontFamily: 'Montserrat',
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.purpleAccent,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                'by Ulzhan and Dilyara',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Loading animation
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: Center(
                        child: Lottie.asset(
                          'assets/loading.json',
                          width: 150,
                          height: 150,
                        ),
                      ),
                    );
                  },
                );

                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop(); // Close loading dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WeatherPage()),
                  );
                });
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}