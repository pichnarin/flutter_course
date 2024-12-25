import 'package:flutter/material.dart';

import '../../data/model/music.dart';
import '../../data/model/playlist.dart';


class SaveToPlaylistDialog extends StatefulWidget {
  final List<Playlist> playlists;
  final Music music;
  final Function(String, Music) onSave;

  const SaveToPlaylistDialog({
    super.key,
    required this.playlists,
    required this.music,
    required this.onSave,
  });

  @override
  SaveToPlaylistDialogState createState() => SaveToPlaylistDialogState();
}

class SaveToPlaylistDialogState extends State<SaveToPlaylistDialog> {
  String? selectedPlaylist;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save to Playlist'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            hint: const Text('Select Playlist'),
            value: selectedPlaylist,
            onChanged: (value) {
              setState(() {
                selectedPlaylist = value;
              });
            },
            items: widget.playlists.map((playlist) {
              return DropdownMenuItem<String>(
                value: playlist.name,
                child: Text(playlist.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Create New Playlist',
            ),
          ),
        ],
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
            final playlistName = _controller.text.isNotEmpty
                ? _controller.text
                : selectedPlaylist;
            if (playlistName != null) {
              widget.onSave(playlistName, widget.music);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}