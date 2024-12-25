import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/MusicPlaylistOrganizer/service/base_player_screen.dart';
import 'package:provider/provider.dart';

import '../../data/model/music.dart';
import '../../data/model/playlist.dart';
import '../../service/audio_player_service.dart';
import '../../data/provider/music_provider.dart';
import '../widget/expand_player_card.dart';
import '../widget/minimize_player_card.dart';
import '../widget/playlist_detail_list_tile.dart';
import '../widget/save_to_playlist_dialog.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final Playlist playlist;
  final AudioPlayerService audioPlayerService;

  const PlaylistDetailScreen({
    super.key,
    required this.playlist,
    required this.audioPlayerService,
  });

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends BasePlayerScreen<PlaylistDetailScreen> {

  @override
  AudioPlayerService get audioPlayerService => widget.audioPlayerService;

  @override
  List<Music> get currentPlaylist => widget.playlist.musicList;

  @override
  Playlist get playlist => widget.playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist.name),
      ),
      body: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: currentPlaylist.length,
            itemBuilder: (context, index) {
              final music = currentPlaylist[index];
              return PlaylistDetailListTile(
                music: music,
                onTap: togglePlayer,
                onDelete: () {
                  provider.removeMusicFromPlaylist(music, widget.playlist);
                },
              );
            },
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
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isExpanded)
                  ExpandedPlayerCard(
                    currentSong: currentMusic!,
                    currentPosition: currentPosition,
                    isPlaying: isPlaying,
                    isShuffled: playlist.isShuffled,
                    repeatMode: playlist.isLooped,
                    onPlayPause: resumeOrPause,
                    onNext: playNextSong,
                    onPrevious: playPreviousSong,
                    onShuffle: onShufflePressed,
                    onRepeat: onRepeatPressed,
                    onSliderChanged: onSliderChanged,
                    onStop: stopSong,
                    onClose: onClosedPressed,
                    onFavorite: () => Provider.of<MusicProvider>(context, listen: false).toggleLike(currentMusic!),
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
                  ),
                if (!isExpanded)
                  MinimizedPlayerCard(
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
              ],
            ),
          ),
        ),
      )
          : null,
    );
  }
}