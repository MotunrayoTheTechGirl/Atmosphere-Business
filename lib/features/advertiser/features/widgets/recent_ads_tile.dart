import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class RecentAdsTile extends StatelessWidget {
  const RecentAdsTile({
    required this.label,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.onTap,
    this.statusTextColor,
    this.statusBgColor,
    super.key,
  });

  final String label, startDate, endDate, status;
  final void Function()? onTap;
  final Color? statusTextColor, statusBgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 126.w,
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.deepBrown,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 19.w),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                status,
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: statusTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
              ),
            ),
          ],
        ),
        8.hi,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Start Date: $startDate',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
                6.hi,
                Text(
                  'End Date: $endDate',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
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
                        fontSize: 15.sp,
                        color: AppColors.w5Color,
                        fontWeight: FontWeight.w500),
                  ),
                  6.wi,
                  SvgPicture.asset(AppIcons.angleArrow)
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
