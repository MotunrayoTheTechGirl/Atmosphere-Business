import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class NetworkVideoPlayer extends StatefulWidget {
  const NetworkVideoPlayer({required this.videoUrl, super.key});

  final String videoUrl;

  @override
  _NetworkVideoPlayerState createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    // Configure Better Player
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        'https://example.com/your_video.mp4', // Replace with your video URL

        // Optional configuration
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
            // bufferForPlaybackMs: ,
            // bufferedTimeColor: Colors.green,
            ));

    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        // Customize player configuration
        aspectRatio: 16 / 9,
        fit: BoxFit.contain,
        autoPlay: true,
        looping: false,

        // Error handling
        handleLifecycle: true,

        // Playback controls
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControlsOnInitialize: true,
          // playbackSpeedButtonVisible: true,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BetterPlayerControllerProvider(
        controller: _betterPlayerController,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
              // 'https://api-dev.wave5wireless.ng/content/stream/b69c1a3b-a209-4516-8746-b5e6ec4e50de.mp4'
              widget.videoUrl),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }
}
