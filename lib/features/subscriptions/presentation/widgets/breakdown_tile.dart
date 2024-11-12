import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class BreakDownTile extends StatelessWidget {
  BreakDownTile({
    required this.prefix,
    required this.suffix,
    this.prefixTextStyle,
    this.suffixTextSyle,
    this.isFilled = false,
    super.key,
  });
  final String prefix, suffix;
  final TextStyle? prefixTextStyle, suffixTextSyle;
  bool isFilled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14),
      decoration: BoxDecoration(
        color: isFilled ? AppColors.greyShade50 : Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                prefix,
                style: prefixTextStyle ??
                    AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: AppColors.deepAsh, fontSize: 13.17.sp),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                suffix,
                style: suffixTextSyle ??
                    AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: AppColors.deepAsh, fontSize: 13.17.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
