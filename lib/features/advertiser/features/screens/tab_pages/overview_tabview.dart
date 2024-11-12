import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/date_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../../../core/utils/ui_helper.dart';

class OverviewTabView extends StatelessWidget {
  const OverviewTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.sh,
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ad Title',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.blackText.withOpacity(0.4),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 19.w),
                decoration: const BoxDecoration(
                  color: AppColors.babyShade100,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  'Completed',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
              ),
            ],
          ),
          4.hi,
          Container(
            padding: EdgeInsets.only(right: 200.h),
            width: 200,
            child: Text(
              'Taste the Joy: Coca-Cola - The Ad Campaign',
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.blackSupplementary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                fontFamily: AppTheme.montserratAlternate,
              ),
              softWrap: true,
              maxLines: 2,
            ),
          ),
          20.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const DateColumn(
                    dateType: 'Start Date',
                    date: '12/03/24',
                  ),
                  26.wi,
                  const DateColumn(
                    dateType: 'End Date',
                    date: '12/03/24',
                  ),
                ],
              ),
              AppElevatedButton(
                onTap: () {},
                label: 'Re-Run',
                width: 100.w,
                labelStyle: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
          10.hi,
          const DateColumn(
            dateType: 'Duration',
            date: '20 Days',
          ),
          32.hi,
          Text(
            'Ad Description',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.blackText.withOpacity(0.4),
            ),
          ),
          10.hi,
          Text(
            'Get your business noticed where customers are already spending their time. Atmosphere provides a single platform for managing your marketing campaigns across it’s Wi-Fi network.',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.blackSupplementary,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              fontFamily: AppTheme.montserratAlternate,
            ),
            maxLines: 5,
          ),
          24.hi,
          Text(
            'Target URL',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.blackText.withOpacity(0.4),
            ),
          ),
          9.hi,
          Row(
            children: [
              Text(
                'www.atmosphere.com',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.blackSupplementary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  fontFamily: AppTheme.montserratAlternate,
                ),
                maxLines: 2,
              ),
              10.wi,
              SvgPicture.asset(AppIcons.link),
            ],
          ),
          24.hi,
          Text(
            'Budget',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.blackText.withOpacity(0.4),
            ),
          ),
          9.hi,
          Text(
            formatNaira('3000'),
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.blackSupplementary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              fontFamily: AppTheme.montserratAlternate,
            ),
          ),
          24.hi,
          Text(
            'Call to Action Text',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.blackText.withOpacity(0.4),
            ),
          ),
          9.hi,
          Text(
            'Learn more',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.blackSupplementary,
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              fontFamily: AppTheme.montserratAlternate,
            ),
          ),
          24.hi,
          Row(
            children: [
              DateColumn(
                dateType: 'Spent',
                date: formatNaira('20000'),
              ),
              24.wi,
              DateColumn(
                dateType: 'Balance',
                date: formatNaira('30000'),
              ),
            ],
          ),
          24.hi,
          const DateColumn(
            dateType: 'Date Created',
            date: '16:30, 10/03/24',
          ),
        ],
      ),
    );
  }
}
