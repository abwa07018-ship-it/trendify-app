import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TrendifyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoPlay;

  const TrendifyVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoPlay = true,
  });

  @override
  State<TrendifyVideoPlayer> createState() => _TrendifyVideoPlayerState();
}

class _TrendifyVideoPlayerState extends State<TrendifyVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await _controller.initialize();
      if (!mounted) return;
      setState(() {
        _isInitialized = true;
      });
      if (widget.autoPlay) {
        _controller.play();
        _controller.setLooping(true);
      }
    } catch (e) {
      print('TrendifyVideoPlayer error: $e');
      try {
        await _controller.dispose();
        // ignore: deprecated_member_use
        _controller = VideoPlayerController.network(widget.videoUrl);
        await _controller.initialize();
        if (!mounted) return;
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });
        if (widget.autoPlay) {
          _controller.play();
          _controller.setLooping(true);
        }
      } catch (fallbackError) {
        if (!mounted) return;
        setState(() {
          _hasError = true;
          _errorMessage = 'Could not load video.';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.error_outline, color: Colors.red, size: 48),
        ),
      );
    }
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying) { _controller.pause(); } else { _controller.play(); }
        });
      },
      child: VideoPlayer(_controller),
    );
  }
}