//integrating the loop direct into the list

import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,

        body: Center(
          child: Column(
            children: [
              const Text("Start"),
              for (var i = 0; i < 10; i++) Text('Item $i'),
              const Text("End"),
            ],
          ),
        ),
      )
    )
  );
}