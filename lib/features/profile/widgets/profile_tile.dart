import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/common_widgets/app_divider.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/themes/app_themes.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.label,
    required this.data,
    super.key,
  });
  final String label, data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor),
        ),
        16.hi,
        Text(
          data,
          style: AppTheme.lightTextTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              color: AppColors.greyText,
              fontWeight: FontWeight.w400),
        ),
        8.hi,
        const AppDivider(),
      ],
    );
  }
}
