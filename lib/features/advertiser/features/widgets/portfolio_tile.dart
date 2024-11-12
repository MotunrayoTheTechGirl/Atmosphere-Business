// ignore_for_file: must_be_immutable

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class PortfolioTile extends StatelessWidget {
  PortfolioTile({
    required this.businessName,
    required this.email,
    required this.onTap,
    required this.menuOnTap,
    this.isActive = true,
    super.key,
  });

  final String businessName, email;
  final void Function()? onTap, menuOnTap;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(left: 0.w, right: 18.w, top: 16.h, bottom: 16.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.lightPurple : AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  businessName,
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.blackSupplementary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
                4.hi,
                Text(
                  email,
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.blackSupplementary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
                4.hi,
                Text(
                  'Signed in',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.blackSupplementary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
              ],
            ),
            InkWell(
              onTap: menuOnTap,
              child: SvgPicture.asset(
                AppIcons.dotMenu,
                color: AppColors.navyBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
