import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/themes/app_themes.dart';

class GenerateInitials extends StatelessWidget {
  final String tag;
  final double? width;
  final double? height;
  final Color? color;

  const GenerateInitials({
    super.key,
    required this.tag,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 70.w,
      height: height ?? 70.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black.withOpacity(0.2),
      ),
      child: Center(
        child: Text(
          tag.getInitials(),
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontFamily: AppTheme.dmSans,
              fontSize: 30.sp),
        ),
      ),
    );
  }
}
