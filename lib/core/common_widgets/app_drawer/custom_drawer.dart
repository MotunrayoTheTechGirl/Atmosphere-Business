// ignore_for_file: library_private_types_in_public_api

import 'package:dealer_portal_mobile/core/common_widgets/app_drawer/drawer_tile.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_drawer/drawer_tile_dropdown.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_generate_initials.dart';
import 'package:dealer_portal_mobile/core/common_widgets/cancel_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:dealer_portal_mobile/features/transaction_history.dart/features/screen/transaction_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/onboarding/data/controller/user_details_controller.dart';
import '../../../features/wallet/presentation/screens/wallet_screen.dart';
import '../../constants/app_constants.dart';
import '../../storage/storage_service.dart';
import 'sub_drawer_tile.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  void logOut() {
    final secureStorageService = StorageService(
      secureStorage: const FlutterSecureStorage(),
    );
    secureStorageService.delete(key: AppConstants.token);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) {
        return const WelcomeScreen();
      }),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    return Drawer(
      width: .7.sw,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: SingleChildScrollView(
        // height: 500.h,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 280.h,
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: CancelButton(),
                      ),
                      6.hi,
                      GenerateInitials(
                        tag:
                            '${userDetailsController.data?.data?.user?.name ?? ''}',
                      ),
                      16.hi,
                      Text(
                        userDetailsController.data?.data?.user?.email ?? '',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            fontFamily: AppTheme.montserratAlternate),
                      ),
                      4.hi,
                      Text(
                        'GLO WORLD',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
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
                  ).padHorizontal(18),
                  22.hi,
                  SizedBox(
                    height: .5.sh,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                          label: 'Home',
                          icon: AppIcons.homeIcon,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Marketplace',
                          icon: AppIcons.marketPlace,
                        ),
                        27.hi,
                        DrawerTileDropDown(
                          icon: AppIcons.walletNew,
                          label: 'Wallet',
                          subDrawer: Column(
                            children: [
                              SubDrawerTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const WalletScreen();
                                  }));
                                },
                                label: "Overview",
                              ),
                              8.hi,
                              SubDrawerTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const TransactionHistoryScreen();
                                  }));
                                },
                                label: "Transaction History",
                              ),
                              8.hi,
                              SubDrawerTile(
                                onTap: () {},
                                label: "Invoice History",
                              ),
                            ],
                          ),
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Wifi Services',
                          icon: AppIcons.wifiService,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Advertise',
                          icon: AppIcons.advertise,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Storefront',
                          icon: AppIcons.storefront,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Subscriptions',
                          icon: AppIcons.subscription,
                        ),
                        27.hi,
                        DrawerTileDropDown(
                          icon: AppIcons.vending,
                          label: 'Vending',
                          subDrawer: Column(
                            children: [
                              SubDrawerTile(
                                onTap: () {
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return const WalletScreen();
                                  // }));
                                },
                                label: "Overview",
                              ),
                              8.hi,
                              SubDrawerTile(
                                onTap: () {},
                                label: "Data Plan",
                              ),
                              8.hi,
                              SubDrawerTile(
                                onTap: () {},
                                label: "Developer",
                              ),
                            ],
                          ),
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Reports',
                          icon: AppIcons.report,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Service Management',
                          icon: AppIcons.serviceMgt,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Promotions',
                          icon: AppIcons.promotion,
                        ),
                        27.hi,
                        DrawerTile(
                          onTap: () {},
                          label: 'Business Info',
                          icon: AppIcons.businessInfo,
                        ),
                      ],
                    ),
                  ),

                  // DrawerTile(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const ProfileScreen();
                  //     }));
                  //   },
                  //   label: 'Profile',
                  //   icon: AppIcons.profile,
                  // ),
                  // 27.hi,
                  // DrawerTile(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return const TransactionHistoryScreen();
                  //     }));
                  //   },
                  //   label: 'Transaction History',
                  //   icon: AppIcons.orders,
                  // ),
                  // 27.hi,
                  // DrawerTile(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) {
                  //         return DealerMgtScreen();
                  //       }),
                  //     );
                  //   },
                  //   label: 'Dealer Management',
                  //   icon: AppIcons.dealerMgt,
                  // ),
                  36.hi,
                  DrawerTile(
                    onTap: () {},
                    label: 'Help & Support',
                    icon: AppIcons.help,
                  ),
                  19.hi,
                  DrawerTile(
                    onTap: () {
                      logOut();
                    },
                    label: 'Logout',
                    icon: AppIcons.logOut,
                  ),
                  10.hi,
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
