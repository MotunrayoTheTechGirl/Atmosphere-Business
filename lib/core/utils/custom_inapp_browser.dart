import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/app/presentation/screen/app.dart';
import '../../features/onboarding/data/controller/get_query_param.dart';
import '../../features/wallet/data/controller/verify_and_update_wallet_controller.dart';
import '../../features/wallet/logic/wallet_countdown_controller.dart';
import '../../features/wallet/presentation/screens/fund_wallet_screen.dart';
import '../../features/wallet/presentation/screens/wallet_screen.dart';

class CustomInAppBrowser extends ConsumerStatefulWidget {
  final String url;
  final bool? isFunding;

  const CustomInAppBrowser({
    Key? key,
    required this.url,
    this.isFunding,
  }) : super(key: key);

  @override
  ConsumerState<CustomInAppBrowser> createState() => _CustomInAppBrowserState();
}

class _CustomInAppBrowserState extends ConsumerState<CustomInAppBrowser> {
  final GlobalKey webViewKey = GlobalKey();

  String url = '';
  String title = '';
  double progress = 0;
  bool? isSecure;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isFunding == true) {
        ref.read(walletPaystackCountdownProvider.notifier).startTimer();
      }
    });
    url = widget.url;
  }

  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
    ref.read(walletPaystackCountdownProvider.notifier).stopTimer();
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
                    style: AppTheme.lightTextTheme.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                    ),
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
                          fontSize: 14.sp,
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
                        // if (url.toString().contains('atmosphere.net')) {

                        //   ref
                        //       .read(verifyAndUpdateWalletControllerProvider
                        //           .notifier)
                        //       .verifyPaymentAndUpdateWallet(
                        //           amount: ref.watch(amountStateProvider),
                        //           reference: ref
                        //               .watch(generatedReferenceStateProvider),
                        //           userId: ref.watch(userIdStateProvider));

                        //   Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const WalletScreen()),
                        //     (Route<dynamic> route) => false,
                        //   );
                        // }
                      }
                    },
                    onLoadStop: (controller, url) async {
                      if (url != null) {
                        setState(() {
                          this.url = url.toString();
                        });
                      }
                      if (Platform.isIOS) {
                        if (url.toString().contains('atmosphere.net')) {
                          ref
                              .read(verifyAndUpdateWalletControllerProvider
                                  .notifier)
                              .verifyPaymentAndUpdateWallet(
                                  amount: ref.watch(amountStateProvider),
                                  reference: ref
                                      .watch(generatedReferenceStateProvider),
                                  userId: ref.watch(userIdStateProvider));

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
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
                        if (url.toString().contains('token') &&
                            url.toString().contains('nonce')) {
                          log('in-app browser nav redirect: $url');
                          ref
                              .read(getQueryParamValueController.notifier)
                              .getAuthDetails(url.toString());

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const App();
                              },
                            ),
                          );
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
