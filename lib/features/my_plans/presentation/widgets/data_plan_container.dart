import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1.2, color: AppColors.lightBorder),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          productLogo,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      allocation,
                      style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        color: AppColors.greyText,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  6.hi,
                  Text(
                    price,
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 25.sp,
                      color: AppColors.deepBrown,
                    ),
                  ),
                  6.hi,
                  Text(
                    'Validity: $validity',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.w5Color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                    ),
                  ),
                  child: Text(
                    'Assign',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
