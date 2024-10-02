import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/features/onboarding/presentation/widgets/welcome_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              // top: 220,

              top: 300,
              left: 100,
              child: Image.asset(
                AppIcons.appLogo,
                fit: BoxFit.scaleDown,
                height: 64.h,
              ),
            ),
            const Positioned(
              bottom: 0,
              child: WelcomeBottomSheet(),
            ),
          ],
        ),
      ),
    );
  }
}
