import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/themes/app_themes.dart';

class DataPlanContainer extends StatelessWidget {
  const DataPlanContainer({
    required this.productLogo,
    required this.price,
    required this.allocation,
    required this.validity,
    required this.onTap,
    super.key,
  });
  final Widget productLogo;
  final String price, allocation, validity;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 1.2, color: AppColors.lightBorder),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              productLogo,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                child: Text(
                  price,
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          10.hi,
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Allocation',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.hi,
                  SizedBox(
                    width: 200.w,
                    child: Text(
                      allocation,
                      style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        color: AppColors.greyText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              26.wi,
              SizedBox(
                height: 60.h,
                child: const VerticalDivider(
                  thickness: 1,
                  color: AppColors.lightBorder,
                ),
              ),
              26.wi,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Validity',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.hi,
                  Text(
                    validity,
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          16.hi,
          const AppDivider(),
          14.hi,
          AppElevatedButton(
            width: 300.w,
            onTap: onTap,
            // label: 'Assign to customer',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  AppIcons.customer,
                  width: 24.w,
                  height: 16.h,
                ),
                Text(
                  'Assign to customer',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
