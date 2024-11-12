import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../widgets/reward_alert_dialog.dart';
import '../../widgets/textfield_with_inline_label.dart';

class MobileAdsTabView extends StatefulWidget {
  const MobileAdsTabView({
    super.key,
  });

  @override
  State<MobileAdsTabView> createState() => _MobileAdsTabViewState();
}

class _MobileAdsTabViewState extends State<MobileAdsTabView> {
  DateTime startDate = DateTime.now();
  bool isFormValid = false;
  final adTitleController = TextEditingController();
  final adDescriptionController = TextEditingController();
  final typeController = TextEditingController();
  final durationController = TextEditingController();
  final startDateController = TextEditingController();
  final desiredScreenController = TextEditingController();
  final businessCategoryController = TextEditingController();
  //? optional
  final regionController = TextEditingController();

  bool valiadteForm() {
    if (adTitleController.text.isNotEmpty &&
        adDescriptionController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        desiredScreenController.text.isNotEmpty &&
        businessCategoryController.text.isNotEmpty) {
      return isFormValid = true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .9.sh,
      child: ListView(
        children: [
          Text(
            'Ad Information',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ),
          TextfieldWithInlineLabel(
            controller: adTitleController,
            label: 'Mobile Ad Title',
          ),
          15.hi,
          TextfieldWithInlineLabel(
            controller: adDescriptionController,
            label: 'Ad Description',
            maxLines: 4,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8,
            ),
          ),
          15.hi,
          TextfieldWithInlineLabel(
            readOnly: true,
            controller: typeController,
            label: 'Type',
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 500.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Display',
                  'Incentivized',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                typeController.text = selected;
                setState(() {});
              }
            },
          ),
          if (typeController.text == 'Incentivized')
            TextfieldWithInlineLabel(
              readOnly: true,
              controller: TextEditingController(text: 'click to enter details'),
              textColor: AppColors.biroBlue,
              label: 'Reward',
              onTap: () {
                rewardAlertDialog(context: context);
              },
            ),
          15.hi,
          Row(
            children: [
              Expanded(
                child: TextfieldWithInlineLabel(
                  controller: startDateController,
                  hintText: startDateController.text.isNotEmpty
                      ? DateFormat('yyyy-MM-dd').format(startDate)
                      : 'select start date',
                  label: 'Start Date',
                  suffixIcon: SvgPicture.asset(
                    AppIcons.calendar,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () async {
                    final currentDate = DateTime.now();
                    final datePicker = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: DateTime(currentDate.year - 0),
                        lastDate: DateTime(currentDate.year + 100));
                    if (datePicker != null) {
                      startDate = datePicker;
                      startDateController.text =
                          DateFormat('yyyy-MM-dd').format(startDate);
                    }
                  },
                ),
              ),
              16.wi,
              Expanded(
                child: TextfieldWithInlineLabel(
                  controller: durationController,
                  hintText: 'e.g 10 Days',
                  label: 'Duration (Days)',
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: desiredScreenController,
            label: 'Desired Screen',
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 650.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Welcome page',
                  'Home page',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                desiredScreenController.text = selected;
                setState(() {});
              }
            },
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: businessCategoryController,
            label: 'Business Category',
            readOnly: true,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 750.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Manufacturing',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                businessCategoryController.text = selected;
                setState(() {});
              }
            },
          ),
          24.hi,
          Text(
            'Target Location',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.black,
            ),
          ),
          8.hi,
          TextfieldWithInlineLabel(
            controller: regionController,
            label: 'Region',
            isRequired: false,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 750.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Lagos',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                regionController.text = selected;
                setState(() {});
              }
            },
          ),
          30.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppElevatedButton(
                  onTap: () {},
                  bgColor: AppColors.lightPurple,
                  label: 'Save Progress',
                  labelStyle: AppTheme.lightTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.w5Color, fontSize: 16.sp),
                ),
              ),
              60.wi,
              Expanded(
                child: AppElevatedButton(
                  isActive: valiadteForm(),
                  isLoading: false,
                  onTap: () {},
                  label: 'Submit',
                ),
              ),
            ],
          ),
          100.hi,
        ],
      ),
    );
  }
}
