import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/portfolio_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../widgets/add_account_alert_dialog.dart';
import '../widgets/custom_popup_menu_item.dart';

class PortfolioAccountScreen extends StatefulWidget {
  const PortfolioAccountScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioAccountScreen> createState() => _PortfolioAccountScreenState();
}

class _PortfolioAccountScreenState extends State<PortfolioAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Portfolio Account',
        backgroundColor: AppColors.white,
        icon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.leftArrow,
            width: 16.w,
            height: 8.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hi,
            Text(
              'Pick an account',
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.blackText,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp),
            ),
            4.hi,
            Text(
              'to continue Advertise',
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.blackText.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp),
            ),
            12.hi,
            SizedBox(
              height: 350.h,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: PortfolioTile(
                        businessName: 'Business AD 1',
                        email: 'portfolio1@businessmail.com',
                        isActive: false,
                        onTap: () {},
                        menuOnTap: () {
                          List<String> options = [
                            'Remove',
                            'Sign out',
                          ];
                          showMenu(
                              context: context,
                              elevation: 0,
                              color: Colors.transparent,
                              position: RelativeRect.fromLTRB(
                                  100.w, 200.h, 0.w, 100.h),
                              items: [
                                PopupMenuItem(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomPopMenuItem(
                                        onTap: () {
                                          // Perform the 'Remove' action
                                        },
                                        label: 'Remove',
                                      ),
                                      CustomPopMenuItem(
                                        onTap: () {
                                          // Perform the 'Remove' action
                                        },
                                        label: 'Sign out',
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     // Perform the 'Sign out' action
                                      //   },
                                      //   child: Container(
                                      //     width: 167.w,
                                      //     padding: EdgeInsets.symmetric(
                                      //         vertical: 12.h, horizontal: 16.w),
                                      //     decoration: BoxDecoration(
                                      //       color: AppColors.white,
                                      // borderRadius:
                                      //     const BorderRadius.vertical(
                                      //         bottom:
                                      //             Radius.circular(12)),
                                      //       boxShadow: [
                                      //         BoxShadow(
                                      //           color: Colors.grey
                                      //               .withOpacity(0.3),
                                      //           spreadRadius: 2,
                                      //           blurRadius: 6,
                                      //           offset: const Offset(0, 3),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     child: Center(
                                      //       child: Text(
                                      //         'Sign out',
                                      //         style: AppTheme
                                      //             .lightTextTheme.bodySmall
                                      //             ?.copyWith(
                                      //           fontSize: 12.sp,
                                      //           color: AppColors.blackText,
                                      //           fontWeight: FontWeight.w500,
                                      //           fontFamily: AppTheme
                                      //               .montserratAlternate,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ]);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return AppDivider(
                      color: AppColors.black.withOpacity(0.4),
                      thickness: 0.5,
                    );
                  },
                  itemCount: 3),
            ),
            AppDivider(
              color: AppColors.black.withOpacity(0.4),
              thickness: 0.5,
            ),
            26.hi,
            GestureDetector(
              onTap: () {
                addAccountAlertDialog(context: context);
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.greyShade100),
                    child: SvgPicture.asset(AppIcons.plusSign),
                  ),
                  8.wi,
                  Text(
                    'Add another portfolio account',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        color: AppColors.blackShade800,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ).padHorizontal(24),
      ),
    );
  }
}
