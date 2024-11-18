import 'package:flutter/material.dart';
import 'package:flutter_leasson/w6/s1_practice/exercise3/screen/temperature.dart';
import 'package:flutter_leasson/w6/s1_practice/exercise3/screen/welcome.dart';


class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool _showWelcomeScreen = true;

  void _toggleScreen() {
    setState(() {
      _showWelcomeScreen = !_showWelcomeScreen;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _showWelcomeScreen ? Welcome(onStart: _toggleScreen) : TemperatureScreen(onBack: _toggleScreen),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}