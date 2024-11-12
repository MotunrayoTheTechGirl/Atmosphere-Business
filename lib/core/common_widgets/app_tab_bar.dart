import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/themes/app_themes.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  final TabController tabController;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: tabController,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
          insets: EdgeInsets.symmetric(horizontal: -16.0),
        ),
        labelColor: AppColors.black,
        labelStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        unselectedLabelColor: AppColors.unSelectedTab.withOpacity(0.7),
        dividerColor: AppColors.white,
        indicatorWeight: 0.4,
        tabs: tabs);
  }
}
