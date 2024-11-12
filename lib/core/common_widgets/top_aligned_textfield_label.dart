import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/themes/app_themes.dart';

class TopAlignedTextfieldLabel extends StatelessWidget {
  const TopAlignedTextfieldLabel({
    required this.label,
    this.isRequired = true,
    super.key,
  });
  final String label;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.deepAsh,
        ),
        children: [
          TextSpan(
            text: isRequired ? ' * ' : '',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
