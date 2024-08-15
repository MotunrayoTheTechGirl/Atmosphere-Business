import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/themes/app_themes.dart';

class CustomPrimaryTabbar extends StatelessWidget {
  const CustomPrimaryTabbar({
    super.key,
    required this.controller,
    required this.tabs,
    this.margin,
    this.indicatorPadding,
  });

  final TabController controller;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? indicatorPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.h,
      decoration: BoxDecoration(
        color: AppColors.tabBarColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TabBar(
          unselectedLabelColor: AppColors.deepAsh,
          labelColor: Colors.black,
          labelStyle:
              AppTheme.lightTextTheme.bodyLarge?.copyWith(fontSize: 14.sp),
          indicatorWeight: 0,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: indicatorPadding ?? const EdgeInsets.all(6),
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          controller: controller,
          tabs: tabs),
    );
  }
}
