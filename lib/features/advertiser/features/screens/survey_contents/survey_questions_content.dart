// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:developer';

import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/logic/survey_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../../logic/survey_question_notifier.dart';
import '../../widgets/question_type_button.dart';
import '../../widgets/textfield_with_inline_label.dart';

final surveyQuestionStateProvider = StateProvider<String>((ref) => '');
final isQuestioncontentValid = StateProvider<bool>((ref) => false);

class SurveyQuestionsContent extends ConsumerStatefulWidget {
  const SurveyQuestionsContent({Key? key}) : super(key: key);

  @override
  _SurveyQuestionsContentState createState() => _SurveyQuestionsContentState();
}

class _SurveyQuestionsContentState
    extends ConsumerState<SurveyQuestionsContent> {
  bool isPollsClicked = true;
  bool isShortAnswerClicked = false;
  bool isYesOrNoClicked = false;
  bool selectedQuestionType = false;
  final surveyQuestionController = TextEditingController();
  final shortAnswerResponseController = TextEditingController();
  int pollResponseRadio = -1;
  int yesOrNoResponseRadio = -1;

  List<Map<String, dynamic>> pollResponses = [
    {'radio': -1, "text": TextEditingController()},
    {'radio': -1, "text": TextEditingController()},
    {'radio': -1, "text": TextEditingController()},
  ];

  List<Map<String, dynamic>> yesOrNoResponses = [
    {'radio': -1, "text": TextEditingController()},
    {'radio': -1, "text": TextEditingController()},
  ];

  void addToPollResponses() {
    setState(() {
      pollResponses.add(
        {'radio': -1, "text": TextEditingController()},
      );
    });
  }

  void removePollResponse() {
    setState(() {
      pollResponses.removeLast();
    });
  }

  @override
  void initState() {
    surveyQuestionController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    surveyQuestionController.removeListener(() {});
    super.dispose();
  }

  bool isFormValid() {
    if (surveyQuestionController.text.isNotEmpty ||
        shortAnswerResponseController.text.isNotEmpty ||
        pollResponses.any((response) => response['text'].text.isNotEmpty) ||
        yesOrNoResponses.any((response) => response['text'].text.isNotEmpty)) {
      ref.read(isQuestioncontentValid.notifier).state == true;
      return true;
    } else {
      ref.read(isQuestioncontentValid.notifier).state == false;
      return false;
    }
  }

  Widget questionTypeContent() {
    if (isShortAnswerClicked == true) {
      //! short answer contents
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Short Answer responses',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              color: AppColors.deepAsh,
            ),
          ),
          AppTextField(
            controller: shortAnswerResponseController,
            hintText: '',
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 8,
            ),
            style: AppTheme.lightTextTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              color: AppColors.greyText,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lighterText),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lighterText),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.lighterText),
            ),
          ),
          8.hi,
        ],
      );
    } else if (isYesOrNoClicked == true) {
      //! yes/No contents
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yes/No responses',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
              color: AppColors.deepAsh,
            ),
          ),
          8.hi,
          Column(
            children: yesOrNoResponses.asMap().entries.map((entry) {
              final index = entry.key;
              return Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                            horizontal: -4.0, vertical: -4.0),
                        value: entry.value['radio'],
                        activeColor: AppColors.black,
                        groupValue: yesOrNoResponseRadio,
                        onChanged: (val) {},
                      ).padOnly(top: 40.h),
                      8.wi,
                      Expanded(
                        child: TextfieldWithInlineLabel(
                          controller: entry.value['text'],
                          hintText: 'Response ${index + 1}',
                          hasInlineLAbel: false,
                          radius: 16.r,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
          8.hi
        ],
      );
    }
    //! polls contents
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Polls responses',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: AppColors.deepAsh,
          ),
        ),
        Column(
          children: pollResponses.asMap().entries.map((entry) {
            final index = entry.key;
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity:
                          const VisualDensity(horizontal: -4.0, vertical: -4.0),
                      value: entry.value['radio'],
                      activeColor: AppColors.black,
                      groupValue: pollResponseRadio,
                      onChanged: (val) {},
                    ).padOnly(top: 40.h),
                    8.wi,
                    Expanded(
                      child: TextfieldWithInlineLabel(
                        controller: entry.value['text'],
                        hintText: 'Response ${index + 1}',
                        hasInlineLAbel: false,
                        radius: 16.r,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
        45.hi,
        GestureDetector(
          onTap: addToPollResponses,
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.plusSign,
                color: AppColors.w5Color,
                height: 24.h,
                width: 24.w,
              ),
              8.wi,
              Text(
                'Add response',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: AppColors.w5Color,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Survey Question',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.black,
          ),
        ),
        TextfieldWithInlineLabel(
          controller: surveyQuestionController,
          label: 'Question 1',
          maxLines: 5,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 8,
          ),
          onChanged: (val) {
            ref.read(surveyQuestionStateProvider.notifier).state = val;
          },
        ),
        15.hi,
        Text(
          'Question Type',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: AppColors.deepAsh,
          ),
        ),
        15.hi,
        Row(
          children: [
            Expanded(
              child: QuestionTypeButton(
                isClicked: isPollsClicked,
                onTap: () {
                  setState(() {
                    isPollsClicked = !isPollsClicked;
                    isShortAnswerClicked = false;
                    isYesOrNoClicked = false;
                  });
                  log('isPollClicked = $isPollsClicked');
                },
                questionType: 'Polls',
                description: 'Select one from a list',
              ),
            ),
            8.wi,
            Expanded(
              child: QuestionTypeButton(
                isClicked: isShortAnswerClicked,
                onTap: () {
                  setState(() {
                    isShortAnswerClicked = !isShortAnswerClicked;
                    isPollsClicked = false;
                    isYesOrNoClicked = false;
                  });
                  log('isShortAnswerClicked = $isShortAnswerClicked');
                },
                questionType: 'Short answer',
                description: 'Limit to 100 characters',
              ),
            ),
            8.wi,
            Expanded(
              child: QuestionTypeButton(
                isClicked: isYesOrNoClicked,
                onTap: () {
                  setState(() {
                    isYesOrNoClicked = !isYesOrNoClicked;
                    isPollsClicked = false;
                    isShortAnswerClicked = false;
                  });
                  log('isYesOrNoClicked = $isYesOrNoClicked');
                },
                questionType: 'Yes/No',
                description: 'Select either of the two',
              ),
            ),
          ],
        ),
        16.hi,
        //! add contents
        questionTypeContent(),
        16.hi,
        AppElevatedButton(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          borderRadius: 5.r,
          width: 178.w,
          border: Border.all(width: 0.5, color: AppColors.lightPurple),
          onTap: () {
            List<String> answers = [];
            if (isPollsClicked) {
              setState(() {
                selectedQuestionType = isPollsClicked == true;
              });
              answers = pollResponses
                  .map((response) => response["text"].text)
                  .where((text) => text.isNotEmpty)
                  .cast<String>()
                  .toList();
            } else if (isShortAnswerClicked) {
              setState(() {
                selectedQuestionType = isShortAnswerClicked == true;
              });
              answers = ["short answer response"];
            } else {
              setState(() {
                selectedQuestionType = isYesOrNoClicked == true;
              });
              answers = yesOrNoResponses
                  .map((response) => response["text"].text)
                  .where((text) => text.isNotEmpty)
                  .cast<String>()
                  .toList();
            }
            log('----isPollClicked: $isPollsClicked');
            log('-----isShortAnswer clicked: $isShortAnswerClicked');
            log('---isYesOrNoClicked: $isShortAnswerClicked');
            ref.read(questionNotifierProvider.notifier).addQuestion(
                  SurveyQuestion(
                      question: surveyQuestionController.text,
                      responses: answers,
                      isPollQuestionType: isPollsClicked,
                      isShortQuestionType: isShortAnswerClicked,
                      isYesOrNoQuestionType: isYesOrNoClicked
                      // questionType: selectedQuestionType,
                      ),
                );
            surveyQuestionController.clear();
            shortAnswerResponseController.clear();
            pollResponses = [
              {'radio': -1, "text": TextEditingController()},
              {'radio': -1, "text": TextEditingController()},
              {'radio': -1, "text": TextEditingController()},
            ];
            yesOrNoResponses = [
              {'radio': -1, "text": TextEditingController()},
              {'radio': -1, "text": TextEditingController()},
            ];
            print(
                'question: ${ref.watch(questionNotifierProvider).first.question}');
          },
          // : () {
          //     log('form is not valid');
          //   },
          bgColor: AppColors.lightPurple,
          label: 'Add More Questions',
          labelStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.w5Color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600),
        ),
        20.hi,
      ],
    );
  }
}
