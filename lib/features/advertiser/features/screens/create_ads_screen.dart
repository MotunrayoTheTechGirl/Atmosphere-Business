import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_image_ad_tab_view.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_video_ads_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_tab_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';

final advertiserIdStateProvider = StateProvider<String>((ref) => '');

class CreateAdsScreen extends ConsumerStatefulWidget {
  const CreateAdsScreen({this.initialTabIndex, Key? key}) : super(key: key);

  final int? initialTabIndex;

  @override
  _CreateAdsScreenState createState() => _CreateAdsScreenState();
}

class _CreateAdsScreenState extends ConsumerState<CreateAdsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(widget.initialTabIndex ?? 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.id;

    return Scaffold(
      appBar: const MenuAppBar(
        title: "Create Ad",
      ),
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.hi,
            AppTabBar(
              tabController: _tabController,
              tabs: const [
                Tab(
                  child: FittedBox(
                    child: Text(
                      'IMAGE AD',
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    child: Text(
                      'VIDEO AD',
                    ),
                  ),
                ),
                // Tab(
                //   child: FittedBox(
                //     child: Text(
                //       'SURVEY',
                //     ),
                //   ),
                // ),
              ],
            ),
            26.hi,
            SizedBox(
              height: .9.sh,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ImageAdTabBiew(),
                  VideoAdsTabView(),
                  // SurveyTabView(),
                ],
              ),
            )
          ],
        ).padHorizontal(16),
      ),
    );
  }
}
