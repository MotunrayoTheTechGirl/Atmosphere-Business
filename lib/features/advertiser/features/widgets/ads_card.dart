import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class AdsCard extends StatefulWidget {
  const AdsCard({
    required this.adsTitile,
    required this.adsType,
    required this.date,
    required this.status,
    this.pointColor,
    this.statusBgColor,
    this.statusTextColor,
    this.showPoint = true,
    this.onTap,
    super.key,
  });
  final Color? pointColor, statusBgColor, statusTextColor;
  final String adsTitile, date, status, adsType;
  final bool showPoint;
  final void Function()? onTap;

  @override
  State<AdsCard> createState() => _AdsCardState();
}

class _AdsCardState extends State<AdsCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 1,
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      child: InkWell(
        onTap: widget.onTap,
        highlightColor: AppColors.lightPurple,
        splashColor: AppColors.lightPurple,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.6.w,
              color: AppColors.lighterText.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.showPoint
                  ? Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                widget.pointColor ?? AppColors.purpleShade700,
                          ),
                        ),
                        14.wi,
                        Text(
                          widget.adsType,
                          style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                              color: AppColors.lighterText,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp),
                        ),
                      ],
                    )
                  : Text(
                      widget.adsType,
                      style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.lighterText,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp),
                    ),
              10.hi,
              SizedBox(
                width: 129.w,
                child: Text(
                  widget.adsTitile,
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.blackSupplementary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                  maxLines: 2,
                ),
              ),
              24.hi,
              Text(
                'Created on: ${widget.date}',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.greyShade200,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp),
              ),
              8.hi,
              Material(
                elevation: 0.1,
                shadowColor: widget.statusBgColor ?? AppColors.greenShade150,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: widget.statusBgColor ?? AppColors.greenShade150,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      widget.status,
                      style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: widget.statusTextColor ?? AppColors.deepGreen,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
