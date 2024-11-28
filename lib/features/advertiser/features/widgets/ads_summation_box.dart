import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class AdsSummationBox extends StatelessWidget {
  AdsSummationBox({
    required this.totalAds,
    required this.imageAds,
    required this.videoAds,
    required this.survey,
    super.key,
  });
  String totalAds;
  String imageAds;
  String videoAds;
  String survey;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.greyShade300),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Total Ads',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.greyShade200,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
              Text(
                totalAds,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
            child: const VerticalDivider(
              thickness: 1,
              color: AppColors.greyShade300,
            ),
          ),
          Column(
            children: [
              Text(
                'Video Ads',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.greyShade200,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
              Text(
                videoAds,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
            child: const VerticalDivider(
              thickness: 1,
              color: AppColors.greyShade300,
            ),
          ),
          Column(
            children: [
              Text(
                'Image Ads',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.greyShade200,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
              Text(
                imageAds,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(
            height: 60.h,
            child: const VerticalDivider(
              thickness: 1,
              color: AppColors.greyShade300,
            ),
          ),
          Column(
            children: [
              Text(
                'Surveys',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.greyShade200,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp),
              ),
              Text(
                survey,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.brown900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
