import 'package:flutter/foundation.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/model/music.dart';
import 'package:music_app/MusicPlaylistOrganizer/data/sample_data/sample_data.dart';
import 'package:music_app/MusicPlaylistOrganizer/service/snackbar_sms_service.dart';

import '../model/playlist.dart';

class MusicProvider with ChangeNotifier {
  final List<Playlist> _forYou = SampleMusicData.getSampleMusic();
  final List<Playlist> _album = SampleAlbumData.getSampleAlbums();
  final List<Music> _favorite = [];
  final List<Playlist> _playlist = SampleDataPlaylist.getSamplePlaylists();

  List<Playlist> get allMusic => _forYou;
  List<Playlist> get album => _album;
  List<Music> get favoriteMusic => _favorite;
  List<Playlist> get playlists => _playlist;

  // toggle like
  void toggleLike(Music music) {
    bool isAlreadyLiked = _favorite.contains(music);

    if (isAlreadyLiked) {
      _favorite.remove(music);
      music.isLiked = false;
      SnackBarSmsService.showSnackBar('Removed from favorites: ${music.title}');
    } else {
      _favorite.add(music);
      music.isLiked = true;
      SnackBarSmsService.showSnackBar('Added to favorites: ${music.title}');
    }
    notifyListeners();
  }

  // add playlist
  void addPlaylist(String playlistName, Music music) {
    final playlist = _playlist.firstWhere(
          (playlist) => playlist.name == playlistName,
      orElse: () {
        final newPlaylist = Playlist(name: playlistName, musicList: []);
        _playlist.add(newPlaylist);
        SnackBarSmsService.showSnackBar('Created playlist: $playlistName');
        return newPlaylist;
      },
    );
    if (!playlist.musicList.contains(music)) {
      playlist.musicList.add(music);
      SnackBarSmsService.showSnackBar('Added to playlist: ${music.title}');
      notifyListeners();
    } else {
      if (kDebugMode) print('This song is already in the playlist.');
      SnackBarSmsService.showSnackBar('This song is already in the playlist.');
    }
  }

  // add song to playlist
  void addSongToPlaylist(Playlist playlist, Music music) {
    if (!playlist.musicList.contains(music)) {
      playlist.musicList.add(music);
      SnackBarSmsService.showSnackBar('Added to playlist: ${music.title}');
      notifyListeners();
    } else {
      SnackBarSmsService.showSnackBar('This song is already in the playlist.');
    }
  }

  // remove music from playlist
  void removeMusicFromPlaylist(Music music, Playlist playlist) {
    if (kDebugMode) print('Removing ${music.title} from playlist ${playlist.name}');
    playlist.musicList.remove(music);
    SnackBarSmsService.showSnackBar('Removed from playlist: ${music.title}');
    SnackBarSmsService.showSnackBar('Remaining songs: ${playlist.musicList.length}');
    notifyListeners();
  }

  // get playlist by name
  Playlist getPlaylistByName(String name) {
    return _playlist.firstWhere((playlist) => playlist.name == name);
  }

  // create playlist
  void createPlaylist(String playlistName) {
    final newPlaylist = Playlist(name: playlistName, musicList: []);
    _playlist.add(newPlaylist);
    SnackBarSmsService.showSnackBar('Created playlist: $playlistName');
    notifyListeners();
  }


  // remove playlist
  void removePlaylist(String playlistName) {
    _playlist.removeWhere((playlist) => playlist.name == playlistName);
    SnackBarSmsService.showSnackBar('Removed playlist: $playlistName');
    notifyListeners();
  }

  // clear playlist
  void clearPlaylist(Playlist playlist) {
    playlist.musicList.clear();
    notifyListeners();
  }

  // Generate playlist based on user moods
  void generatePlaylistBasedOnMood(String moodsInput) {
    final moods = moodsInput.split(',').map((mood) => mood.trim().toLowerCase()).toList();
    final playlistName = 'Moods: ${moodsInput.toUpperCase()}';
    final playlist = Playlist(name: playlistName, musicList: []);

    for (var forYouPlaylist in _forYou) {
      for (var music in forYouPlaylist.musicList) {
        if (music.moods.any((m) => moods.contains(m.toLowerCase()))) {
          playlist.musicList.add(music);
          SnackBarSmsService.showSnackBar('Added to playlist: ${music.title}');
        }
      }
    }

    _playlist.add(playlist);
    notifyListeners();
  }

  // add playlist back
  void addPlaylistBack(Playlist removedPlaylist) {
    _playlist.add(removedPlaylist);
    notifyListeners();
  }
}