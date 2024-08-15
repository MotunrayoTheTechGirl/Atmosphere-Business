import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class InvoiceBreakDownTile extends StatelessWidget {
  const InvoiceBreakDownTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
