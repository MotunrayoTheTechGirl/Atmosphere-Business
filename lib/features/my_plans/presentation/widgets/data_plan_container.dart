import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/plan_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/themes/app_themes.dart';

class DataPlanContainer extends StatelessWidget {
  const DataPlanContainer({
    super.key,
  });

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
              Text(
                'Glo Atmosphere plan',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyText,
                ),
              ),
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
                  '₦5,000',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    '25GB + 10HRs',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
                child: const VerticalDivider(
                  thickness: 1,
                  color: AppColors.lightBorder,
                ),
              ),
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
                    '30 days',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          18.hi,
          const AppDivider(),
          18.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppElevatedButton(
                width: 244.w,
                onTap: () {},
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
              GestureDetector(
                onTap: () {
                  planBottomSheet(context: context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: AppColors.primaryColor.withOpacity(0.1),
                  ),
                  child: SvgPicture.asset(AppIcons.dotMenu),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
