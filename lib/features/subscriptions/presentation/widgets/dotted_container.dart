import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DottedContainer extends StatelessWidget {
  const DottedContainer({
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
      child: DottedBorder(
        strokeWidth: 1,
        color: AppColors.lightBlue.withOpacity(0.3),
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: AppColors.lilac,
          ),
          child: Column(
            children: [
              Image.asset(
                AppIcons.upload,
                fit: BoxFit.scaleDown,
                height: 70.h,
                width: 80.w,
              ),
              20.hi,
              Text(
                label,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackShade400,
                ),
              ),
              10.hi,
              Text(
                'Supported formates: JPEG, PNG, GIF, MP4, PDF, PSD, AI, Word, PPT',
                style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400, color: AppColors.blackShade50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
