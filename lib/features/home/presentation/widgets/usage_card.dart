import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class UsageCard extends StatelessWidget {
  const UsageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 284.w,
      height: 156.h,
      padding: const EdgeInsets.all(19.2),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Usage',
            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
