import 'package:flutter/material.dart';
import '../../models/video_model.dart';
import '../../widgets/trendify_video_player.dart';

class FeedScreen extends StatelessWidget {
  final List<VideoModel> videos;

  const FeedScreen({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            TrendifyVideoPlayer(videoUrl: video.videoUrl),
            Positioned(
              bottom: 80,
              left: 16,
              right: 72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '@${video.username}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (video.hasTrendBadge) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.pinkAccent, Colors.cyanAccent],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'TREND',
                            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    video.caption,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: video.tags
                        .map((tag) => Text(
                              '#$tag',
                              style: const TextStyle(color: Colors.white70, fontSize: 13),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              bottom: 100,
              child: Column(
                children: [
                  _SideButton(icon: Icons.favorite, label: '${video.stats.likes}'),
                  const SizedBox(height: 20),
                  _SideButton(icon: Icons.comment, label: '${video.stats.comments}'),
                  const SizedBox(height: 20),
                  _SideButton(icon: Icons.share, label: '${video.stats.shares}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SideButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SideButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
