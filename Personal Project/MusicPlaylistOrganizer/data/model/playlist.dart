import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/model/music.dart';

class Playlist {
  final String name;
  String? image;
  List<Music> musicList;
  bool isShuffled;
  LoopMode isLooped;
  List<Music> originalPlaylist;

  Playlist({required this.name, this.image, this.musicList = const [
  ], this.isShuffled = false, this.isLooped = LoopMode.off})
      : originalPlaylist = List.from(musicList);

  List<Music> get getOriginalPlaylist => List.from(musicList);

//add song to playlist
  void addSong(Music music) {
    if (!musicList.contains(music)) {
      musicList.add(music);
    }
  }

  //remove song from playlist
  void removeSong(Music music) {
    musicList.remove(music);
  }

//clear all music from playlist
  void clearAll() {
    musicList.clear();
  }

//create a modified copy of playlist, useful for immutable operations
  Playlist copyWith({String? name, List<
      Music>? musicList, bool? isShuffled, LoopMode? isLooped}) {
    return Playlist(
      name: name ?? this.name,
      musicList: musicList ?? this.musicList,
      isShuffled: isShuffled ?? this.isShuffled,
      isLooped: isLooped ?? this.isLooped,
    );
  }


//override the equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist && other.name == name;
  }

  //override the hashcode
  @override
  int get hashCode => name.hashCode ^ musicList.hashCode;

  //convert playlist object to string for debugging
  @override
  String toString() {
    return 'Playlist{name: $name, musicList: $musicList}';
  }


  // Toggle shuffle mode
  void toggleShuffleMode() {
    if (musicList.isEmpty) {
      if (kDebugMode) print("Cannot shuffle an empty playlist.");
      return;
    }

    if (!isShuffled) {
      originalPlaylist = List.from(musicList);
      musicList.shuffle();
      if (kDebugMode) print("Playlist shuffled.");
    } else {
      musicList = List.from(originalPlaylist);
      if (kDebugMode) print("Playlist order restored.");
    }

    isShuffled = !isShuffled;
  }

  // Toggle repeat mode
  void toggleRepeatMode() {
    if (isLooped == LoopMode.off) {
      isLooped = LoopMode.one;
    } else {
      isLooped = LoopMode.off;
    }
  }
}


//testing the shuffle mode
void main() {
  final playlist = Playlist(name: 'My Playlist', musicList: [
    Music(
      id: '1',
      title: 'Can\'t Help Falling in Love',
      artist: 'Elvis Presley',
      musicPath: 'assets/songs/canthelpfallinginlovewithu.mp3',
      photoPath: 'assets/images/canthelptofallinginlovewithyouavif.png',
      duration: 180,
      genre: 'Romantic',
      moods: ['Love', 'Slow', 'Classic'],
    ),
    Music(
      id: '2',
      title: 'Careless Whisper',
      artist: 'George Michael',
      musicPath: 'assets/songs/carelesswhisper.mp3',
      photoPath: 'assets/images/carelesswhisperavif.png',
      duration: 190,
      genre: 'Pop',
      moods: ['Love', 'Heartbreak', '80s'],
    ),
    Music(
      id: '3',
      title: 'Despacito',
      artist: 'Luis Fonsi ft. Daddy Yankee',
      musicPath: 'assets/songs/despacito.mp3',
      photoPath: 'assets/images/despacitoavif.png',
      duration: 200,
      genre: 'Latin',
      moods: ['Party', 'Upbeat', 'Summer'],
    ),
    Music(
      id: '4',
      title: 'How Deep Is Your Love',
      artist: 'Bee Gees',
      musicPath: 'assets/songs/howdeepisyourlove.mp3',
      photoPath: 'assets/images/howdeepisyourloveavif.png',
      duration: 210,
      genre: 'Disco',
      moods: ['Love', 'Classic', '70s'],
    ),
    Music(
      id: '5',
      title: 'I Want It That Way',
      artist: 'Backstreet Boys',
      musicPath: 'assets/songs/iwantitthatway.mp3',
      photoPath: 'assets/images/iwantitthatwayavif.png',
      duration: 220,
      genre: 'Pop',
      moods: ['Boyband', '90s', 'Nostalgic'],
    ),
    Music(
      id: '6',
      title: 'Just the Two of Us',
      artist: 'Grover Washington Jr. and Bill Withers',
      musicPath: 'assets/songs/justthetwoofus.mp3',
      photoPath: 'assets/images/justthetwoofusavif.png',
      duration: 230,
      genre: 'Jazz',
      moods: ['Love', 'Soulful', 'Classic'],
    ),
  ]);

  print('Original playlist: ${playlist.musicList.map((e) => e.title).join(', ')}');
  playlist.toggleShuffleMode();
  print('Shuffled playlist: ${playlist.musicList.map((e) => e.title).join(', ')}');
  playlist.toggleShuffleMode();
  print('Restored playlist: ${playlist.musicList.map((e) => e.title).join(', ')}');
}
