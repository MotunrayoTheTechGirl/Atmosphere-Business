import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../widgets/textfield_with_inline_label.dart';

final isSurveyInfoContentValidStateProvider =
    StateProvider<bool>((ref) => false);
final surveyTitleStateProvider = StateProvider<String>((ref) => '');
final surveyDescriptionStateProvider = StateProvider<String>((ref) => '');
final entityStateProvider = StateProvider<String>((ref) => '');
final budgetStateProvider = StateProvider<String>((ref) => '');
final startDateStateProvider = StateProvider<String>((ref) => '');
final durationStateProvider = StateProvider((ref) => '');
final regionStateProvider = StateProvider<String>((ref) => '');

class SurveyAdsInfoContents extends ConsumerStatefulWidget {
  const SurveyAdsInfoContents({Key? key}) : super(key: key);

  @override
  _SurveyAdsInfoContentsState createState() => _SurveyAdsInfoContentsState();
}

class _SurveyAdsInfoContentsState extends ConsumerState<SurveyAdsInfoContents> {
  DateTime startDate = DateTime.now();
  bool isFormValid = false;

  final surveyTitleController = TextEditingController();
  final surveyDescriptionController = TextEditingController();
  final entryController = TextEditingController();
  final budgetController = TextEditingController();
  final startDateController = TextEditingController();
  final durationController = TextEditingController();
  //? optional
  final regionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    surveyTitleController.addListener(_validateForm);
    surveyDescriptionController.addListener(_validateForm);
    entryController.addListener(_validateForm);
    budgetController.addListener(_validateForm);
    startDateController.addListener(_validateForm);
    durationController.addListener(_validateForm);
  }

  @override
  void dispose() {
    surveyTitleController.removeListener(_validateForm);
    surveyDescriptionController.removeListener(_validateForm);
    entryController.removeListener(_validateForm);
    budgetController.removeListener(_validateForm);
    startDateController.removeListener(_validateForm);
    durationController.removeListener(_validateForm);

    surveyTitleController.dispose();
    surveyDescriptionController.dispose();
    entryController.dispose();
    budgetController.dispose();
    startDateController.dispose();
    durationController.dispose();
    regionController.dispose();

    super.dispose();
  }

  void _validateForm() {
    final bool isValid = surveyTitleController.text.isNotEmpty &&
        surveyDescriptionController.text.isNotEmpty &&
        entryController.text.isNotEmpty &&
        budgetController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        durationController.text.isNotEmpty;

    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
      ref.read(isSurveyInfoContentValidStateProvider.notifier).state = isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          controller: surveyTitleController,
          label: 'Survey Title',
          onChanged: (val) {
            ref.read(surveyTitleStateProvider.notifier).state = val;
          },
        ),
        15.hi,
        TextfieldWithInlineLabel(
          controller: surveyDescriptionController,
          label: 'Survey Description',
          maxLines: 4,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 8,
          ),
          onChanged: (val) {
            ref.read(surveyDescriptionStateProvider.notifier).state = val;
          },
        ),
        15.hi,
        TextfieldWithInlineLabel(
          readOnly: true,
          controller: entryController,
          label: 'Target Entry Amount',
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
                '50 entries',
                '100 entries',
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
              entryController.text = selected;
              ref.read(entityStateProvider.notifier).state = selected;
              setState(() {});
            }
          },
        ),
        15.hi,
        TextfieldWithInlineLabel(
          controller: budgetController,
          label: 'Budget',
          hintText: 'e.g 50,000',
          suffixIcon: SvgPicture.asset(
            AppIcons.info,
            color: AppColors.greyShade300,
            fit: BoxFit.scaleDown,
            width: 14.w,
            height: 14.h,
          ),
          keyboardType: TextInputType.number,
          onChanged: (val) {
            ref.read(budgetStateProvider.notifier).state = val;
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
                    ref.read(startDateStateProvider.notifier).state =
                        startDateController.text;
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
                  onChanged: (val) {
                    ref.read(durationStateProvider.notifier).state = val;
                  }),
            ),
          ],
        ),
        15.hi,
        TextfieldWithInlineLabel(
          controller: regionController,
          label: 'Region',
          readOnly: true,
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
              ref.read(regionStateProvider.notifier).state = selected;
              setState(() {});
            }
          },
        ),
      ],
    );
  }
}
