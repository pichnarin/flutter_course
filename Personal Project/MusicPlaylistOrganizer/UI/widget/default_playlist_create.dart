import 'package:flutter/material.dart';

class DefaultPlaylistCreate extends StatefulWidget {
  final Function(String) onCreate;

  const DefaultPlaylistCreate({super.key, required this.onCreate});

  @override
  DefaultPlaylistCreateState createState() => DefaultPlaylistCreateState();
}

class DefaultPlaylistCreateState extends State<DefaultPlaylistCreate> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Playlist'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Playlist Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onCreate(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}