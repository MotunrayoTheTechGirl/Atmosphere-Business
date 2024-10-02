import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/custom_inapp_browser.dart';

class WelcomeBottomSheet extends ConsumerWidget {
  const WelcomeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(
            color: AppColors.white,
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.hi,
          Center(
            child: SvgPicture.asset(AppIcons.dragHandle),
          ),
          24.hi,
          Text(
            'Welcome to',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.lighterText,
              fontWeight: FontWeight.w400,
            ),
          ),
          8.hi,
          Text(
            'Dealer by Atmosphere',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.textColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          50.hi,
          AppElevatedButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CustomInAppBrowser(
                      url: AppConstants.authurl,
                    );
                    // return const TestingScreen();
                  },
                ),
              );
            },
            label: 'Sign in to continue',
          ),
        ],
      ),
    );
  }
}
