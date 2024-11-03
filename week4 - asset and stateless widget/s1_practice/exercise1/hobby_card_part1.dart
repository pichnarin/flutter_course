import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Hobbies"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: 100,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
                  children: [
                    Icon(Icons.sports_soccer, color: Colors.white, size: 40),
                    SizedBox(width: 20), // Spacing between the icon and text
                    Text(
                      "Soccer",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
