import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class SizeGuideTextButton extends StatelessWidget {
  const SizeGuideTextButton({
    required this.onTap,
    super.key,
  });
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Check out our recommended video sizes and guidelines ',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: AppColors.greyShade200,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            'here',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.w5Color,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
