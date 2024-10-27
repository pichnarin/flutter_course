// In this exercise, you will be working with the following widgets
// • Container: A customizable box for layout and styling.
// • Text: Displays text.
// • Center: Aligns a child widget to the center
// And the following classes
// • EdgeInsets: Sets padding or margin.
// • BoxDecoration: Styles a container's background, border, etc.
// • BorderRadius: Rounds container corner

import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(
      home: Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.all(20),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "CADT STUDENTS",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
    ),
  )));
}
