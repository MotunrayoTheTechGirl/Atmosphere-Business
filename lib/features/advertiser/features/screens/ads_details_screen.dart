// ignore_for_file: library_private_types_in_public_api

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/advertiser_overview_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/overview_tabview.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/preview_tabview.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/report_tabview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_tab_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';

class AdsDetailsScreen extends ConsumerStatefulWidget {
  const AdsDetailsScreen({Key? key}) : super(key: key);

  @override
  _AdsDetailsScreenState createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends ConsumerState<AdsDetailsScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    initializeTabController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int getTabCount(String? status) {
    return status == 'pending' ? 2 : 3;
    // return 2;
  }

  void initializeTabController() {
    final adsStatus = ref.read(statusStateProvider);
    int tabCount = getTabCount(adsStatus);
    // _tabController.dispose();
    _tabController = TabController(
      length: tabCount,
      vsync: this,
      initialIndex: 0,
    );
  }

  List<Widget> getTabs(String? status) {
    List<Widget> tabs = [
      const Tab(
        child: Text('OVERVIEW'),
      ),
      const Tab(
        child: Text('PREVIEW'),
      ),
    ];

    // Only add REPORT tab if not pending
    if (status != 'pending') {
      tabs.add(
        const Tab(
          child: Text('REPORT'),
        ),
      );
    }

    return tabs;
  }

  List<Widget> getTabViews(String? status) {
    List<Widget> tabViews = [
      const OverviewTabview(),
      const PreviewTabView(),
    ];

    // Only add REPORT tab view if not pending
    if (status != 'pending') {
      tabViews.add(const ReportTabView());
    }

    return tabViews;
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(statusStateProvider);
    if (_tabController.length != getTabCount(status)) {
      initializeTabController();
    }
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
            tabs: getTabs(status),
          ),
          26.hi,
          SizedBox(
            height: .9.sh,
            child: TabBarView(
              controller: _tabController,
              children: getTabViews(status),
            ),
          )
        ],
      ).padHorizontal(20)),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
