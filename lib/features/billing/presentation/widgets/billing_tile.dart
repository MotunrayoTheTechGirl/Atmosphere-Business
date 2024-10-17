import 'package:dealer_portal_mobile/core/common_widgets/status_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/themes/app_themes.dart';

class BillingTile extends StatelessWidget {
  const BillingTile({
    this.isPaid = false,
    required this.onTap,
    this.id,
    this.dataPlan,
    this.price,
    this.name,
    this.duration,
    this.status = 'Pending',
    this.statusColor,
    this.statusColorBg,
    super.key,
  });
  final bool isPaid;
  final void Function() onTap;
  final String? id, dataPlan, price, name, duration;
  final String status;
  final Color? statusColor, statusColorBg;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id ?? '',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: AppColors.textColor,
                ),
              ),
              // isPaid
              //     ? const PaymentStatus(
              //         label: 'Used',
              //         color: AppColors.green,
              //         bgColor: AppColors.greyShade50,
              //       )
              //     : const PaymentStatus(
              //         label: 'Expired',
              //         color: AppColors.red,
              //       )
              PaymentStatus(
                label: status,
                color: statusColor,
                bgColor: statusColorBg,
              )
            ],
          ),
          6.hi,
          Text(
            dataPlan ?? '',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              color: AppColors.deepBrown,
            ),
          ),
          6.hi,
          Text(
            price ?? '',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.deepBrown,
            ),
          ),
          6.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    name ?? '',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.deepAsh,
                    ),
                  ),
                  6.wi,
                  Text(
                    duration ?? '',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.deepAsh,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      'VIEW DETAILS',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    6.wi,
                    SvgPicture.asset(AppIcons.angleArrow)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
