import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/themes/app_themes.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({
    required this.label,
    super.key,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.textFieldBorder,
        ),
        children: [
          TextSpan(
            text: '*',
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.red,
            ),
          )
        ],
      ),
    );
  }
}
