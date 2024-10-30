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
      width: double.infinity,
      height: 218.h,
      decoration: const BoxDecoration(
        color: AppColors.w5Color,
        borderRadius: BorderRadius.all(
          Radius.circular(19.62),
        ),
        image: DecorationImage(
            image: AssetImage(AppIcons.fivee), alignment: Alignment.topLeft),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 13),
        child: Column(
          children: [
            Image(
              image: const AssetImage(
                AppIcons.wave5Logo,
              ),
              fit: BoxFit.scaleDown,
              width: 70.w,
              height: 40.h,
            ).padBottom(30),
            Text(
              'Wallet Amount',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dealerBalanceController.when(
                  data: (data) {
                    return Text(
                      isVisibiltyOn ? getFormattedBalance(data) : '********',
                      style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                        fontSize: 29.sp,
                        color: AppColors.white,
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    log('balance error: $error');
                    return const Text('');
                  },
                  loading: () {
                    return const SpinKitChasingDots(
                      size: 20,
                      color: AppColors.white,
                    );
                  },
                ),
                6.wi,
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
        ),
      ),
    );
  }
}
