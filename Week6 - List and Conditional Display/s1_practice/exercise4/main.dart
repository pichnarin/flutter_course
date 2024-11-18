import 'package:flutter/material.dart';
import 'database/jokes.dart';
import 'Card/joke_card.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(MaterialApp(
  home: Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: appColor,
      title: const Text("Favorite Jokes"),
    ),
    body: const JokeList(),
  ),
));

class JokeList extends StatefulWidget {
  const JokeList({super.key});

  @override
  State<JokeList> createState() => _JokeListState();
}

class _JokeListState extends State<JokeList> {
  int? _favoriteJokeIndex;

  void _setFavoriteJoke(int index) {
    setState(() {
      _favoriteJokeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        return JokeCard(
          joke: jokes[index],
          isFavorite: _favoriteJokeIndex == index,
          onFavoriteClick: () => _setFavoriteJoke(index),
        );
      },
    );
  }
}