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
    this.padding,
    this.color,
    this.iconColor,
    this.labelColor,
    this.leftPadding,
    this.rightPadding,
    Key? key,
  }) : super(key: key);

  final String icon, label;
  final Widget subDrawer;
  final Color? color, iconColor, labelColor;
  final EdgeInsetsGeometry? padding;
  final double? leftPadding, rightPadding;

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
            padding: isOpen
                ? const EdgeInsets.all(16)
                : widget.padding ?? EdgeInsets.zero,
            decoration: BoxDecoration(
                color: isOpen
                    ? widget.color ?? AppColors.w5Color.withOpacity(0.1)
                    : widget.color ?? Colors.transparent,
                border: Border(
                    right: isOpen
                        ? const BorderSide(
                            color: AppColors.w5Color,
                            width: 5.0,
                          )
                        : BorderSide.none)),
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  color: widget.iconColor,
                ),
                16.wi,
                SizedBox(
                  width: 149.w,
                  child: Text(
                    widget.label,
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      color: widget.labelColor ?? AppColors.blackSupplementary,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  isOpen ? AppIcons.arrowDown : AppIcons.curveArrowUp,
                  color: widget.iconColor,
                ).padRight(20)
              ],
            ),
          ),
        ),
        8.hi,
        if (isOpen) widget.subDrawer
      ],
    ).padOnly(
        left: isOpen ? 0 : widget.leftPadding ?? 18,
        right: widget.rightPadding ?? 18);
  }
}
