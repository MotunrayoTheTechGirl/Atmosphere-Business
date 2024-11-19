import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../survey_contents/survey_ads_info_contents.dart';
import '../survey_contents/survey_questions_content.dart';
import '../survey_contents/survey_questions_preview.dart';

class SurveyTabView extends ConsumerStatefulWidget {
  const SurveyTabView({
    super.key,
  });
  @override
  ConsumerState<SurveyTabView> createState() => _SurveyTabViewState();
}

class _SurveyTabViewState extends ConsumerState<SurveyTabView> {
  bool hasSwitchedContent = false;
  bool isSurveySummary = false;

  Widget content() {
    if (isSurveySummary) {
      return const SurveyQuestionsPreview();
    } else if (hasSwitchedContent) {
      return const SurveyQuestionsContent();
    }
    return const SurveyAdsInfoContents();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .9.sh,
      child: ListView(
        shrinkWrap: true,
        children: [
          content(),
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
                  isActive: ref.watch(isSurveyInfoContentValidStateProvider),
                  isLoading: false,
                  onTap:
                      ref.watch(isSurveyInfoContentValidStateProvider) == true
                          ? () {
                              setState(() {
                                hasSwitchedContent = true;
                                if (ref
                                    .watch(surveyQuestionStateProvider)
                                    .isNotEmpty) {
                                  isSurveySummary = true;
                                }
                              });

                              log('--title : ${ref.watch(surveyTitleStateProvider)}');
                              log('description: ${ref.watch(surveyDescriptionStateProvider)}');
                              log('entry amount: ${ref.watch(entityStateProvider)}');
                              log('budget: ${ref.watch(budgetStateProvider)}');
                              log('startDate: ${ref.watch(startDateStateProvider)}');
                              log('duration: ${ref.watch(durationStateProvider)}');
                              log('isFormValid: ${ref.watch(isSurveyInfoContentValidStateProvider)}');
                              log('isSurveySummary: $isSurveySummary');
                            }
                          : () {},
                  label: 'Continue',
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
