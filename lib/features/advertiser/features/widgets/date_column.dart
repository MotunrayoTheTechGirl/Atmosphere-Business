import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DateColumn extends StatelessWidget {
  const DateColumn({
    required this.dateType,
    required this.date,
    super.key,
  });

  final String dateType, date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateType,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackText.withOpacity(0.4),
          ),
        ),
        6.hi,
        Text(
          date,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.blackSupplementary,
          ),
        ),
      ],
    );
  }
}
