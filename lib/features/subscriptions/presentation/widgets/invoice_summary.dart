import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class InvoiceSummary extends StatelessWidget {
  const InvoiceSummary({
    required this.leading,
    required this.trailing,
    super.key,
  });
  final String leading, trailing;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: leading,
        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontSize: 14,
          color: AppColors.deepAsh,
        ),
        children: [
          TextSpan(
            text: trailing,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
