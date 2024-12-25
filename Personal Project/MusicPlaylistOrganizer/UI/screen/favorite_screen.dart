import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/music.dart';
import '../../data/model/playlist.dart';
import '../../data/provider/music_provider.dart';
import '../../service/audio_player_service.dart';
import '../../service/base_player_screen.dart';
import '../widget/expand_player_card.dart';
import '../widget/minimize_player_card.dart';
import '../widget/music_list_tile.dart';
import '../widget/save_to_playlist_dialog.dart';

class FavoriteScreen extends StatefulWidget {
  final AudioPlayerService audioPlayerService;
  final Playlist favorite; // Accept Playlist, not List<Music>

  const FavoriteScreen({
    super.key,
    required this.audioPlayerService,
    required this.favorite,
  });

  @override
  State<FavoriteScreen> createState() => FavoriteScreenState();
}

class FavoriteScreenState extends BasePlayerScreen<FavoriteScreen> {
  @override
  List<Music> get currentPlaylist => widget.favorite.musicList; // Access musicList
  @override
  AudioPlayerService get audioPlayerService => widget.audioPlayerService;
  @override
  Playlist get playlist => widget.favorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          return currentPlaylist.isNotEmpty
              ? ListView.builder(
            itemCount: currentPlaylist.length,
            itemBuilder: (context, index) {
              final music = currentPlaylist[index];
              return MusicListTile(
                music: music,
                onTap: togglePlayer,
                onFavoriteToggle: () => provider.toggleLike(music),
                onSave: () => showDialog(
                  context: context,
                  builder: (context) => SaveToPlaylistDialog(
                    playlists: provider.playlists,
                    music: music,
                    onSave: (playlistName, music) {
                      provider.addPlaylist(playlistName, music);
                    },
                  ),
                ),
              );
            },
          )
              : const Center(
            child: Text(
              'No Favorites Yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        },
      ),
      bottomSheet: currentMusic != null ? _buildBottomSheet(context) : null,
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.deepPurple.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: const [
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
          onPlayPause: resumeOrPause,
          onRepeat: onRepeatPressed,
          onShuffle: onShufflePressed,
          onNext: playNextSong,
          onPrevious: playPreviousSong,
          onSliderChanged: onSliderChanged,
          onStop: stopSong,
          onFavorite: () => Provider.of<MusicProvider>(context, listen: false)
              .toggleLike(currentMusic!),
          onAddToPlaylist: () => showDialog(
            context: context,
            builder: (context) => SaveToPlaylistDialog(
              playlists: Provider.of<MusicProvider>(context).playlists,
              music: currentMusic!,
              onSave: (playlistName, music) {
                Provider.of<MusicProvider>(context, listen: false).addPlaylist(playlistName, music);
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
    );
  }
}
