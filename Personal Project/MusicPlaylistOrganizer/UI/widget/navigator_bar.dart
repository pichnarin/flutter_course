

import 'package:flutter/material.dart';
import 'package:music_app/MusicPlaylistOrganizer/UI/screen/favorite_screen.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/model/playlist.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/sample_data/sample_data.dart';
import 'package:provider/provider.dart';

import '../../data/provider/music_provider.dart';
import '../../service/audio_player_service.dart';
import '../screen/home_screen.dart';
import '../screen/playlist_screen.dart';

class MainApp extends StatefulWidget {
  final AudioPlayerService audioPlayerService;

  const MainApp({super.key, required this.audioPlayerService});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, provider, child) {
        // Create the favorite playlist by filtering liked songs
        final favoritePlaylist = Playlist(
          name: 'Favorites',
          musicList: provider.favoriteMusic,
        );

        final screens = [
          HomeScreen(
            audioPlayerService: widget.audioPlayerService,
            forYouPlaylist: SampleMusicData.getSampleMusic(),
          ),
          FavoriteScreen(
            audioPlayerService: widget.audioPlayerService,
            favorite: favoritePlaylist,
          ),
          PlaylistsScreen(audioPlayerService: widget.audioPlayerService),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play),
                label: 'Playlists',
              ),
            ],
          ),
        );
      },
    );
  }
}


