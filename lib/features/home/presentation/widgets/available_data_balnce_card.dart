import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/linear_progess_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class AvailableDataBalanceCard extends StatelessWidget {
  const AvailableDataBalanceCard({
    this.width,
    super.key,
  });
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 284.w,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(width: 1.2, color: AppColors.lightBorder),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Available data balance',
            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
              color: AppColors.blackText,
            ),
          ),
          14.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '30.6',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  6.hi,
                  Text(
                    'Terabytes',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
                child: const VerticalDivider(
                  thickness: 1,
                  color: AppColors.lightBorder,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '996,748',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  6.hi,
                  Text(
                    'Wi-Fi Hours',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          16.hi,
          LinearProgressBar(
            color: AppColors.green,
            max: 6,
            height: 14.h,
            trackColor: AppColors.green.withOpacity(0.1),
            current: 3,
          ),
        ],
      ),
    );
  }
}
