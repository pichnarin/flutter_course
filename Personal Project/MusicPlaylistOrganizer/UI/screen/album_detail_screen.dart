import 'package:flutter/material.dart';
import 'package:music_app/MusicPlaylistOrganizer/UI/widget/music_list_tile.dart';
import 'package:music_app/MusicPlaylistOrganizer/service/audio_player_service.dart';
import 'package:provider/provider.dart';

import '../../data/model/playlist.dart';
import '../../data/model/music.dart';
import '../../data/provider/music_provider.dart';
import '../../service/base_player_screen.dart';
import '../widget/playlist_detail_list_tile.dart';
import '../widget/expand_player_card.dart';
import '../widget/minimize_player_card.dart';
import '../widget/save_to_playlist_dialog.dart';

class AlbumDetailScreen extends StatefulWidget {
  final AudioPlayerService audioPlayerService;
  final Playlist album;

  const AlbumDetailScreen({
    super.key,
    required this.audioPlayerService,
    required this.album,
  });

  @override
  State<AlbumDetailScreen> createState() => AlbumDetailScreenState();
}

class AlbumDetailScreenState extends BasePlayerScreen<AlbumDetailScreen> {
  @override
  List<Music> get currentPlaylist => widget.album.musicList;

  @override
  AudioPlayerService get audioPlayerService => widget.audioPlayerService;

  @override
  Playlist get playlist => widget.album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.name),
        backgroundColor: Colors.deepPurple,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: currentPlaylist.length,
        itemBuilder: (context, index) {
          final music = currentPlaylist[index];
          return MusicListTile(
            music: music,
            onTap: togglePlayer,
            onFavoriteToggle: () {
              Provider.of<MusicProvider>(context, listen: false).toggleLike(music);
            },
            onSave: () => showDialog(
              context: context,
              builder: (context) => SaveToPlaylistDialog(
                playlists: Provider.of<MusicProvider>(context, listen: false).playlists,
                music: music,
                onSave: (playlistName, music) {
                  Provider.of<MusicProvider>(context, listen: false).addPlaylist(playlistName, music);
                },
              ),
            ),
          );
        },
      ),
      bottomSheet: currentMusic != null
          ? AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(
          maxHeight: isExpanded
              ? MediaQuery.of(context).size.height * 0.9
              : MediaQuery.of(context).size.height * 2,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 15,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: isExpanded
              ? ExpandedPlayerCard(
            currentSong: currentMusic!,
            currentPosition: currentPosition,
            isPlaying: isPlaying,
            isShuffled: playlist.isShuffled,
            repeatMode: playlist.isLooped,
            onAddToPlaylist: () => showDialog(
              context: context,
              builder: (context) => SaveToPlaylistDialog(
                playlists: Provider.of<MusicProvider>(context, listen: false).playlists,
                music: currentMusic!,
                onSave: (playlistName, music) {
                  Provider.of<MusicProvider>(context, listen: false).addPlaylist(playlistName, music);
                },
              ),
            ),
            onFavorite: () {
              Provider.of<MusicProvider>(context, listen: false).toggleLike(currentMusic!);
            },
            onPlayPause: resumeOrPause,
            onRepeat: onRepeatPressed,
            onShuffle: onShufflePressed,
            onNext: playNextSong,
            onPrevious: playPreviousSong,
            onSliderChanged: onSliderChanged,
            onStop: stopSong,
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
