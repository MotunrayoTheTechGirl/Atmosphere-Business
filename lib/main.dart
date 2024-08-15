import 'package:dealer_portal_mobile/core/api/dealer_portal_api.dart';
import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:dealer_portal_mobile/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/themes/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DealerPoratlApi.initialize(Environment.dev);
  runApp(const DealerPortal());
}

class DealerPortal extends StatelessWidget {
  const DealerPortal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme();
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) => MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}
