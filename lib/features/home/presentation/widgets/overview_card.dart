import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    this.amount,
    this.suffixNumber,
    this.title,
    this.showWidget = true,
    this.icon,
    this.suffixColor,
    super.key,
  });
  final String? title, amount, suffixNumber, icon;
  final bool showWidget;
  final Color? suffixColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          8.hi,
          Text(
            amount ?? '',
            style: AppTheme.lightTextTheme.titleLarge?.copyWith(
              fontSize: 24.sp,
            ),
          ),
          1.hi,
          showWidget
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: suffixNumber,
                            style: AppTheme.lightTextTheme.bodyLarge
                                ?.copyWith(color: suffixColor),
                          ),
                          TextSpan(
                            text: 'compared to last week',
                            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                              color: AppColors.blackText.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      icon ?? '',
                      height: 50.h,
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    ).padHorizontal(20);
  }
}
