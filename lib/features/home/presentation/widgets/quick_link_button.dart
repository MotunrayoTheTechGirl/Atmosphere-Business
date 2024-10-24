import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class QuickLinksButton extends StatelessWidget {
  const QuickLinksButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  final String icon, label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 156.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greyShade100.withOpacity(0.3),
          border: Border.all(
            width: 1,
            color: AppColors.lightBorder,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            20.wi,
            Text(
              label,
              style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepBrown,
                  fontSize: 12.sp),
            )
          ],
        ),
      ),
    );
  }
}
