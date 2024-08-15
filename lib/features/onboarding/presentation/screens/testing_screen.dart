import 'package:dealer_portal_mobile/core/constants/app_constants.dart';
import 'package:dealer_portal_mobile/core/utils/custom_inapp_browser.dart';
import 'package:flutter/material.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Screen'),
      ),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CustomInAppBrowser(url: AppConstants.authurl);
                  },
                ),
              );
            },
            child: const Text(
              'Click Me!',
            ),
          ),
        ),
      ),
    );
  }
}
