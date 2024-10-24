// ignore_for_file: library_private_types_in_public_api

import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/themes/app_themes.dart';

class DrawerTileDropDown extends StatefulWidget {
  const DrawerTileDropDown({
    required this.icon,
    required this.label,
    required this.subDrawer,
    Key? key,
  }) : super(key: key);

  final String icon, label;
  final Widget subDrawer;

  @override
  _DrawerTileDropDownState createState() => _DrawerTileDropDownState();
}

class _DrawerTileDropDownState extends State<DrawerTileDropDown> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Container(
            padding: isOpen ? const EdgeInsets.all(16) : EdgeInsets.zero,
            decoration: BoxDecoration(
                color: isOpen
                    ? AppColors.w5Color.withOpacity(0.1)
                    : Colors.transparent,
                border: Border(
                    right: isOpen
                        ? const BorderSide(
                            color: AppColors.w5Color,
                            width: 5.0,
                          )
                        : BorderSide.none)),
            child: Row(
              children: [
                SvgPicture.asset(widget.icon),
                16.wi,
                Text(
                  widget.label,
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.blackSupplementary,
                    fontSize: 14.sp,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                        isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp)
                    .padRight(20)
              ],
            ),
          ),
        ),
        8.hi,
        if (isOpen) widget.subDrawer
      ],
    ).padOnly(left: isOpen ? 0 : 18, right: 18);
  }
}
