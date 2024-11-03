import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HobbyCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color backgroundColor;

  const HobbyCard({
    super.key,
    required this.title,
    required this.icon,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 20), // Spacing between the icon and text
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Hobbies"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center all cards vertically
              children: [
                HobbyCard(
                  title: "Soccer",
                  icon: Icon(Icons.sports_soccer, color: Colors.white, size: 40),
                ),
                SizedBox(height: 20), // Space between cards
                HobbyCard(
                  title: "Reading",
                  icon: Icon(Icons.menu_book, color: Colors.white, size: 40),
                  backgroundColor: Colors.green,
                ),
                SizedBox(height: 20), // Space between cards
                HobbyCard(
                  title: "Coding",
                  icon: Icon(Icons.code, color: Colors.white, size: 40),
                  backgroundColor: Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
