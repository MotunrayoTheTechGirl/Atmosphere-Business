import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DataPackCard extends StatefulWidget {
  const DataPackCard({Key? key}) : super(key: key);

  @override
  _DataPackCardState createState() => _DataPackCardState();
}

class _DataPackCardState extends State<DataPackCard> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.4,
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 1),
          color: AppColors.lightAsh,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomCheckbox(),
            Text(
              'Glo Combine Plan',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                color: AppColors.deepBrown,
                fontWeight: FontWeight.w400,
              ),
            ),
            6.hi,
            Text(
              '20TB + 100K Hrs Plan',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.deepBrown,
              ),
            ),
            14.hi,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              decoration: const BoxDecoration(
                color: AppColors.deepBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Text(
                '₦14,800,000',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
