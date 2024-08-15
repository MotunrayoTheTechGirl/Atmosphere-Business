import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DropDownFormField extends StatefulWidget {
  const DropDownFormField({Key? key}) : super(key: key);

  @override
  _DropDownFormFieldState createState() => _DropDownFormFieldState();
}

class _DropDownFormFieldState extends State<DropDownFormField> {
  final List<String> _timeFrames = ['Daily', 'Weekly', 'Monthly'];
  String _selectedTimeFrame = 'Weekly';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        icon: SvgPicture.asset(
          AppIcons.arrowDown,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: 0.h,
            horizontal: 10.w,
          ),
        ),
        value: _selectedTimeFrame,
        items: _timeFrames.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.blackText,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTheme.montserratAlternate),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedTimeFrame = newValue;
            });
          }
        },
      ),
    );
  }
}
