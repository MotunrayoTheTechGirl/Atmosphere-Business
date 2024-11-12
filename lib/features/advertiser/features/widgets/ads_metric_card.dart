// ignore_for_file: must_be_immutable

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class AdsMetricCard extends StatelessWidget {
  AdsMetricCard({
    required this.label,
    required this.points,
    required this.percent,
    this.isPositive = true,
    this.bgColor,
    super.key,
  });

  final String label, points, percent;
  bool isPositive;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196.w,
      padding: EdgeInsets.symmetric(horizontal: 10.7.w, vertical: 10.7.h),
      // padding: EdgeInsets.all(21.55.h),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.white,
        border: Border.all(width: 0.9, color: AppColors.lightPurple),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                color: AppColors.blackText,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                fontFamily: AppTheme.montserratAlternate),
          ),
          7.18.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                points,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.blackText,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    fontFamily: AppTheme.montserratAlternate),
              ),
              Row(
                children: [
                  Text(
                    percent,
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        color: AppColors.blackText,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        fontFamily: AppTheme.montserratAlternate),
                  ),
                  2.wi,
                  SvgPicture.asset(
                      isPositive ? AppIcons.arrowRise : AppIcons.arrowFall),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
