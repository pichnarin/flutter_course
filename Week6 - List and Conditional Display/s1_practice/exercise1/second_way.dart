import 'package:flutter/material.dart';

List<String> numbers = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: Colors.white,

        body: Center(
          child: Column (
            children: [
              const Text("Start"),
              ...numbers.map((item) => Text(item)),
              const Text("End"),
            ],
          ),
        )
      )
    )
  );
}


