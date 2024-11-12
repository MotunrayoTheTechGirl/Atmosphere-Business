import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    this.color,
    this.thickness,
    super.key,
  });
  final Color? color;
  final double? thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.lightBorder,
      height: 2,
      thickness: thickness,
    );
  }
}
