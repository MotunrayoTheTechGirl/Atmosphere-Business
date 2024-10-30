// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/widgets/fund_wallet_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class FundWalletButton extends StatelessWidget {
  const FundWalletButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        fundWalletAlertDialog(context: context);
      },
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5A3D8B), Color(0xffe1206c).withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            'Fund Wallet',
            style: AppTheme.lightTextTheme.displayMedium?.copyWith(
              fontSize: 15.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ).padHorizontal(6),
    );
  }
}
