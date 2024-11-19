import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../../wallet/presentation/widgets/fund_wallet_button.dart';
import '../../../wallet/presentation/widgets/wallet_balance_card.dart';
import '../widgets/recent_ads_tile.dart';

class AdsReportScreen extends ConsumerStatefulWidget {
  const AdsReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdsReportScreen> createState() => _AdsReportScreenState();
}

class _AdsReportScreenState extends ConsumerState<AdsReportScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
        appBar: const MenuAppBar(
          title: "Ad Reports",
        ),
        drawer: const CustomDrawer(),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              await ref
                  .read(fetchUserBalanceControllerProvider.notifier)
                  .userBalance();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    10.hi,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Wallet Overview',
                        style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                          fontSize: 15.sp,
                          color: AppColors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    8.hi,
                    const WalletBalanceCard(),
                    32.hi,
                    const FundWalletButton(),
                    10.hi,
                    Divider(
                      thickness: 0.2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    10.hi,
                    AppTextField(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      radius: 16.r,
                      fillColor: AppColors.tabBarColor,
                      controller: searchController,
                      hintText: 'Search Ads',
                      border: InputBorder.none,
                      hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.textColor,
                      ),
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.textColor,
                      ),
                      suffixIcon: SvgPicture.asset(
                        AppIcons.search,
                        fit: BoxFit.scaleDown,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    8.hi,
                    SizedBox(
                      height: .5.sh,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: RecentAdsTile(
                                label: 'Sparkle & Signss',
                                startDate: 'Feb 24',
                                endDate: 'Feb 24',
                                status: 'Active',
                                statusTextColor: AppColors.deepGreen,
                                statusBgColor:
                                    AppColors.greenShade50.withOpacity(0.5),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return const AdsDetailsScreen();
                                    }),
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const AppDivider();
                          },
                          itemCount: 4),
                    )
                  ],
                ).padHorizontal(20)),
              ],
            ),
          ),
        ));
  }
}
