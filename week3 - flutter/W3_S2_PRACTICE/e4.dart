import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomCard extends StatelessWidget {

  final String text;
  final Color? color;

  const CustomCard({super.key,this.text = "hello", this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), // Margin between items
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
          color: color,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 35,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures Column takes only necessary space
            children: [
              CustomCard(text: "OOP", color: Color(0xff4E7DF5)),
              CustomCard(text: "DART", color: Color(0xff0B3CBD)),
              CustomCard(text: "FLUTTER", color: Color(0xff4E7DF5)),
            ],
          ),
        ),
      ),
    )
  );
}

