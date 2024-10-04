// ignore_for_file: library_private_types_in_public_api, unrelated_type_equality_checks

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';

class WalletBalanceCard extends ConsumerStatefulWidget {
  const WalletBalanceCard({Key? key}) : super(key: key);

  @override
  _WalletBalanceCardState createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends ConsumerState<WalletBalanceCard> {
  bool isVisibiltyOn = true;

  @override
  Widget build(BuildContext context) {
    final dealerBalanceController =
        ref.watch(fetchUserBalanceControllerProvider);

    return Container(
        height: 250.h,
        width: 388.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppIcons.walletCard),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.white),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            dealerBalanceController.when(data: (data) {
                              final balance = data.balance;
                              // final emptyBalance = data.balance;
                              return Text(
                                isVisibiltyOn
                                    ? balance ==
                                            "user account doesn't already exist"
                                        ? formatNaira("0")
                                        : formatNaira(
                                            balance?.totalBalance ?? '0')
                                    : '********',
                                style: AppTheme.lightTextTheme.displayMedium
                                    ?.copyWith(
                                        fontSize: 20.sp,
                                        color: AppColors.white),
                              );
                              // Text(
                              //   isVisibiltyOn
                              //       ? dealerBalanceController?.balance
                              //                   ?.isDealerWalletBalance ==
                              //               null
                              //           ? formatNaira("0")
                              //           : formatNaira(
                              //               '${dealerBalanceController?.balance?.isDealerWalletBalance}')
                              //       : '********',
                              //   style: AppTheme.lightTextTheme.displayMedium
                              //       ?.copyWith(
                              //           fontSize: 20.sp,
                              //           color: AppColors.white),
                              // );
                            }, error: (error, str) {
                              log('balance error: $error');
                              return const Text('');
                            }, loading: () {
                              return const SpinKitChasingDots(
                                size: 20,
                                color: AppColors.white,
                              );
                            }),
                            10.wi,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisibiltyOn = !isVisibiltyOn;
                                });
                              },
                              child: SvgPicture.asset(
                                isVisibiltyOn
                                    ? AppIcons.visibiltyOn
                                    : AppIcons.visibiltyOff,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 44,
                left: 40,
                child: GestureDetector(
                  onTap: () async => await Clipboard.setData(
                    const ClipboardData(text: '5003553283'),
                  ).then(
                    (value) => CustomSnackBar.showSnackBar(
                        context: context,
                        message: 'Account number copied to clipboard'),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AppIcons.bank,
                            height: 26.h,
                            width: 26.h,
                          ),
                          10.wi,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wave 5 Wallet',
                                style:
                                    AppTheme.lightTextTheme.bodySmall?.copyWith(
                                  fontSize: 8.sp,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                '5003553283',
                                style:
                                    AppTheme.lightTextTheme.bodySmall?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      110.wi,
                      SizedBox(
                        height: 30.h,
                        child: VerticalDivider(
                          width: 4,
                          color: AppColors.black.withOpacity(0.5),
                        ),
                      ),
                      20.wi,
                      Text(
                        'Copy',
                        style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
