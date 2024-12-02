// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late CachedVideoPlayerPlusController controller;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  Future<void> _initializeController() async {
    try {
      controller = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(widget.videoUrl),
        httpHeaders: {
          'Connection': 'keep-alive',
        },
        invalidateCacheIfOlderThan: const Duration(minutes: 10),
      );

      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();

      setState(() {
        isError = false; // Reset error state
      });
    } catch (e) {
      debugPrint('Video initialization error: $e');
      setState(() {
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Center(
        child: isError
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Failed to load video',
                    style: TextStyle(color: Colors.red),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _initializeController,
                  ),
                ],
              )
            : (controller.value.isInitialized
                ? CachedVideoPlayerPlus(controller)
                : const CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

//! video player

class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        // 'https://api-dev.wave5wireless.ng/content/getImage/adverts/b6b13ae8-f17e-428e-b2e0-892e5b9a3513.mp4'
        ))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
