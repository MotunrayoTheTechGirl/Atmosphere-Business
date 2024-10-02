import 'package:flutter/material.dart';

import '../../../my_plans/presentation/widgets/plan_bottom_sheet.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    return Scaffold(
      key: const Key('value'),
      appBar: AppBar(
        title: const Text('Testing Screen'),
      ),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () async {
              planBottomSheet(
                parentContext: context,
                key: const Key('value'),
              );
              // assignToCustomerBottomSheet(context: context);
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
