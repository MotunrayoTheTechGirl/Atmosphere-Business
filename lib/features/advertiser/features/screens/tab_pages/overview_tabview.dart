import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/date_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../../../core/utils/ui_helper.dart';
import '../advertiser_overview_screen.dart';

class OverviewTabView extends ConsumerWidget {
  const OverviewTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String createdDate = ref.watch(dateCreatedStateProvider) ?? '';
    DateTime parsedDate =
        createdDate.isEmpty ? DateTime.now() : DateTime.parse(createdDate);
    String dateCreated = DateFormat("HH:mm, dd/MM/yy").format(parsedDate);

    String adDateOverviewFormat(String? date) {
      DateTime? parsedEndDate = date == null ? null : DateTime.tryParse(date);
      parsedEndDate == null ? '' : DateFormat("dd/MM/yy").format(parsedEndDate);
      return '';
    }

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
                  ref.watch(statusStateProvider) ?? '',
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
              ref.watch(titleStateProvider) ?? '',
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
                  DateColumn(
                      dateType: 'Start Date',
                      date: adDateOverviewFormat(
                          ref.watch(startDateStateProvider))),
                  26.wi,
                  DateColumn(
                    dateType: 'End Date',
                    date: adDateOverviewFormat(ref.watch(endStateProvider)),
                  ),
                ],
              ),
              AppElevatedButton(
                onTap: () {},
                label: () {
                  switch (ref.watch(statusStateProvider)) {
                    case "pending":
                      return 'Modify Ad';
                    case "completed":
                      return "Re-Run";
                    default:
                      return '';
                  }
                }(),
                // 'Re-Run',
                width: 100.w,
                labelStyle: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                ),
              )
            ],
          ),
          10.hi,
          DateColumn(
            dateType: 'Duration',
            date: '${ref.watch(durationStateProvider)} Days',
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
            ref.watch(descriptionStateProvider) ?? '',
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
                ref.watch(targetStateProvider) ?? '',
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
            formatNaira(ref.watch(budgetStateProvider) ?? '0'),
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
            ref.watch(calltoActionStateProvider) ?? '',
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
                date: ref.watch(amountSpentStateProvider) == null
                    ? formatNaira('0')
                    : formatNaira(ref.watch(amountSpentStateProvider) ?? ''),
              ),
              24.wi,
              DateColumn(
                dateType: 'Balance',
                date: formatNaira('0'),
              ),
            ],
          ),
          24.hi,
          DateColumn(
            dateType: 'Date Created',
            date: dateCreated,
          ),
        ],
      ),
    );
  }
}
