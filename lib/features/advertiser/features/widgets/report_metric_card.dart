import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class ReportMetricsCard extends StatefulWidget {
  ReportMetricsCard({
    required this.metricType,
    required this.metricValue,
    required this.metricpercentage,
    this.color = AppColors.w5Color,
    required this.onTap,
    this.isTapped = false,
    super.key,
  });

  final String metricType, metricValue, metricpercentage;
  Color? color;
  final void Function()? onTap;
  bool isTapped;

  @override
  State<ReportMetricsCard> createState() => _ReportMetricsCardState();
}

class _ReportMetricsCardState extends State<ReportMetricsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.lightPurple),
          color: widget.isTapped == true ? AppColors.white : AppColors.w5Color,
          borderRadius: BorderRadius.all(Radius.circular(14.37.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.metricType,
              style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppTheme.montserratAlternate),
            ),
            7.18.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.metricValue,
                  style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      fontSize: 24.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppTheme.montserratAlternate),
                ),
                Row(
                  children: [
                    Text(
                      widget.metricpercentage,
                      style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    4.wi,
                    SvgPicture.asset(
                      AppIcons.arrowRise,
                      color: AppColors.white,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
