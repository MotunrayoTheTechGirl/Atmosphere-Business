import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.suffixIcon,
    this.suffix,
    this.icon,
    this.centerTitle = false,
    this.backgroundColor,
  });

  final String title;
  final String? suffixIcon;
  final Widget? suffix, icon;
  final bool? centerTitle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      toolbarHeight: 100.0.h,
      backgroundColor: backgroundColor ?? AppColors.appbarColor,
      leading: Padding(
        padding: const EdgeInsets.only(top: 38.0),
        child: icon ??
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 38.0),
        child: Text(
          title,
          style: AppTheme.lightTextTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.activeText,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 38.0, right: 18),
          child: suffix ??
              SvgPicture.asset(
                suffixIcon ?? '',
                fit: BoxFit.scaleDown,
              ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 85.0);
}
