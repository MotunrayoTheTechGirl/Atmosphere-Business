import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lightBorder,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subscriptions',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.deepBrown,
                fontSize: 16.sp),
          ),
          10.hi,
          RichText(
            text: TextSpan(
              text: 'Last subscribed: ',
              style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  color: AppColors.greyText.withOpacity(0.8), fontSize: 12.sp),
              children: [
                TextSpan(
                  text: formatDate('2024-10-22T09:44:20.224Z'),
                  style: AppTheme.lightTextTheme.bodySmall
                      ?.copyWith(color: AppColors.deepBrown, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          10.hi,
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              color: AppColors.deepAsh,
            ),
          ),
          16.hi,
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(
                top: 15.1,
                bottom: 15.1,
                left: 50,
                right: 50,
              ),
              decoration: const BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.all(
                  Radius.circular(28.7),
                ),
              ),
              child: Text(
                'Check subscribed products',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.w5Color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
