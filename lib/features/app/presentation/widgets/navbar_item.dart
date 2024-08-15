import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    required this.onTap,
    required this.icon,
    required this.label,
    this.isActive = false,
    this.isPng = false,
    super.key,
  });
  final void Function()? onTap;
  final String icon;
  final String label;
  final bool isActive;
  final bool isPng;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: isPng
                ? EdgeInsets.only(top: 5, bottom: 5, left: 20.w, right: 20.w)
                : EdgeInsets.only(
                    top: 5.h, bottom: 5.h, left: 20.w, right: 20.w),
            decoration: isActive
                ? BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  )
                : const BoxDecoration(),
            child: isPng
                ? Image(
                    image: AssetImage(
                      icon,
                    ),
                    height: 24.h,
                    width: 24.w,
                    // fit: BoxFit.scaleDown,
                  )
                : SvgPicture.asset(
                    icon,
                  ),
          ),
          4.hi,
          Text(
            label,
            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                fontSize: 10.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? AppColors.activeText
                    : AppColors.navbarInactiveText),
          )
        ],
      ),
    );
  }
}
