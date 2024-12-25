import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration duration;

  PositionData(this.position, this.duration);
}

class AudioPlayerService {
  final AudioPlayer audioPlayer = AudioPlayer();
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);
  Duration lastPausePosition = Duration.zero;
  String? _currentUrl;

  // Expose playback state streams for UI binding
  final _playlistController = StreamController<List<AudioSource>>.broadcast();

  Stream<List<AudioSource>> get playlistStream => _playlistController.stream;

  Stream<PositionData> get positionDataStream => Rx.combineLatest2<Duration, Duration?, PositionData>(
    audioPlayer.positionStream,
    audioPlayer.durationStream,
        (position, duration) => PositionData(position, duration ?? Duration.zero),
  );

  // Play a single song from a given URL
  Future<void> play(String url) async {
    try {
      if (_currentUrl == url && audioPlayer.playing) return;

      _currentUrl = url;

      // Check if URL exists in the playlist
      final index = _playlist.children.indexWhere(
            (source) => (source as UriAudioSource).uri.toString() == url,
      );

      if (index != -1) {
        // If the song is in the playlist, play it
        await audioPlayer.seek(Duration.zero, index: index);
      } else {
        // If not, set as a single audio source
        await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      }

      await audioPlayer.play();
      if (kDebugMode) print("Playing: $url");
    } catch (e) {
      if (kDebugMode) print("Error playing audio: $e");
    }
  }

  // Add a song to the playlist
  void addToPlaylist(String url) {
    try {
      final audioSource = AudioSource.uri(Uri.parse(url));
      _playlist.add(audioSource);
      _playlistController.add(_playlist.children);
      if (kDebugMode) print("Added to playlist: $url");
    } catch (e) {
      if (kDebugMode) print("Error adding to playlist: $e");
    }
  }

  void clearPlaylist() {
    try {
      _playlist.clear();
      _playlistController.add(_playlist.children);
      if (kDebugMode) print("Playlist cleared.");
    } catch (e) {
      if (kDebugMode) print("Error clearing playlist: $e");
    }
  }

  // Pause playback
  void pause() {
    lastPausePosition = audioPlayer.position;
    audioPlayer.pause();
    if (kDebugMode) print('Paused at ${audioPlayer.position}');
  }

  // Resume playback
  void resume() {
    if (audioPlayer.position != lastPausePosition) {
      audioPlayer.seek(lastPausePosition);
    }
    audioPlayer.play();
    if (kDebugMode) print('Resumed at ${audioPlayer.position}');
  }

  // Stop playback
  void stop() {
    audioPlayer.stop();
  }

  // Seek to a specific position
  void seek(Duration position) {
    try {
      audioPlayer.seek(position);
      if (kDebugMode) print("Seeked to: $position");
    } catch (e) {
      if (kDebugMode) print("Error seeking: $e");
    }
  }

  // Skip to the next song
  Future<void> next() async {
    if (audioPlayer.hasNext) {
      try {
        await audioPlayer.seekToNext();
        if (kDebugMode) print("Moved to next song.");
      } catch (e) {
        if (kDebugMode) print("Error moving to next song: $e");
      }
    } else {
      if (kDebugMode) print("No next song available.");
    }
  }

  // Skip to the previous song
  Future<void> previous() async {
    if (audioPlayer.hasPrevious) {
      try {
        await audioPlayer.seekToPrevious();
        if (kDebugMode) print("Moved to previous song.");
      } catch (e) {
        if (kDebugMode) print("Error moving to previous song: $e");
      }
    } else {
      if (kDebugMode) print("No previous song available.");
    }
  }

  // Enable or disable shuffle mode
  void setShuffleMode(bool enable) {
    try {
      audioPlayer.setShuffleModeEnabled(enable);
      if (kDebugMode) print("Shuffle mode: ${enable ? 'Enabled' : 'Disabled'}");
    } catch (e) {
      if (kDebugMode) print("Error setting shuffle mode: $e");
    }
  }

  // Shuffle playlist order
  void shufflePlaylist() {
    try {
      _playlist.children.shuffle();
      _playlistController.add(_playlist.children);
      if (kDebugMode) print("Playlist shuffled.");
    } catch (e) {
      if (kDebugMode) print("Error shuffling playlist: $e");
    }
  }

  // Set repeat mode (all, one, or none)
  void setRepeatMode(LoopMode loopMode) {
    try {
      audioPlayer.setLoopMode(loopMode);
      if (kDebugMode) print("Repeat mode set to $loopMode.");
    } catch (e) {
      if (kDebugMode) print("Error setting repeat mode: $e");
    }
  }

  // Set playback speed
  void setPlaybackSpeed(double speed) {
    try {
      audioPlayer.setSpeed(speed);
      if (kDebugMode) print("Playback speed set to $speed.");
    } catch (e) {
      if (kDebugMode) print("Error setting playback speed: $e");
    }
  }

  // Check if audio is currently playing
  bool get isPlaying => audioPlayer.playing;

  // Dispose of the audio player
  void dispose() {
    try {
      _playlistController.close();
      audioPlayer.dispose();
      if (kDebugMode) print("AudioPlayer disposed.");
    } catch (e) {
      if (kDebugMode) print("Error disposing AudioPlayer: $e");
    }
  }
}
