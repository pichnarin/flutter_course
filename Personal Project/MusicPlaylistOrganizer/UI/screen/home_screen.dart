import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/music.dart';
import '../../data/model/playlist.dart';
import '../../data/provider/music_provider.dart';
import '../../service/audio_player_service.dart';
import '../../service/base_player_screen.dart';
import '../widget/album_list_tile.dart';
import '../widget/expand_player_card.dart';
import '../widget/minimize_player_card.dart';
import '../widget/mood_input_dialog.dart';
import '../widget/music_list_tile.dart';
import '../widget/save_to_playlist_dialog.dart';
import 'album_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final AudioPlayerService audioPlayerService;
  final List<Playlist> forYouPlaylist;

  const HomeScreen({
    super.key,
    required this.audioPlayerService,
    required this.forYouPlaylist,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends BasePlayerScreen<HomeScreen> {
  @override
  List<Music> get currentPlaylist =>
      widget.forYouPlaylist.isNotEmpty ? widget.forYouPlaylist.first.musicList : [];

  @override
  AudioPlayerService get audioPlayerService => widget.audioPlayerService;

  @override
  Playlist get playlist => widget.forYouPlaylist.first;

  @override
  Widget build(BuildContext context) {
    if (currentPlaylist.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Albums',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.album.length,
                  itemBuilder: (context, index) {
                    final album = provider.album[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: AlbumListTile(
                        playlist: album,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumDetailScreen(
                                album: album,
                                audioPlayerService: widget.audioPlayerService,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: currentPlaylist.length,
                  itemBuilder: (context, index) {
                    final music = currentPlaylist[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: MusicListTile(
                        music: music,
                        onTap: togglePlayer,
                        onFavoriteToggle: () {
                          Provider.of<MusicProvider>(context, listen: false)
                              .toggleLike(music);
                        },
                        onSave: () => showDialog(
                          context: context,
                          builder: (context) => SaveToPlaylistDialog(
                            playlists: Provider.of<MusicProvider>(context, listen: false).playlists,
                            music: music,
                            onSave: (playlistName, music) {
                              Provider.of<MusicProvider>(context, listen: false)
                                  .addPlaylist(playlistName, music);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: currentMusic != null
          ? AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: isExpanded
              ? ExpandedPlayerCard(
            currentSong: currentMusic!,
            currentPosition: currentPosition,
            isPlaying: isPlaying,
            isShuffled: playlist.isShuffled,
            repeatMode: playlist.isLooped,
            onShuffle: onShufflePressed,
            onRepeat: onRepeatPressed,
            onPlayPause: resumeOrPause,
            onNext: playNextSong,
            onPrevious: playPreviousSong,
            onSliderChanged: onSliderChanged,
            onStop: stopSong,
            onFavorite: () =>
                Provider.of<MusicProvider>(context, listen: false)
                    .toggleLike(currentMusic!),
            onAddToPlaylist: () => showDialog(
              context: context,
              builder: (context) => SaveToPlaylistDialog(
                playlists:
                Provider.of<MusicProvider>(context).playlists,
                music: currentMusic!,
                onSave: (playlistName, music) {
                  Provider.of<MusicProvider>(context, listen: false)
                      .addPlaylist(playlistName, music);
                },
              ),
            ),
            value: currentPosition,
            min: 0,
            max: currentMusic!.duration.toDouble(),
            onMinimize: onMinimize,
          )
              : MinimizedPlayerCard(
            currentSong: currentMusic!,
            currentPosition: currentPosition,
            isPlaying: isPlaying,
            onPlayPause: resumeOrPause,
            onSliderChanged: onSliderChanged,
            onClose: onClosedPressed,
            onExpand: onExpandPressed,
            value: currentPosition,
            min: 0,
            max: currentMusic!.duration.toDouble(),
          ),
        ),
      )
          : null,
    );
  }
}
