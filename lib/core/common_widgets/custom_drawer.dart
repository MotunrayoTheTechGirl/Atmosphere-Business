import 'package:dealer_portal_mobile/core/common_widgets/drawer_tile.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/home/presentation/screens/dealer/dealer_mgt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/onboarding/data/controller/user_details_controller.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    return Drawer(
      width: .7.sw,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: SizedBox(
        height: 500,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                // horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppIcons.avatar,
                    fit: BoxFit.scaleDown,
                    height: 80.h,
                    width: 80.w,
                  ),
                  4.hi,
                  Text(
                    '${userDetailsController.data?.data?.user?.firstName ?? ''} ${userDetailsController.data?.data?.user?.lastName}',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppTheme.montserratAlternate),
                  ),
                  1.hi,
                  Text(
                    userDetailsController.data?.data?.user?.email ?? '',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        color: AppColors.blackText.withOpacity(0.8),
                        fontFamily: AppTheme.montserratAlternate),
                  ),
                ],
              ),
            ),
            10.hi,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MENU',
                  style: AppTheme.lightTextTheme.bodySmall
                      ?.copyWith(color: AppColors.blackText.withOpacity(0.8)),
                ),
                22.hi,
                DrawerTile(
                  onTap: () {},
                  label: 'Profile',
                  icon: AppIcons.profile,
                ),
                40.hi,
                DrawerTile(
                  onTap: () {},
                  label: 'Orders',
                  icon: AppIcons.orders,
                ),
                40.hi,
                DrawerTile(
                  onTap: () {},
                  label: 'Wallet',
                  icon: AppIcons.wallet,
                ),
                40.hi,
                DrawerTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DealerMgtScreen();
                      }),
                    );
                  },
                  label: 'Dealer Management',
                  icon: AppIcons.dealerMgt,
                ),
                90.hi,
                DrawerTile(
                  onTap: () {},
                  label: 'Help & Support',
                  icon: AppIcons.help,
                ),
                40.hi,
                DrawerTile(
                  onTap: () {},
                  label: 'Logout',
                  icon: AppIcons.logOut,
                ),
                10.hi,
              ],
            ).padHorizontal(13)
          ],
        ),
      ),
    );
  }
}
