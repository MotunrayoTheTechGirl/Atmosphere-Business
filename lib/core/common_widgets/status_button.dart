import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({
    required this.label,
    this.color,
    this.bgColor,
    super.key,
  });
  final String label;
  final Color? color, bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.redShade50,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Text(
        label,
        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            fontFamily: AppTheme.montserratAlternate),
      ),
    );
  }
}
