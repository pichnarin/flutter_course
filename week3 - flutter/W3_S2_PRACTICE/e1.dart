import "package:flutter/material.dart";

void main(){
  
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Hello World",
            style: TextStyle(
              color: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: Text("Hello World"),
        ),
      ),
    ),
  );
}
