class Music {
  final String id;
  final String title;
  final double duration;
  final String artist;
  final String genre;
  final List<String> moods;
  final String musicPath;
  final String photoPath;
  bool isLiked;
  bool isPlaylistAdded;

  Music({
    required this.id,
    required this.title,
    required this.duration,
    required this.artist,
    required this.genre,
    required this.moods,
    required this.musicPath,
    required this.photoPath,
    this.isLiked = false,
    this.isPlaylistAdded = false,
  });

//method to clone the music object, useful when toggling the isLiked and isPlaylistAdded status
  Music copyWith({
    String? id,
    String? title,
    double? duration,
    String? artist,
    String? genre,
    List<String>? moods,
    String? musicPath,
    String? photoPath,
    bool? isLiked,
    bool? isPlaylistAdded,
  }) {
    return Music(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      artist: artist ?? this.artist,
      genre: genre ?? this.genre,
      moods: moods ?? this.moods,
      musicPath: musicPath ?? this.musicPath,
      photoPath: photoPath ?? this.photoPath,
      isLiked: isLiked ?? this.isLiked,
      isPlaylistAdded: isPlaylistAdded ?? this.isPlaylistAdded,
    );
  }


//toggle the isLiked status of the music
  Music toggleLike() {
    return copyWith(isLiked: !isLiked);
  }

  //toggle the isPlaylistAdded status of the music
Music togglePlaylistAdded(){
    return copyWith(isPlaylistAdded: !isPlaylistAdded);
}

//convert Music object to a string for debugging
@override
String toString() {
  return 'Music{id: $id, title: $title, duration: $duration, artist: $artist, genre: $genre, moods: $moods, musicPath: $musicPath, photoPath: $photoPath, isLiked: $isLiked, isPlaylistAdded: $isPlaylistAdded}';
}

  //override equality to compare two Music objects based on their ID
  @override
  bool operator ==(Object other){
    if(identical(this, other)) return true;
    return other is Music && other.id == id;
  }

  //override hashCode to match equality logic
  @override
  int get hashCode => id.hashCode;
}
