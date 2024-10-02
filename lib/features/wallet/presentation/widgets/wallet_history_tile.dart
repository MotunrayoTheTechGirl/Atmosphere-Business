import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class WalletHistoryTile extends StatelessWidget {
  const WalletHistoryTile({
    required this.date,
    required this.dataPlan,
    required this.amount,
    this.iconBgColor,
    this.amountTextColor,
    this.icon,
    super.key,
  });

  final String date, dataPlan, amount;
  final Color? iconBgColor, amountTextColor;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconBgColor ?? AppColors.redShade200,
                ),
                child: Image.asset(
                  icon ?? AppIcons.redArrow,
                  fit: BoxFit.scaleDown,
                  height: 26.h,
                  width: 26.w,
                ),
              ),
              10.wi,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  3.hi,
                  Text(
                    dataPlan,
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.royalBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: AppTheme.lightTextTheme.displayMedium?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: amountTextColor ?? AppColors.redShade500,
            ),
          ),
        ],
      ),
    );
  }
}
