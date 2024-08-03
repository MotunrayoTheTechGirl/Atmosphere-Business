import 'dart:developer';

import 'package:dealer_portal_mobile/core/api/api_endpoints.dart';
import 'package:dealer_portal_mobile/core/api/dealer_portal_api.dart';
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
              final api = DealerPoratlApi();
              final testing = await api.get(ApiEndpoints.testEndPoint);
              log("Data: ${testing?.data}");
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
