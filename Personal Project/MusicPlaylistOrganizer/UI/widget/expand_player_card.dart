import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/model/music.dart';

class ExpandedPlayerCard extends StatelessWidget {
  final Music currentSong;
  final double currentPosition;
  final bool isPlaying;
  final bool isShuffled;
  final LoopMode repeatMode;
  final VoidCallback? onPlayPause;
  final VoidCallback? onShuffle;
  final VoidCallback? onRepeat;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onStop;
  final VoidCallback? onClose;
  final VoidCallback? onMinimize;
  final VoidCallback? onFavorite;
  final VoidCallback? onAddToPlaylist;
  final ValueChanged<double>? onSliderChanged;

  final double value;
  final double min;
  final double max;

  const ExpandedPlayerCard({
    super.key,
    required this.currentSong,
    required this.currentPosition,
    required this.isPlaying,
    required this.isShuffled,
    required this.repeatMode,
    this.onShuffle,
    this.onRepeat,
    this.onPlayPause,
    this.onStop,
    this.onClose,
    this.onMinimize,
    this.onFavorite,
    this.onAddToPlaylist,
    required this.value,
    required this.min,
    required this.max,
    this.onSliderChanged,
    this.onNext,
    this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedValue = value.clamp(min, max);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
// Row with Photo, Title, Artist, Genre, and Tags
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(currentSong.photoPath),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentSong.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      currentSong.artist,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Genre: ${currentSong.genre}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tags: ${currentSong.moods.join(', ')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

// Song Progress Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              activeTrackColor: Colors.deepPurple,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Colors.deepPurple,
              overlayColor: Colors.deepPurple.withOpacity(0.2),
            ),
            child: Slider(
              value: clampedValue,
              min: min,
              max: max,
              onChanged: onSliderChanged,
            ),
          ),

// Progress Timestamps
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(currentPosition),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  formatDuration(currentSong.duration),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

// Playback Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
// Shuffle Button
              IconButton(
                onPressed: onShuffle,
                icon: Icon(
                  isShuffled ? Icons.shuffle_on : Icons.shuffle,
                  color: Colors.deepPurple,
                  size: 28,
                ),
              ),

// Previous Button
              if (onPrevious != null)
                ElevatedButton(
                  onPressed: onPrevious,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

// Play/Pause Button
              ElevatedButton(
                onPressed: onPlayPause,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.deepPurple,
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 28,
                ),
              ),

// Next Button
              if (onNext != null)
                ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

// Repeat Button
              IconButton(
                onPressed: onRepeat,
                icon: Icon(
                  repeatMode == LoopMode.all
                      ? Icons.repeat
                      : repeatMode == LoopMode.one
                          ? Icons.repeat_one
                          : Icons.repeat,
                  color: Colors.deepPurple,
                  size: 28,
                ),
              ),

// Stop Button
              if (onStop != null)
                ElevatedButton(
                  onPressed: onStop,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

// Favorite and Playlist Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: currentSong.isLiked
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border, color: Colors.grey),
                onPressed: onFavorite,
              ),
              IconButton(
                icon: currentSong.isPlaylistAdded
                    ? const Icon(Icons.playlist_add_check, color: Colors.green)
                    : const Icon(Icons.playlist_add, color: Colors.grey),
                onPressed: onAddToPlaylist,
              ),
            ],
          ),
          const SizedBox(height: 20),

// Minimize Button
          ElevatedButton(
            onPressed: onMinimize,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Minimize',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Formats a duration in seconds into a "mm:ss" format.
  String formatDuration(double duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration ~/ 60);
    final seconds = twoDigits((duration % 60).toInt());
    return '$minutes:$seconds';
  }
}
