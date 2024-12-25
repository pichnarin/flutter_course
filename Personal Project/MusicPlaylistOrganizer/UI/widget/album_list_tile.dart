import 'package:flutter/material.dart';

import '../../data/model/playlist.dart';

class AlbumListTile extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const AlbumListTile({super.key, required this.playlist, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120, // Set a fixed width for the card
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Album Cover
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(playlist.image ?? 'assets/images/song_with_no_pic.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Album Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                playlist.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                '${playlist.musicList.length} songs',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}