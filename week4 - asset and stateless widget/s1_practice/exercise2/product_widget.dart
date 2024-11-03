import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Product { Dart, Flutter, Firebase }

extension ProductDetail on Product {
  String get title {
    switch (this) {
      case Product.Dart:
        return 'Dart';
      case Product.Flutter:
        return 'Flutter';
      case Product.Firebase:
        return 'Firebase';
    }
  }

  String get description {
    switch (this) {
      case Product.Dart:
        return 'The best object-oriented programming language';
      case Product.Flutter:
        return 'The best UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase';
      case Product.Firebase:
        return 'A platform developed by Google for creating mobile and web applications';
    }
  }

  String get imagePath {
    switch (this) {
      case Product.Dart:
        return 'assets/exercise2_asset/dart.png';
      case Product.Flutter:
        return 'assets/exercise2_asset/flutter.png';
      case Product.Firebase:
        return 'assets/exercise2_asset/firebase.png';
    }
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(product.imagePath), // Correctly load the image
            width: 100,
            height: 150,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              product.title, // Access the title via the enum
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              product.description, // Access the description via the enum
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("My Products"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView( // Changed from Column to ListView
            children: const [
              ProductCard(product: Product.Dart),
              SizedBox(height: 20),
              ProductCard(product: Product.Flutter),
              SizedBox(height: 20),
              ProductCard(product: Product.Firebase),
            ],
          ),
        ),
      ),
    ),
  );
}
