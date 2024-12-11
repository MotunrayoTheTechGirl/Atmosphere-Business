import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/create_ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/date_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../../../core/utils/ui_helper.dart';
import '../advertiser_overview_screen.dart';

final modifyTitleStateProvider = StateProvider<String>((ref) => '');
final modifyDescriptionStateProvider = StateProvider((ref) => '');
final modifyTargetStateProvider = StateProvider((ref) => '');
final modifyBudgetStateProvider = StateProvider((ref) => '');
final modifyStartDateStateProvider = StateProvider((ref) => '');
final modifyDurationStateProvider = StateProvider((ref) => '');
final modifyDeviceStateProvider = StateProvider((ref) => '');
final modifySizeStateProvider = StateProvider((ref) => '');
final modifydesiredScreenStateProvider = StateProvider((ref) => '');
final modifyCallToActionStateProvider = StateProvider((ref) => '');
final modifyBusinessCategoryStateProvider = StateProvider((ref) => '');
final modifyDisplayContentStateProvider = StateProvider((ref) => '');
final isModifyStateProvider = StateProvider<bool>((ref) => false);

class OverviewTabview extends ConsumerStatefulWidget {
  const OverviewTabview({Key? key}) : super(key: key);

  @override
  _OverviewTabviewState createState() => _OverviewTabviewState();
}

class _OverviewTabviewState extends ConsumerState<OverviewTabview> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(modifyTitleStateProvider.notifier).state =
          ref.watch(titleStateProvider) ?? '';
      ref.read(modifyDurationStateProvider.notifier).state =
          ref.watch(durationStateProvider) ?? '';
      ref.read(modifyDescriptionStateProvider.notifier).state =
          ref.watch(descriptionStateProvider) ?? '';
      ref.read(modifyTargetStateProvider.notifier).state =
          ref.watch(targetStateProvider) ?? '';
      ref.read(modifyBudgetStateProvider.notifier).state =
          ref.watch(budgetStateProvider) ?? '';
      ref.read(modifyCallToActionStateProvider.notifier).state =
          ref.watch(calltoActionStateProvider) ?? '';
      ref.read(modifyStartDateStateProvider.notifier).state =
          ref.watch(startDateStateProvider) ?? '';
      // ref.read(modifyCallToActionStateProvider.notifier).state =
      //     ref.watch(calltoActionStateProvider) ?? '';
      ref.read(modifyDeviceStateProvider.notifier).state =
          ref.watch(deviceStateProvider) ?? '';
      ref.read(modifydesiredScreenStateProvider.notifier).state =
          ref.watch(screenStateProvider);
      ref.read(modifyBusinessCategoryStateProvider.notifier).state =
          ref.watch(businessCategoryStateProvider);
      ref.read(modifyDisplayContentStateProvider.notifier).state =
          ref.watch(contentUrlStateProvider);

      log('---Durett state : ${ref.watch(durationStateProvider)}');
      log('budg: ${ref.watch(budgetStateProvider)}');
      log('amount spent: ${ref.watch(amountSpentStateProvider)}');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String createdDate = ref.watch(dateCreatedStateProvider) ?? '';
    DateTime parsedDate =
        createdDate.isEmpty ? DateTime.now() : DateTime.parse(createdDate);
    String dateCreated = DateFormat("HH:mm, dd/MM/yy").format(parsedDate);

    String adDateOverviewFormat(String? date) {
      DateTime? parsedEndDate = date == null ? null : DateTime.tryParse(date);
      String formattedAdDate = parsedEndDate == null
          ? ''
          : DateFormat("dd/MM/yy").format(parsedEndDate);
      return formattedAdDate;
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
                decoration: BoxDecoration(
                  color: () {
                    switch (ref.watch(statusStateProvider)) {
                      case "pending":
                        return AppColors.lightOrange;
                      case "active":
                        return AppColors.greenShade150;
                      case "completed":
                        return AppColors.primaryColor;
                      case "paused":
                        return AppColors.lightOrange;
                      default:
                        return AppColors.lightOrange;
                    }
                  }(),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  // ref.watch(statusStateProvider) == null
                  //     ? 'Pending'
                  //     : ref.watch(statusStateProvider) ?? '',
                  () {
                    switch (ref.watch(statusStateProvider)) {
                      case "pending":
                        return 'Pending';
                      case "active":
                        return "Active";
                      case "paused":
                        return "Paused";
                      default:
                        return 'Modify Ad';
                    }
                  }(),
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: () {
                        switch (ref.watch(statusStateProvider)) {
                          case "pending":
                            return AppColors.goldenYellow;
                          case "active":
                            return AppColors.deepGreen;
                          case "completed":
                            return AppColors.babyShade100;
                          case "paused":
                            return AppColors.goldenYellow;
                          default:
                            return AppColors.goldenYellow;
                        }
                      }(),
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
              //! temporary
              ref.watch(statusStateProvider) != 'pending'
                  ? const SizedBox()
                  : AppElevatedButton(
                      onTap: ref.watch(statusStateProvider) == 'pending'
                          ? () {
                              ref.read(isModifyStateProvider.notifier).state =
                                  true;
                              if (ref.watch(typeStateProvider) == 'image') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const CreateAdsScreen();
                                  }),
                                );
                              } else if (ref.watch(typeStateProvider) ==
                                  'video') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const CreateAdsScreen(
                                      initialTabIndex: 1,
                                    );
                                  }),
                                );
                              }
                            }
                          : () {},
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      bgColor: () {
                        switch (ref.watch(statusStateProvider)) {
                          case "pending":
                            return AppColors.lightPurple;
                          case 'active':
                            return AppColors.w5Color;
                          default:
                            return AppColors.lightPurple;
                        }
                      }(),
                      label: () {
                        switch (ref.watch(statusStateProvider)) {
                          case "pending":
                            return 'Modify Ad';
                          case "completed":
                            return "Re-Run";
                          case "active":
                            return "Pause Ad";
                          default:
                            return 'Modify Ad';
                        }
                      }(),
                      isFilled: () {
                        switch (ref.watch(statusStateProvider)) {
                          case "pending":
                            return true;
                          case "active":
                            return false;
                          default:
                            return true;
                        }
                      }(),
                      borderWidth: 0.2,
                      borderRadius: 5.r,
                      width: 100.w,
                      labelStyle:
                          AppTheme.lightTextTheme.displaySmall?.copyWith(
                        color: () {
                          switch (ref.watch(statusStateProvider)) {
                            case "pending":
                              return AppColors.w5Color;
                            case "active":
                              return AppColors.white;
                            default:
                              return AppColors.w5Color;
                          }
                        }(),
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
              InkWell(
                onTap: () async => await Clipboard.setData(
                  ClipboardData(text: ref.watch(targetStateProvider) ?? ''),
                ).then(
                  (value) => CustomSnackBar.showSnackBar(
                      context: context,
                      message: 'Target Url copied to clipboard'),
                ),
                child: SvgPicture.asset(AppIcons.link),
              ),
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
