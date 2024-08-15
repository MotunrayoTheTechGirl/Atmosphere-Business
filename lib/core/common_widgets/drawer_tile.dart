import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    required this.onTap,
    required this.icon,
    required this.label,
    super.key,
  });
  final void Function()? onTap;
  final String icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          16.wi,
          Text(
            label,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.blackSupplementary,
            ),
          )
        ],
      ),
    );
  }
}
