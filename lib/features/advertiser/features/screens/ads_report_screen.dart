import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_details_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/advertiser_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../../wallet/presentation/widgets/fund_wallet_button.dart';
import '../../../wallet/presentation/widgets/wallet_balance_card.dart';
import '../../data/controller/get_adverts_controller.dart';
import '../../data/models/get_adverts_res_model.dart';
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
      ref.read(getAdvertsControllerProvider.notifier).fetchAdverts();
    });

    super.initState();
  }

  String formatDate(DateTime date) {
    final createdDate = date;
    String formattedDate =
        DateFormat('MMM dd').format(createdDate ?? DateTime.now());
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final advertsController = ref.watch(getAdvertsControllerProvider);
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
              ref.read(getAdvertsControllerProvider.notifier).fetchAdverts();
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
                    // 10.hi,
                    // AppTextField(
                    //   contentPadding: const EdgeInsets.symmetric(
                    //     vertical: 2,
                    //     horizontal: 8,
                    //   ),
                    //   radius: 16.r,
                    //   fillColor: AppColors.tabBarColor,
                    //   controller: searchController,
                    //   hintText: 'Search Ads',
                    //   border: InputBorder.none,
                    //   hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 16.sp,
                    //     color: AppColors.textColor,
                    //   ),
                    //   style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 14.sp,
                    //     color: AppColors.textColor,
                    //   ),
                    //   suffixIcon: SvgPicture.asset(
                    //     AppIcons.search,
                    //     fit: BoxFit.scaleDown,
                    //     height: 20,
                    //     width: 20,
                    //   ),
                    // ),
                    8.hi,
                    SizedBox(
                      height: .5.sh,
                      child: RefreshIndicator.adaptive(
                        onRefresh: () async {
                          ref
                              .read(getAdvertsControllerProvider.notifier)
                              .fetchAdverts();
                        },
                        child: advertsController.when(data: (data) {
                          final List<GetAdsByAdvertiserIdResModel> ads = [];
                          for (var advertsType in data) {
                            if (advertsType.status != 'drafts') {
                              ads.add(advertsType);
                            }
                          }

                          return ads.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) {
                                    final advert = ads[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: RecentAdsTile(
                                        label: advert.title ?? '',
                                        startDate: formatDate(
                                            advert.startDate ?? DateTime.now()),
                                        endDate: formatDate(
                                            advert.endDate ?? DateTime.now()),
                                        status: () {
                                          switch (advert.status) {
                                            case "pending":
                                              return 'InActive';
                                            case "approved":
                                              return 'Active';
                                            case "active":
                                              return "Active";
                                            case "paused":
                                              return "Paused";
                                            case "completed":
                                              return "Completed";
                                            default:
                                              return 'InActive';
                                          }
                                        }(),
                                        statusTextColor: () {
                                          switch (advert.status) {
                                            case "pending":
                                              return AppColors.goldenYellow;
                                            case "active":
                                              return AppColors.deepGreen;
                                            case "approved":
                                              return AppColors.deepGreen;
                                            case "completed":
                                              return AppColors.primaryColor;
                                            default:
                                              return AppColors.goldenYellow;
                                          }
                                        }(),
                                        statusBgColor: () {
                                          switch (advert.status) {
                                            case "pending":
                                              return AppColors.lightOrange;
                                            case "paused":
                                              return AppColors.lightOrange;
                                            case "active":
                                              return AppColors.greenShade50
                                                  .withOpacity(0.5);
                                            case "approved":
                                              return AppColors.greenShade50
                                                  .withOpacity(0.5);
                                            case "completed":
                                              return AppColors.babyShade100;
                                            default:
                                              return AppColors.lightOrange;
                                          }
                                        }(),
                                        onTap: () {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            ref
                                                .read(
                                                    titleStateProvider.notifier)
                                                .state = advert.title ?? '';
                                            ref
                                                    .read(
                                                        descriptionStateProvider
                                                            .notifier)
                                                    .state =
                                                advert.description ?? '';
                                            ref
                                                .read(statusStateProvider
                                                    .notifier)
                                                .state = advert.status ?? '';
                                            ref
                                                    .read(startDateStateProvider
                                                        .notifier)
                                                    .state =
                                                advert.startDate.toString();
                                            ref
                                                .read(endStateProvider.notifier)
                                                .state = advert.endDate.toString();
                                            ref
                                                    .read(durationStateProvider
                                                        .notifier)
                                                    .state =
                                                advert.duration.toString();
                                            ref
                                                .read(targetStateProvider
                                                    .notifier)
                                                .state = advert.targetUrl ?? '';
                                            ref
                                                    .read(budgetStateProvider
                                                        .notifier)
                                                    .state =
                                                advert.budget.toString();
                                            ref
                                                .read(calltoActionStateProvider
                                                    .notifier)
                                                .state = advert
                                                    .callToActionText ??
                                                '';
                                            ref
                                                .read(amountSpentStateProvider
                                                    .notifier)
                                                .state = advert.amountSpent;
                                            ref
                                                    .read(
                                                        dateCreatedStateProvider
                                                            .notifier)
                                                    .state =
                                                advert.dateCreated.toString();
                                            ref
                                                    .read(
                                                        contentUrlStateProvider
                                                            .notifier)
                                                    .state =
                                                advert.displayContentUrl ?? '';
                                            ref
                                                .read(
                                                    typeStateProvider.notifier)
                                                .state = advert.type ?? '';
                                            ref
                                                .read(
                                                    sizeStateProvider.notifier)
                                                .state = advert.size ?? '';
                                            ref
                                                .read(screenStateProvider
                                                    .notifier)
                                                .state = advert.screens ?? '';
                                            ref
                                                    .read(deviceStateProvider
                                                        .notifier)
                                                    .state =
                                                advert.deviceType ?? '';
                                            ref
                                                .read(
                                                    businessCategoryStateProvider
                                                        .notifier)
                                                .state = advert.category ?? '';
                                            ref
                                                .read(advertIdStateProvider
                                                    .notifier)
                                                .state = advert.id.toString();
                                            ref
                                                .read(AdRegionStateProvider
                                                    .notifier)
                                                .state = advert.regionIds;
                                          });
                                          log('---Dure: ${advert.duration}');
                                          log('budge: ${advert.budget.runtimeType}');
                                          log('budget state: ${ref.watch(budgetStateProvider)}');
                                          log('---Dure state : ${ref.watch(durationStateProvider)}');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return const AdsDetailsScreen();
                                            }),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const AppDivider().padHorizontal(16);
                                  },
                                  itemCount: ads.length)
                              : const Text('Empty!!');
                        }, error: (error, str) {
                          return const Text('Oops! somting went wrong');
                        }, loading: () {
                          return const Center(
                            child: SpinKitSpinningLines(
                              color: AppColors.w5Color,
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ).padHorizontal(20)),
              ],
            ),
          ),
        ));
  }
}
