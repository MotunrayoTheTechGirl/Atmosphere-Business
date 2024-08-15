import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.lightBorder,
      height: 2,
    );
  }
}
