import 'package:flutter/material.dart';

List<String> numbers = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

List<Widget> getLabels() {
  return numbers.map((item) => Text(item)).toList();
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.white,

        body: Center(
          child: Column(
            children: [
              const Text("Start"),
              ...getLabels(),
              const Text("End"),
            ],
          ),
        ),
      ),
    ),
  );
}