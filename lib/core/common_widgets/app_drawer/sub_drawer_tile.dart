import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/themes/app_themes.dart';

class SubDrawerTile extends StatelessWidget {
  const SubDrawerTile({
    required this.onTap,
    required this.label,
    super.key,
  });

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.greyShade100,
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.bulletPoint),
            8.wi,
            Text(
              label,
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                color: AppColors.blackSupplementary,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
