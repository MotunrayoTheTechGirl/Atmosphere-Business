import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotCapture extends StatefulWidget {
  const ScreenshotCapture({super.key});

  @override
  _ScreenshotCaptureState createState() => _ScreenshotCaptureState();
}

class _ScreenshotCaptureState extends State<ScreenshotCapture> {
  final ScreenshotController _screenshotController = ScreenshotController();

  // Future<void> _captureScreenshot() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final imagePath =
  //       '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

  //   await _screenshotController.capture().then((image) async {
  //     final file = File(imagePath);
  //     // await image!.toFile(File(imagePath));
  //     await file.writeAsBytes(image!.cast<int>());
  //     print('Image path: $imagePath');
  //   }).catchError((onError) => print(onError));
  // }
  Future<void> _captureScreenshot() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
    log('...immm...: $imagePath');

    await _screenshotController.capture().then((image) async {
      log('...eemmm...: $image');
      final file = File(imagePath);

      await file.writeAsBytes(image!.cast<int>());
      print('Image path: $imagePath');
    }).catchError((onError) => print('image path error: $onError'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Capture'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text(
                      'Tap the button below to capture screenshot',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _captureScreenshot,
                child: const Text('Capture Screenshot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
