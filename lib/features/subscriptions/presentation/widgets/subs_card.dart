import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class SubsCard extends StatelessWidget {
  const SubsCard({
    required this.subTitle,
    required this.title,
    required this.buttonLabel,
    required this.onTap,
    super.key,
  });

  final String title, subTitle, buttonLabel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.lightBorder,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.deepBrown),
          ),
          20.hi,
          Text(
            subTitle,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              color: AppColors.deepBrown,
              fontWeight: FontWeight.w400,
            ),
          ),
          30.hi,
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(
                top: 15.1,
                bottom: 15.1,
                left: 50,
                right: 50,
              ),
              decoration: BoxDecoration(
                color: AppColors.skyeBlue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(28.7),
                ),
              ),
              child: Text(
                buttonLabel,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
