// ignore_for_file: library_private_types_in_public_api, unrelated_type_equality_checks

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../../my_plans/data/models/user_balance_res_model.dart';

class WalletBalanceCard extends ConsumerStatefulWidget {
  const WalletBalanceCard({Key? key}) : super(key: key);

  @override
  _WalletBalanceCardState createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends ConsumerState<WalletBalanceCard> {
  String getFormattedBalance(UserBalanceResModel data) {
    if (!data.hasBalance) {
      return formatNaira('0');
    }
    return formatNaira(data.balance?.totalBalance ?? '0');
  }

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
        child: Stack(
          children: [
            Positioned(
              top: 26,
              left: 90,
              right: 90,
              child: Image.asset(
                AppIcons.wave5Logo,
                height: 21.h,
              ),
            ),
            Positioned(
              top: 66,
              left: 130,
              right: 120,
              child: Text(
                'Current Balance',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white),
              ),
            ),
            Positioned(
                top: 88,
                left: 110,
                right: 100,
                child: Row(
                  children: [
                    dealerBalanceController.when(data: (data) {
                      return Text(
                        isVisibiltyOn ? getFormattedBalance(data) : '********',
                        style: AppTheme.lightTextTheme.displayMedium
                            ?.copyWith(fontSize: 28.sp, color: AppColors.white),
                      );
                    }, error: (error, str) {
                      log('balance error: $error');
                      return const Text('');
                    }, loading: () {
                      return const SpinKitChasingDots(
                        size: 20,
                        color: AppColors.white,
                      );
                    }),
                    6.wi,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisibiltyOn = !isVisibiltyOn;
                        });
                      },
                      child: SvgPicture.asset(
                        // width: 19.34.w,
                        // height: 17.25.h,
                        isVisibiltyOn
                            ? AppIcons.visibiltyOn
                            : AppIcons.visibiltyOff,
                        // width: 19.34.w,
                        // height: 17.25.h,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
