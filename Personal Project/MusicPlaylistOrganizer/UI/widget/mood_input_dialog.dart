import 'package:flutter/material.dart';

class MoodInputDialog extends StatelessWidget {
  final Function(String) onGeneratePlaylist;

  const MoodInputDialog({required this.onGeneratePlaylist, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController moodController = TextEditingController();

    return AlertDialog(
      title: const Text('Enter your mood'),
      content: TextField(
        controller: moodController,
        decoration: const InputDecoration(hintText: 'Mood'),
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
            final mood = moodController.text;
            if (mood.isNotEmpty) {
              onGeneratePlaylist(mood);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Generate'),
        ),
      ],
    );
  }
}