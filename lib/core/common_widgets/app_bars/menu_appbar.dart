import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            Scaffold.of(context).openDrawer();
          },
          child: SvgPicture.asset(
            AppIcons.menu,
            fit: BoxFit.scaleDown,
          ),
        ).padOnly(left: 12);
      }),
      title: Text(
        title,
        style: AppTheme.lightTextTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.blackText,
        ),
      ),
      actions: [
        SvgPicture.asset(AppIcons.notification).padOnly(right: 20),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 40.0);
}
