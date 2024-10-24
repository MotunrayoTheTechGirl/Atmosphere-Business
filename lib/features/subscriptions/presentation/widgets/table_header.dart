import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    required this.heading,
    super.key,
  });
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      style: AppTheme.lightTextTheme.bodySmall?.copyWith(
        fontSize: 13.sp,
        color: AppColors.greyText,
      ),
    );
  }
}
