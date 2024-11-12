import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DottedBorderContainer extends StatelessWidget {
  const DottedBorderContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.w5Color,
      strokeWidth: 1.5,
      dashPattern: const [6, 3],
      borderType: BorderType.RRect,
      radius: Radius.circular(14.r),
      child: Container(
        padding: const EdgeInsets.all(36),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Upload a ',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextShade800,
              ),
              children: [
                TextSpan(
                  text: 'File\n',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.w5Color,
                  ),
                ),
                TextSpan(
                  text: 'Max image size is ',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTextShade800,
                  ),
                ),
                TextSpan(
                  text: '5MB',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.w5Color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
