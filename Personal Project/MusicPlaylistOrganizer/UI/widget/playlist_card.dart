import 'package:flutter/material.dart';
import '../../data/model/playlist.dart';
import 'package:provider/provider.dart';
import '../../data/provider/music_provider.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(playlist.name),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        bool confirmDelete = false;
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Playlist'),
              content: const Text(
                  'Are you sure you want to delete this playlist?'),
              actions: [
                TextButton(
                  onPressed: () {
                    confirmDelete = false;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    confirmDelete = true;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
        return confirmDelete;
      },
      onDismissed: (direction) {
        final provider = Provider.of<MusicProvider>(context, listen: false);
        final removedPlaylist = playlist;

        provider.removePlaylist(playlist.name);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted ${playlist.name}'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                provider.addPlaylistBack(removedPlaylist);
              },
            ),
            duration: const Duration(seconds: 10),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(playlist.name),
          subtitle: Text('${playlist.musicList.length} songs'),
          onTap: onTap,
        ),
      ),
    );
  }
}
