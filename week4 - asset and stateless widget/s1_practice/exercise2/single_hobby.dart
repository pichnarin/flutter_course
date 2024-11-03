import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("My Hobbies"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView( // Changed from Column to ListView for scrolling
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity, // Make the container full width
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/exercise2_asset/dart.png'),
                      width: 100,
                      height: 100, // Adjust height to fit in the container
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Dart",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "The best object-oriented programming language",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Space between cards
              // You can add more hobby cards here
            ],
          ),
        ),
      ),
    ),
  );
}
