import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class UploadBoxText extends StatelessWidget {
  const UploadBoxText({
    this.isVideo = false,
    super.key,
  });
  final bool isVideo;
  @override
  Widget build(BuildContext context) {
    return RichText(
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
            text: isVideo ? 'Max video size is ' : 'Max image size is ',
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
    );
  }
}
