//handle each screen which is stateful widget(home_screen, playlist_detail_screen, favorite_screen, album_detail_screen) functionality in separate files

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/model/playlist.dart';
import 'package:music_app/MusicPlaylistOrganizer/service/audio_player_service.dart';
import '../data/model/music.dart';

abstract class BasePlayerScreen<T extends StatefulWidget> extends State<T>{
  Music? currentMusic; //catch track of the current music
  bool isExpanded = false; //u get the idea
  bool isPlaying = false;
  bool isSeeking = false;
  bool isShuffle = false;
  LoopMode isRepeat = LoopMode.off;
  double currentPosition = 0.0;
  Timer? debounceTimer; // Timer for the seek bar for the song progress
  StreamSubscription<Duration>? positionSub; // Stream subscription for the position for the seek slider update
  StreamSubscription<PlayerState>? playerStateSub; // Stream subscription for the player state for check if the song is completed

  //method to provide the current playlist and the current audio player service
  List<Music> get currentPlaylist;
  AudioPlayerService get audioPlayerService;
  Playlist get playlist;

  @override
  void initState(){
    super.initState();

    //listen to the position update for slider
    positionSub = audioPlayerService.audioPlayer.positionStream.listen((position){
      if(mounted && isPlaying && !isSeeking){
        setState(() {
          currentPosition = position.inSeconds.toDouble();
          pragma('Current position: $currentPosition');
        });
      }
    });

    //handle something when the song is completed
    playerStateSub = audioPlayerService.audioPlayer.playerStateStream.listen((playerState){
      if(mounted && playerState.processingState == ProcessingState.completed){
        playNextSong();
        const pragma('Song completed');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    positionSub?.cancel();
    playerStateSub?.cancel();
    debounceTimer?.cancel();

    const pragma('Disposing player screen');
  }

  //method to expand player and play the song
  void togglePlayer(Music music){
    setState(() {
      if(currentMusic != music){
        currentMusic = music;
        isExpanded = true;
        isPlaying = true;
        currentPosition = 0.0;
        pragma('Playing song: ${music.title}');
      }else{
        isExpanded = !isExpanded;
      }
    });

    audioPlayerService.play(music.musicPath);
  }

  //method to minimize the player
  void onMinimize(){
    setState(() {
      isExpanded = false;
    });
  }

  //method to resume or pause the song
  void resumeOrPause(){
    setState(() {
      isPlaying = !isPlaying;
      if(isPlaying){
        audioPlayerService.resume();
      }else{
        audioPlayerService.pause();
      }
    });
  }

  //method to stop the song
  void stopSong(){
    setState(() {
      isPlaying = false;
      isExpanded = false;
      audioPlayerService.seek(Duration.zero);
    });

    audioPlayerService.stop();
  }

  //method to play the next song
  void playNextSong() {
    // Catch the current index of the music
    final currentIndex = currentPlaylist.indexOf(currentMusic!);

    if (currentIndex != -1) {
      final nextIndex = (currentIndex + 1) % currentPlaylist.length;
      togglePlayer(currentPlaylist[nextIndex]);
    } else {
      setState(() {
        currentMusic = null;
        isPlaying = false;
        isExpanded = false;
      });

      audioPlayerService.stop();
    }
  }


  //method to play the previous song
  void playPreviousSong() {
    // Catch the current index of the music
    final currentIndex = currentPlaylist.indexOf(currentMusic!);

    if (currentIndex != -1) {
      // Calculate the next index using modulo for circular behavior
      final nextIndex = (currentIndex - 1) % currentPlaylist.length;
      togglePlayer(currentPlaylist[nextIndex]);
    } else {
      setState(() {
        currentMusic = null;
        isPlaying = false;
        isExpanded = false;
      });

      audioPlayerService.stop();
    }
  }


  //method to handle the seek bar change
  void onSliderChanged(double value){
    setState(() {
      isSeeking = true;
      currentPosition = value;
    });

    debounceTimer?.cancel();
    debounceTimer = Timer(const Duration(milliseconds: 500), (){
      audioPlayerService.seek(Duration(seconds: value.toInt()));
      setState(() {
        isSeeking = false;
      });
    });
  }

  void onShufflePressed() {
    setState(() {
      playlist.toggleShuffleMode();
    });

    audioPlayerService.setShuffleMode(playlist.isShuffled);
    pragma('Shuffle mode: ${playlist.isShuffled ? 'Enabled' : 'Disabled'}');
  }

  void onRepeatPressed() {
    setState(() {
      playlist.toggleRepeatMode();
    });

    audioPlayerService.setRepeatMode(playlist.isLooped);
    pragma('Repeat mode: ${playlist.isLooped == LoopMode.off ? 'Disabled' : 'Enabled'}');
  }


  void onClosedPressed(){
    setState(() {
      isExpanded = false;
      currentMusic = null;
    });
    audioPlayerService.stop();
  }

  void onExpandPressed(){
    setState(() {
      isExpanded = true;
    });
  }

  void onMinimizePressed(){
    setState(() {
      isExpanded = false;
    });
  }
}