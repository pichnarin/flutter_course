import 'package:flutter/material.dart';

class FavoritefulCard extends StatefulWidget {
  final String title;
  final String description;

  const FavoritefulCard(
      {super.key, required this.description, required this.title});

  @override
  State<FavoritefulCard> createState() => _FavoritefulCardState();
}

class _FavoritefulCardState extends State<FavoritefulCard> {
  //attribute
  bool isFavorite = false;

  void isTouchingHeart() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align row items at the top
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8), // Add space between text items
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: isTouchingHeart,
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
          padding: EdgeInsets.all(16.0), // Add padding around the container
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align row items at the top
            children: [
              FavoritefulCard(
                  title: 'Tom and Jerry',
                  description:
                      'Tom and Jerry is an American animated franchise and series of comedy short films created in 1940 by William Hanna and Joseph Barbera.'),
              SizedBox(height: 10),
              FavoritefulCard(
                  title: 'Breaking Bad',
                  description:
                      'Breaking Bad is an American neo-Western crime drama television series created and produced by Vince Gilligan.'),
              SizedBox(height: 10),
              FavoritefulCard(
                title: 'True Detective',
                description:
                    'True Detective is an American anthology crime drama television series created by Nic Pizzolatto. ',
              ),
              SizedBox(height: 10),
              FavoritefulCard(
                  title: 'Game of Thrones',
                  description:
                      'Created by David Benioff, D.B. Weiss. With Peter Dinklage, Lena Headey, Kit Harington, Emilia Clarke. Nine noble families fight for control over the lands of Westeros, while an ancient enemy returns after being dormant for millennia.'),
            ],
          ),
        ),
      ),
    ));
