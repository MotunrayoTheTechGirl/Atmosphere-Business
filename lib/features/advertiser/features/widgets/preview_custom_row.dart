import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class PreviewCustomRow extends StatelessWidget {
  const PreviewCustomRow({
    required this.prefix,
    required this.suffix,
    super.key,
  });
  final String prefix, suffix;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          prefix,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackText.withOpacity(0.5),
          ),
        ),
        9.wi,
        Text(
          suffix,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.blackText,
              fontFamily: AppTheme.montserratAlternate),
        ),
      ],
    );
  }
}
