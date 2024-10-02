// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/app_colors.dart';
import '../utils/themes/app_themes.dart';

class CustomPinInputField extends StatelessWidget {
  CustomPinInputField({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.onChanged,
    this.controller,
  });

  final int length;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      length: length,
      appContext: context,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: AppColors.blackShade50,
      cursorHeight: 25,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (value) {
        HapticFeedback.mediumImpact();
        onChanged?.call(value);
      },
      validator: (value) {
        return null;
      },
      onCompleted: onCompleted,
      textStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.greyText),
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          activeColor: AppColors.primaryColor,
          selectedColor: AppColors.primaryColor,
          selectedFillColor: AppColors.white,
          inactiveColor: Colors.grey,
          borderWidth: 1,
          fieldWidth: 48.w,
          fieldHeight: 52.h,
          borderRadius: BorderRadius.circular(16),
          activeFillColor: AppColors.white,
          inactiveFillColor: AppColors.white),
    );
  }
}
