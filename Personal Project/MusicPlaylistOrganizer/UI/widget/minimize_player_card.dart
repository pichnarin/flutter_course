import 'package:flutter/material.dart';

import '../../data/model/music.dart';


class MinimizedPlayerCard extends StatelessWidget {
  final Music currentSong;
  final double currentPosition;
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onClose;
  final VoidCallback onExpand;
  final ValueChanged<double> onSliderChanged;
  final double value;
  final double min;
  final double max;

  const MinimizedPlayerCard({
    super.key,
    required this.currentSong,
    required this.currentPosition,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onClose,
    required this.onExpand,
    required this.value,
    required this.min,
    required this.max,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedValue = value.clamp(min, max);

    return GestureDetector(
      onTap: onExpand,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Song Image
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(currentSong.photoPath),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 16),

            // Song Details and Slider
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentSong.title,
                    style: const TextStyle(
                      fontSize: 16,
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
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
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
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Playback Controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.deepPurple,
                  ),
                  onPressed: onPlayPause,
                ),
                IconButton(
                  icon: const Icon(Icons.expand_less, color: Colors.deepPurple),
                  onPressed: onExpand,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}