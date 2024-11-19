import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_image_ad_tab_view.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_mobile_ads_tab_view.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_survey_tab_view.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/tab_pages/create_video_ads_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_tab_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../data/repository/get_advertiser_id_repository.dart';

final advertiserIdStateProvider = StateProvider<String>((ref) => '');

class CreateAdsScreen extends ConsumerStatefulWidget {
  const CreateAdsScreen({Key? key}) : super(key: key);

  @override
  _CreateAdsScreenState createState() => _CreateAdsScreenState();
}

class _CreateAdsScreenState extends ConsumerState<CreateAdsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // void isAdvertiser() async {
  // final userId =
  //     ref.watch(userDetailsControllerProvider).data?.data?.user?.id;
  // final hasFetchedAdviserId = await ref
  //     .read(fetchAdvertiserByUserIdControllerProvider.notifier)
  //     .getAdvertiserId(userId: userId.toString());
  //       if(!hasFetchedAdviserId){
  //       }
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
    final advertiserIdController = ref.watch(
        getAdvertiserByUserIdRepositoryFutureProvider(userId.toString()));
    return Scaffold(
      appBar: const MenuAppBar(
        title: "Create Ad",
      ),
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
          child: advertiserIdController.when(
        data: (data) {
          final advertiserId = data.data?.id ?? '';
          ref.read(advertiserIdStateProvider.notifier).state = advertiserId;
          return Column(
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
                  Tab(
                    child: FittedBox(
                      child: Text(
                        'SURVEY',
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      child: Text(
                        'MOBILE AD',
                      ),
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
                    ImageAdTabBiew(),
                    VideoAdsTabView(),
                    SurveyTabView(),
                    MobileAdsTabView(),
                  ],
                ),
              )
            ],
          ).padHorizontal(16);
        },
        loading: () {
          return const SizedBox(
            height: 900,
            child: Column(
              children: [
                SizedBox(height: 300),
                SpinKitSpinningLines(
                  color: AppColors.w5Color,
                ),
                SizedBox(height: 400),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
      )),
    );
  }
}
