import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class TextfieldWithInlineLabel extends StatelessWidget {
  const TextfieldWithInlineLabel(
      {required this.controller,
      this.hintText,
      required this.label,
      this.isRequired = true,
      this.suffixIcon,
      this.onTap,
      this.maxLines,
      this.readOnly = false,
      this.textColor,
      this.contentPadding,
      this.keyboardType,
      this.onChanged,
      Key? key})
      : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String label;
  final bool isRequired;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final int? maxLines;
  final bool readOnly;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: readOnly,
      fillColor: AppColors.white,
      controller: controller,
      onChanged: onChanged,
      hintText: hintText ?? '',
      maxLines: maxLines,
      keyboardType: keyboardType,
      hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.greyShade200,
      ),
      defaultWidgetLabel: RichText(
        text: TextSpan(
          text: label,
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.deepAsh,
          ),
          children: [
            TextSpan(
              text: isRequired ? ' * ' : '',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ),
      // const TopAlignedTextfieldLabel(
      //   label: 'Region',
      //   isRequired: false,
      // ),
      radius: 10.r,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 8,
          ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: textColor ?? AppColors.greyText,
      ),
      suffixIcon: suffixIcon,
      onTap: onTap,
    );
  }
}
