import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class DataHourTile extends StatelessWidget {
  const DataHourTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomCheckbox(),
        Text(
          'Glo Atmosphere',
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
        Text(
          '100k Hours',
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
        Text(
          '₦10,000,000',
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
      ],
    );
  }
}
