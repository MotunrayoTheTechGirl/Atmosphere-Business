import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/logic/survey_question_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/themes/app_themes.dart';

class SurveyQuestionsPreview extends ConsumerStatefulWidget {
  const SurveyQuestionsPreview({Key? key}) : super(key: key);

  @override
  ConsumerState<SurveyQuestionsPreview> createState() =>
      _SurveyQuestionsPreviewState();
}

class _SurveyQuestionsPreviewState
    extends ConsumerState<SurveyQuestionsPreview> {
  @override
  Widget build(BuildContext context) {
    final questionsController = ref.watch(questionNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.black,
          ),
        ),
        8.hi,
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final question = questionsController[index];
              String selectedQuestionType() {
                if (question.isPollQuestionType == true) {
                  return 'Poll Choice';
                } else if (question.isShortQuestionType == true) {
                  return 'Short answer choice';
                } else if (question.isYesOrNoQuestionType == true) {
                  return 'Yes or No choice';
                }
                return '';
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q${index + 1}',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.blackText.withOpacity(0.3),
                    ),
                  ),
                  22.wi,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          color: AppColors.brownShade800,
                        ),
                      ),
                      Text(
                        selectedQuestionType(),
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      10.hi,
                      // ...question.responses.map((response) {
                      //   return Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 4),
                      //     child: Row(children: [
                      //       Container(
                      //         height: 6,
                      //         width: 6,
                      //         color: AppColors.red,
                      //       ),
                      //       Text(response),
                      //     ]),
                      //   );
                      // }
                      // ),
                      ...question.responses.map((response) {
                        if (question.isPollQuestionType == true) {
                          return Row(children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: const VisualDensity(
                                  horizontal: -4.0, vertical: -4.0),
                              value: 0,
                              groupValue: -1,
                              fillColor:
                                  WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return Colors.red;
                                }
                                return AppColors.greyShade200;
                              }),
                              onChanged: (val) {},
                            ),
                            6.wi,
                            Text(
                              response,
                              style:
                                  AppTheme.lightTextTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.greyText.withOpacity(0.8),
                              ),
                            ),
                          ]);
                        } else if (question.isYesOrNoQuestionType == true) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(children: [
                              Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(
                                    horizontal: -4.0, vertical: -4.0),
                                value: 0,
                                groupValue: -1,
                                fillColor:
                                    WidgetStateProperty.resolveWith((states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return Colors.red;
                                  }
                                  return AppColors.greyShade200;
                                }),
                                onChanged: (val) {},
                              ),
                              6.wi,
                              Text(
                                response,
                                style:
                                    AppTheme.lightTextTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.greyText.withOpacity(0.8),
                                ),
                              ),
                            ]),
                          );
                        } else {
                          return Column(
                            children: [
                              Text(response),
                              6.hi,
                              const AppDivider(
                                thickness: 1.5,
                                color: AppColors.red,
                              ),
                            ],
                          );
                        }
                      }),
                    ],
                  )
                ],
              ).padSymmetric(vertical: 26);
            },
            separatorBuilder: (context, index) {
              return const AppDivider();
            },
            itemCount: questionsController.length),
      ],
    );
  }
}
