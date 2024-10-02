import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    required this.label,
    required this.onTap,
    super.key,
  });
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  fontSize: 12.sp,
                ),
              ),
              14.wi,
              SvgPicture.asset(
                AppIcons.angleArrow,
                color: AppColors.white,
                height: 13.h,
                width: 13.w,
              ),
            ],
          )),
    );
  }
}
