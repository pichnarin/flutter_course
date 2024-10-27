import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  //button property
  final String text;
  final Color startColor;
  final Color endColor;

  const GradientButton(
      {super.key,
      required this.text,
      required this.startColor,
      required this.endColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(colors: [startColor, endColor]),
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
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(text: "HELLO1", startColor: Color(0xff4E7DF5), endColor: Color(0xff0B3CBD)),
            GradientButton(text: "HELLO2", startColor: Color(0xff4E7DF5), endColor: Color(0xff0B3CBD)),
            GradientButton(text: "HELLO3", startColor: Color(0xff4E7DF5), endColor: Color(0xff0B3CBD)),
          ],
        ),
      ),
    ),
  );
}
