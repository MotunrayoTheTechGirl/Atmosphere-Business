import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_video_player.dart';

class DownloadTestScreen extends StatelessWidget {
  const DownloadTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video Player')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Video Player '),
            20.hi,
            const AppVideoPlayer(
              videoUrl:
                  'https://api-dev.wave5wireless.ng/content/getImage/adverts/b6b13ae8-f17e-428e-b2e0-892e5b9a3513.mp4',
              // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
            // TextButton(
            //   child: const Text('Test Video player'),
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
            //       return const VideoApp();
            //     }));
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
