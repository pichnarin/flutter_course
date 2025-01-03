import 'package:flutter/material.dart';

class TemperatureScreen extends StatelessWidget {
  final VoidCallback onBack;

  TemperatureScreen({super.key, required this.onBack});

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final InputDecoration inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: 'Enter a temperature',
      hintStyle: const TextStyle(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.thermostat_outlined,
                size: 120,
                color: Colors.white,
              ),
              const Center(
                child: Text(
                  "Converter",
                  style: TextStyle(color: Colors.white, fontSize: 45),
                ),
              ),
              const SizedBox(height: 50),
              const Text("Temperature in Degrees:"),
              const SizedBox(height: 10),
              TextField(
                  decoration: inputDecoration,
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 30),
              const Text("Temperature in Fahrenheit:"),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: textDecoration,
                  child: const Text('test')),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1.0, color: Colors.white)),
                child: const Text('Back to Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              )
            ],
          )),
    );
  }
}