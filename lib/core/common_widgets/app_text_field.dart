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
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final String? label;

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
      this.validator,
      this.autovalidateMode,
      this.onChanged,
      this.enabledBorder,
      this.focusedBorder,
      this.border,
      this.label,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
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
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 24.0),
                  borderSide: filled
                      // ? BorderSide.none
                      ? BorderSide(
                          width: 0.2,
                          color: AppColors.textFieldBorder.withOpacity(0.2),
                        )
                      : BorderSide(
                          width: 0.2,
                          color: AppColors.textFieldBorder.withOpacity(0.2),
                        ),
                ),
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 24.0),
                  borderSide: filled
                      // ? BorderSide.none
                      ? BorderSide(
                          width: 0.2,
                          color: AppColors.textFieldBorder.withOpacity(0.2),
                        )
                      : const BorderSide(
                          width: 1, color: AppColors.textFieldBorder),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 24.0),
                  borderSide: filled
                      // ? BorderSide.none
                      ? BorderSide(
                          width: 0.2,
                          color: AppColors.textFieldBorder.withOpacity(0.2),
                        )
                      : const BorderSide(
                          width: 1, color: AppColors.primaryColor),
                ),
          ),
        ),
      ],
    );
  }
}
