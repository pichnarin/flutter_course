import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavoritelessCard extends StatelessWidget {
  //attribute
  final bool isFavorite;
  final String title;
  final String description;

  const FavoritelessCard(
      {super.key,
      required this.title,
      required this.description,
      required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align row items at the top
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8), // Add space between text items
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            if (kDebugMode) {
              print(title);
            }
          },
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: 30,
          ),
        ),
      ],
    );
  }
}

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite List'),
          backgroundColor: Colors.blueAccent,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align row items at the top
            children: [
              FavoritelessCard(
                title: 'Tom and Jerry',
                description:
                    'Tom and Jerry is an American animated franchise and series of comedy short films created in 1940 by William Hanna and Joseph Barbera.',
                isFavorite: false,
              ),
              SizedBox(height: 8),
              FavoritelessCard(
                title: 'Breaking Bad',
                description:
                    'Breaking Bad is an American neo-Western crime drama television series created and produced by Vince Gilligan.',
                isFavorite: true,
              ),
              SizedBox(
                height: 8,
              ),
              FavoritelessCard(
                title: 'True Detective',
                description:
                    'True Detective is an American anthology crime drama television series created by Nic Pizzolatto. ',
                isFavorite: false,
              )
            ],
          ),
        ))));
