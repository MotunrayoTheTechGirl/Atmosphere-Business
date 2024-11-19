// ignore_for_file: must_be_immutable

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class QuestionTypeButton extends StatefulWidget {
  QuestionTypeButton({
    this.isClicked = false,
    required this.onTap,
    required this.questionType,
    required this.description,
    super.key,
  });

  final String questionType, description;
  bool isClicked;
  final void Function()? onTap;
  @override
  State<QuestionTypeButton> createState() => _QuestionTypeButtonState();
}

class _QuestionTypeButtonState extends State<QuestionTypeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isClicked
              ? AppColors.lightPurpleShade800
              : AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.52.r),
          ),
          border: Border.all(
              color:
                  widget.isClicked ? AppColors.w5Color : AppColors.greyShade300,
              width: 0.83.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.questionType,
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.black,
              ),
            ),
            6.hi,
            SizedBox(
              width: 90.w,
              child: Text(
                widget.description,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: AppColors.greyTextShade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
