import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../advertiser/features/screens/feat_tests/new_video_test.dart';

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
            // const AppVideoPlayer(
            //   videoUrl:
            //       'https://api-dev.wave5wireless.ng/content/getImage/adverts/b6b13ae8-f17e-428e-b2e0-892e5b9a3513.mp4',
            //   // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            // ),

            const NetworkVideoPlayer(
              videoUrl:
                  'https://api-dev.wave5wireless.ng/content/stream/b69c1a3b-a209-4516-8746-b5e6ec4e50de.mp4',
            ),
          ],
        ),
      ),
    );
  }
}
