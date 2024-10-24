import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class InvoiceSummary extends StatelessWidget {
  const InvoiceSummary({
    required this.leading,
    required this.trailing,
    super.key,
  });
  final String leading, trailing;
  @override
  Widget build(BuildContext context) {
    return RichText(
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: leading,
        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.deepAsh,
        ),
        children: [
          TextSpan(
            text: trailing,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.deepBrown,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
