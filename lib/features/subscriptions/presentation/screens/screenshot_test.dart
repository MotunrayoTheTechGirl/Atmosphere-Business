import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotTest extends StatefulWidget {
  const ScreenShotTest({
    Key? key,
  }) : super(key: key);

  @override
  _ScreenShotTestState createState() => _ScreenShotTestState();
}

class _ScreenShotTestState extends State<ScreenShotTest> {
  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 5.0),
                    color: Colors.amberAccent,
                  ),
                  child: const Stack(
                    children: [
                      Icon(Icons.public_sharp),
                      Text("This widget will be captured as an image"),
                    ],
                  )),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: const Text(
                'Capture Above Widget',
              ),
              onPressed: () {
                screenshotController
                    .capture(delay: const Duration(milliseconds: 10))
                    .then((capturedImage) async {
                  ShowCapturedWidget(context, capturedImage!);
                }).catchError((onError) {
                  print(onError);
                });
              },
            ),
            ElevatedButton(
              child: const Text(
                'Capture An Invisible Widget',
              ),
              onPressed: () {
                var container = Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 5.0),
                      color: Colors.redAccent,
                    ),
                    child: Stack(
                      children: [
                        const Icon(Icons.place_outlined),
                        Text(
                          "This is an invisible widget",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ));
                screenshotController
                    .captureFromWidget(
                        InheritedTheme.captureAll(
                            context, Material(child: container)),
                        delay: const Duration(seconds: 1))
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
            ElevatedButton(
              child: const Text(
                'Capture A dynamic Sized Widget',
              ),
              onPressed: () {
                var randomItemCount = Random().nextInt(100);
                var container = Builder(builder: (context) {
                  return Container(
                      // width: size2.width,
                      padding: const EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.blueAccent, width: 5.0),
                        color: Colors.redAccent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < randomItemCount; i++)
                            Text("Tile Index $i"),
                        ],
                      ));
                });
                screenshotController
                    .captureFromLongWidget(
                  InheritedTheme.captureAll(
                      context, Material(child: container)),
                  delay: const Duration(milliseconds: 100),
                  context: context,
                )
                    .then((capturedImage) {
                  ShowCapturedWidget(context, capturedImage);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          final image = Image.memory(capturedImage);
          final a = base64Encode(capturedImage);
          print('cherck: $a');
          print('capturedWidget: $capturedImage');
          return Scaffold(
            appBar: AppBar(
              title: const Text("Captured widget screenshot"),
            ),
            body: Center(
                child: Column(
              children: [
                Image.memory(capturedImage),
              ],
            )),
          );
        });
  }

  // _saved(File image) async {
  //   // final result = await ImageGallerySaver.save(image.readAsBytesSync());
  //   print("File Saved to Gallery");
  // }
}
