import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/themes/app_themes.dart';

class CustomPopMenuItem extends StatelessWidget {
  CustomPopMenuItem({
    required this.label,
    this.onTap,
    this.borderRadius,
    super.key,
  });

  final void Function()? onTap;
  final String label;
  BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 167.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: borderRadius ??
              const BorderRadius.vertical(
                  top: Radius.circular(12), bottom: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
              fontSize: 12.sp,
              color: AppColors.blackText,
              fontWeight: FontWeight.w500,
              fontFamily: AppTheme.montserratAlternate,
            ),
          ),
        ),
      ),
    );
  }
}
