import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomInAppBrowser extends StatefulWidget {
  final String url;

  const CustomInAppBrowser({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<CustomInAppBrowser> createState() => _CustomInAppBrowserState();
}

class _CustomInAppBrowserState extends State<CustomInAppBrowser> {
  final GlobalKey webViewKey = GlobalKey();

  String url = '';
  String title = '';
  double progress = 0;
  bool? isSecure;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: [
          IconButton(
            onPressed: () => webViewController?.reload(),
            icon: const Icon(
              Icons.replay_outlined,
            ),
          )
        ],
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.lightTextTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      isSecure != null
                          ? Icon(
                              isSecure == true ? Icons.lock : Icons.lock_open,
                              color:
                                  isSecure == true ? Colors.green : Colors.red,
                              size: 12)
                          : Container(),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: Text(
                        url,
                        style: AppTheme.lightTextTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.fade,
                      )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(children: <Widget>[
        Consumer(
          builder: (context, ref, child) {
            return Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                    initialSettings: InAppWebViewSettings(
                      transparentBackground: true,
                      safeBrowsingEnabled: true,
                      isFraudulentWebsiteWarningEnabled: true,
                    ),
                    onWebViewCreated: (controller) async {
                      webViewController = controller;
                      if (!kIsWeb &&
                          defaultTargetPlatform == TargetPlatform.android) {
                        await controller.startSafeBrowsing();
                      }
                    },
                    onReceivedHttpAuthRequest:
                        (InAppWebViewController controller,
                            URLAuthenticationChallenge challenge) async {
                      return null;
                    },
                    onLoadStart: (controller, url) async {
                      if (url != null) {
                        setState(() {
                          this.url = url.toString();
                          isSecure = urlIsSecure(url);
                        });
                      }
                    },
                    onLoadStop: (controller, url) async {
                      if (url != null) {
                        setState(() {
                          this.url = url.toString();
                        });
                      }
                      final sslCertificate = await controller.getCertificate();
                      setState(() {
                        isSecure = sslCertificate != null ||
                            (url != null && urlIsSecure(url));
                      });
                    },
                    onUpdateVisitedHistory: (controller, url, isReload) {
                      if (url != null) {
                        setState(() {
                          this.url = url.toString();
                        });
                        if (url.toString().contains('token')) {
                          log('in-app browser nav redirect: $url');

                          Navigator.pop(context);
                        }
                      }
                    },
                    onTitleChanged: (controller, title) {
                      if (title != null) {
                        setState(() {
                          this.title = title;
                        });
                      }
                    },
                    onProgressChanged: (controller, progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      final url = navigationAction.request.url;
                      if (navigationAction.isForMainFrame &&
                          url != null &&
                          ![
                            'http',
                            'https',
                            'file',
                            'chrome',
                            'data',
                            'javascript',
                            'about'
                          ].contains(url.scheme)) {
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                          return NavigationActionPolicy.CANCEL;
                        }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                  ),
                  // if (widget.isCaptive) ...[
                  //   Container(
                  //     alignment: Alignment.center,
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: AppConstants.kPadding,
                  //     ),
                  //     color: AppColors.whiteColor,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       mainAxisSize: MainAxisSize.max,
                  //       children: [
                  //         Lottie.asset(
                  //           'wifi'.json,
                  //         ),
                  //         Text(
                  //           'Connecting to WiFi...',
                  //           style: context.bodyLarge,
                  //         ),
                  //       ],
                  //     ),
                  //   )
                  // ],
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
            );
          },
        )
      ]),
    );
  }

  void handleClick(int item) async {
    switch (item) {
      case 0:
        await InAppBrowser.openWithSystemBrowser(url: WebUri(url));
        break;
      case 1:
        // ignore: deprecated_member_use
        await webViewController?.clearCache();
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
          await webViewController?.clearHistory();
        }
        setState(() {});
        break;
    }
  }

  static bool urlIsSecure(Uri url) {
    return (url.scheme == "https") || isLocalizedContent(url);
  }

  static bool isLocalizedContent(Uri url) {
    return (url.scheme == "file" ||
        url.scheme == "chrome" ||
        url.scheme == "data" ||
        url.scheme == "javascript" ||
        url.scheme == "about");
  }
}
