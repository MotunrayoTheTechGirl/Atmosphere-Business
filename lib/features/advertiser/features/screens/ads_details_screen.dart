// ignore_for_file: library_private_types_in_public_api

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/overview_tabview.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/preview_tabview.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/report_tabview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_tab_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';

class AdsDetailsScreen extends StatefulWidget {
  const AdsDetailsScreen({Key? key}) : super(key: key);

  @override
  _AdsDetailsScreenState createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends State<AdsDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Details',
        backgroundColor: AppColors.white,
        icon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.leftArrow,
            width: 16.w,
            height: 8.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          AppTabBar(
            tabController: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  'OVERVIEW',
                ),
              ),
              Tab(
                child: Text(
                  'PREVIEW',
                ),
              ),
              Tab(
                child: Text(
                  'REPORT',
                ),
              ),
            ],
          ),
          26.hi,
          SizedBox(
            height: .9.sh,
            child: TabBarView(
              controller: _tabController,
              children: const [
                OverviewTabview(),
                PreviewTabView(),
                ReportTabView(),
              ],
            ),
          )
        ],
      ).padHorizontal(20)),
    );
  }
}
