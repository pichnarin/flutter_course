import 'package:flutter/material.dart';
import 'screen/device_converter.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Money Converter"),
          backgroundColor: Colors.green.shade600,
        ),
        body: const Center(
          child: DeviceConverter(),
        ),
      ),
    ),
  );
}
