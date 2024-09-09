import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class DataHourTile extends StatelessWidget {
  const DataHourTile({
    required this.plan,
    required this.quantity,
    required this.amount,
    this.isSelected = false,
    required this.onRemove,
    super.key,
  });
  final String plan, quantity, amount;
  final bool isSelected;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckbox(
            isChecked: isSelected,
            onChanged: (_) => onRemove(),
          ),
          SizedBox(
            width: 92.w,
            child: Center(
              child: Text(
                plan,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  color: AppColors.deepAsh,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 92.w,
            child: Center(
              child: Text(
                quantity,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  color: AppColors.deepAsh,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 92.w,
            child: Center(
              child: Text(
                amount,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  color: AppColors.deepAsh,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
