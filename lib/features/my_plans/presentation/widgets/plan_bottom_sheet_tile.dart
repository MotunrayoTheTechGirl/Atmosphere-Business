import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';

class PlanBottomSheetTile extends StatelessWidget {
  const PlanBottomSheetTile({
    this.onTap,
    this.iconColor,
    this.labelColor,
    required this.icon,
    required this.label,
    super.key,
  });
  final String label, icon;
  final Color? iconColor, labelColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.lightAsh,
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: iconColor,
            ),
            16.wi,
            Text(
              label,
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: labelColor ?? AppColors.greyText,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
