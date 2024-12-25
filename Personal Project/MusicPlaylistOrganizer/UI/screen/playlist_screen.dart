import 'package:flutter/material.dart';
import 'package:music_app/MusicPlaylistOrganizer/UI/screen/playlist_detail_screen.dart';
import 'package:music_app/MusicPlaylistOrganizer/UI/widget/default_playlist_create.dart';
import 'package:provider/provider.dart';

import '../../data/provider/music_provider.dart';
import '../../service/audio_player_service.dart';
import '../widget/mood_input_dialog.dart';
import '../widget/playlist_card.dart';

class PlaylistsScreen extends StatelessWidget {
  final AudioPlayerService audioPlayerService;

  const PlaylistsScreen({super.key, required this.audioPlayerService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Playlists',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 4,
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          if (provider.playlists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_music,
                    size: 80,
                    color: Colors.deepPurple.shade200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No playlists available',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ListView.builder(
              itemCount: provider.playlists.length,
              itemBuilder: (context, index) {
                final playlist = provider.playlists[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: PlaylistCard(
                    playlist: playlist,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistDetailScreen(
                            playlist: playlist,
                            audioPlayerService: audioPlayerService,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'moodButton',
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MoodInputDialog(
                    onGeneratePlaylist: (mood) {
                      Provider.of<MusicProvider>(context, listen: false)
                          .generatePlaylistBasedOnMood(mood);
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.mood, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'addButton',
            backgroundColor: Colors.deepPurple,
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return DefaultPlaylistCreate(
                        onCreate: (playlistName){
                          Provider.of<MusicProvider>(context, listen: false)
                              .createPlaylist(playlistName);
                        }
                    );
                  });
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}