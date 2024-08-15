import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final TextStyle? style;
  final TextStyle? hintStyle, prefixStyle;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final String? prefixText;
  final Widget? suffix, prefixIcon;

  const AppTextField(
      {required this.controller,
      required this.hintText,
      this.keyboardType,
      this.suffixText,
      this.suffixStyle,
      this.style,
      this.suffixIcon,
      this.fillColor,
      this.hintStyle,
      this.radius,
      this.contentPadding,
      this.filled = true,
      this.prefixText,
      this.suffix,
      this.prefixStyle,
      this.prefixIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: style ??
          AppTheme.lightTextTheme.titleLarge?.copyWith(
            fontSize: 32.sp,
            color: AppColors.greyText,
          ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: prefixStyle ??
            AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontSize: 18.sp,
              color: AppColors.textFieldBorder,
            ),
        contentPadding: contentPadding,
        hintText: hintText,
        hintStyle: hintStyle ??
            AppTheme.lightTextTheme.displaySmall
                ?.copyWith(color: AppColors.lighterText),
        filled: filled,
        fillColor: fillColor ?? AppColors.appbarColor.withOpacity(0.5),
        suffixText: suffixText,
        suffixStyle: suffixStyle,
        suffixIcon: suffixIcon,
        suffix: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 24.0),
          borderSide: filled
              ? BorderSide.none
              : BorderSide(
                  width: 1,
                  color: AppColors.textFieldBorder.withOpacity(0.2),
                ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 24.0),
          borderSide: filled
              ? BorderSide.none
              : const BorderSide(width: 1, color: AppColors.textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 24.0),
          borderSide: filled
              ? BorderSide.none
              : const BorderSide(width: 1, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
