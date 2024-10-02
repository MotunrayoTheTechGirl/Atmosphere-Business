// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../onboarding/data/controller/user_details_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    final phoneNumber =
        userDetailsController.data?.data?.user?.phoneNumber ?? '';
    final trimmedPhoneNumber = phoneNumber.substring(4);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Profile',
        suffixIcon: AppIcons.notification,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.avatar,
                  fit: BoxFit.scaleDown,
                  height: 80.h,
                  width: 80.w,
                ),
                10.hi,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${userDetailsController.data?.data?.user?.name ?? ''}',
                          style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTheme.montserratAlternate),
                        ),
                        4.hi,
                        Text(
                          'ID: $trimmedPhoneNumber',
                          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.montserratAlternate),
                        ),
                      ],
                    ),
                    10.wi,
                    SvgPicture.asset(AppIcons.editIcon),
                  ],
                ),
              ],
            ),
            40.hi,
            Text(
              'REPRESENTATIVE DETAILS',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400, color: AppColors.textColor),
            ),
            8.hi,
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
