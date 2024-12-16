import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  CustomCheckbox({this.isChecked = false, required this.onChanged, Key? key})
      : super(key: key);
  bool isChecked;

  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      side: const BorderSide(
        color: AppColors.primaryColor,
        width: 2.0,
      ),
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.white;
        },
      ),
      onChanged: onChanged,
    );
  }
}
