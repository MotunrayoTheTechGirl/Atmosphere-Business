import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class InvoiceBreakDownTile extends StatelessWidget {
  const InvoiceBreakDownTile({
    required this.plan,
    required this.quantity,
    required this.amount,
    super.key,
  });
  final String plan, quantity, amount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          amount,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
        Text(
          quantity,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
        Text(
          amount,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
            color: AppColors.deepAsh,
          ),
        ),
      ],
    );
  }
}
