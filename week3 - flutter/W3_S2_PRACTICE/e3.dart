import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures Column takes only necessary space
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15), // Margin between items
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E7DF5), Color(0xff0B3CBD)],
                  ),
                ),
                child: const Text(
                  "OOP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E7DF5), Color(0xff0B3CBD)],
                  ),
                ),
                child: const Text(
                  "DART",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                    colors: [Color(0xff4E7DF5), Color(0xff0B3CBD)],
                  ),
                ),
                child: const Text(
                  "FLUTTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
