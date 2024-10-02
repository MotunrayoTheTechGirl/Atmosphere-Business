// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../widgets/wallet_history_tile.dart';

class WalletHistoryScreen extends StatelessWidget {
  const WalletHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'All Wallet Transactions',
        suffixIcon: AppIcons.filterIcon,
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.hi,
          Text(
            'Tuesday 14th',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.greyText,
            ),
          ),
          16.hi,
          WalletHistoryTile(
            date: intl.DateFormat('dd/MM/yy').format(DateTime(2024 - 09 - 24)),
            dataPlan: '30TB + 150K Hrs Plan',
            amount: '-${formatNaira('3000000')}',
          ),
          16.hi,
          WalletHistoryTile(
            date: intl.DateFormat('dd/MM/yy').format(DateTime(2024 - 09 - 24)),
            dataPlan: '30TB + 150K Hrs Plan',
            amount: '+${formatNaira('3000000')}',
            amountTextColor: AppColors.royalBlue,
            icon: AppIcons.greenArrow,
            iconBgColor: AppColors.greenShade50,
          ),
        ],
      ).padHorizontal(16)),
    );
  }
}
