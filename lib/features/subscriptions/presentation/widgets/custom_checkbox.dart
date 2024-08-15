import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        side: const BorderSide(
          color: AppColors.primaryColor,
          width: 2.0,
        ),
        fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return AppColors.white;
          },
        ),
        onChanged: (bool? value) {
          setState(() {
            isChecked = value ?? false;
          });
        });
  }
}
