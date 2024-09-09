import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DataPackCard extends StatelessWidget {
  const DataPackCard(
      {required this.name,
      required this.description,
      required this.price,
      this.isSelected = false,
      required this.onTap,
      Key? key})
      : super(key: key);

  final String name, description, price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 164.h,
        child: Material(
          elevation: 0.4,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 6,
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
              children: [
                CustomCheckbox(
                  isChecked: isSelected,
                  onChanged: (_) => onTap(),
                ),
                Text(
                  name,
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepBrown,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                6.hi,
                Text(
                  description,
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepBrown,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                14.hi,
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  decoration: const BoxDecoration(
                    color: AppColors.deepBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    price,
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
