import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key, required this.title, required this.icon});

  final String title, icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100.0.h,
      centerTitle: false,
      title: Text(
        title,
        style: AppTheme.lightTextTheme.titleLarge?.copyWith(
          fontSize: 26.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
          fontFamily: AppTheme.montserratAlternate,
        ),
      ),
      actions: [
        SvgPicture.asset(icon).padOnly(right: 20),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 80.0);
}
