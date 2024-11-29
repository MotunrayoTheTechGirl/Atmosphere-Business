import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_details_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/advertiser_overview_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/create_ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/ads_card.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/ads_summation_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../data/models/get_adverts_res_model.dart';
import '../../data/repository/get_adverts_repository.dart';

class AdsScreen extends ConsumerWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertsController = ref.watch(
        getAdvertsByAdvertiserRepositoryFutureProvider(
            ref.watch(advertiserIdStateProvider)));

    final searchController = TextEditingController();
    return Scaffold(
      appBar: const MenuAppBar(
        title: "Ads",
      ),
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: advertsController.when(data: (data) {
          final List<GetAdsByAdvertiserIdResModel> videoAds = [];
          final List<GetAdsByAdvertiserIdResModel> imageAds = [];
          final List<GetAdsByAdvertiserIdResModel> surveys = [];

          for (var advertsType in data) {
            if (advertsType.type == 'video') {
              videoAds.add(advertsType);
            } else if (advertsType.type == 'image') {
              imageAds.add(advertsType);
            } else if (advertsType.type == 'survey') {
              surveys.add(advertsType);
            }
          }

          final List<GetAdsByAdvertiserIdResModel> ads = [];
          for (var advertsType in data) {
            if (advertsType.status != 'drafts') {
              ads.add(advertsType);
            }
          }
          return Column(
            children: [
              25.hi,
              AdsSummationBox(
                totalAds: data.length.toString(),
                videoAds: videoAds.length.toString(),
                imageAds: imageAds.length.toString(),
                survey: surveys.length.toString(),
              ),
              25.hi,
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
                radius: 16.r,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.0.r),
                    borderSide: BorderSide.none),
                fillColor: AppColors.tabBarColor,
                controller: searchController,
                hintText: 'Search Ads',
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
              24.hi,
              SizedBox(
                height: .7.sh,
                child: GridView.builder(
                    itemCount: ads.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.h,
                      mainAxisSpacing: 16.w,
                    ),
                    itemBuilder: (context, index) {
                      final advert = ads[index];
                      final createdDate = advert.startDate;
                      String formattedDate = DateFormat('MM/dd/yy')
                          .format(createdDate ?? DateTime.now());

                      return AdsCard(
                        pointColor: () {
                          switch (advert.type) {
                            case "image":
                              return AppColors.babyblue;
                            case "video":
                              return AppColors.purpleShade700;
                            case "survey":
                              return AppColors.leafGreen;

                            default:
                              return AppColors.purpleShade700;
                          }
                        }(),
                        adsType: () {
                          switch (advert.type) {
                            case "image":
                              return 'Image Ad';
                            case "video":
                              return 'Video Ad';
                            case "survey":
                              return 'Survey';

                            default:
                              return '';
                          }
                        }(),
                        adsTitile: advert.title ?? '',
                        date: formattedDate,
                        status:
                            advert.status == "pending" ? 'InActive' : 'Active',
                        statusBgColor: advert.status == "pending"
                            ? AppColors.lightOrange
                            : AppColors.greenShade150,
                        statusTextColor: advert.status == "pending"
                            ? AppColors.goldenYellow
                            : AppColors.deepGreen,
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            ref.read(titleStateProvider.notifier).state =
                                advert.title ?? '';
                            ref.read(descriptionStateProvider.notifier).state =
                                advert.description ?? '';
                            ref.read(statusStateProvider.notifier).state =
                                advert.status ?? '';
                            ref.read(startDateStateProvider.notifier).state =
                                advert.startDate.toString();
                            ref.read(endStateProvider.notifier).state =
                                advert.endDate.toString();
                            ref.read(durationStateProvider.notifier).state =
                                advert.duration.toString();
                            ref.read(targetStateProvider.notifier).state =
                                advert.targetUrl ?? '';
                            ref.read(budgetStateProvider.notifier).state =
                                advert.budget.toString() ?? '';
                            ref.read(calltoActionStateProvider.notifier).state =
                                advert.callToActionText ?? '';
                            ref.read(amountSpentStateProvider.notifier).state =
                                advert.amountSpent;
                            ref.read(dateCreatedStateProvider.notifier).state =
                                advert.dateCreated.toString();
                            ref.read(contentUrlStateProvider.notifier).state =
                                advert.displayContentUrl ?? '';
                            ref.read(typeStateProvider.notifier).state =
                                advert.type ?? '';
                            ref.read(sizeStateProvider.notifier).state =
                                advert.size ?? '';
                            ref.read(screenStateProvider.notifier).state =
                                advert.screens ?? '';
                            ref.read(deviceStateProvider.notifier).state =
                                advert.deviceType ?? '';
                            ref
                                .read(businessCategoryStateProvider.notifier)
                                .state = advert.category ?? '';
                          });
                          log('durationn: ${advert.duration.toString()}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const AdsDetailsScreen();
                            }),
                          );
                        },
                      );
                    }),
              )
            ],
          ).padHorizontal(20);
        }, loading: () {
          return const Column(
            children: [
              // Spacer(),
              Center(
                child: SpinKitSpinningLines(
                  color: AppColors.w5Color,
                ),
              ),
              // Spacer(),
            ],
          );
        }, error: (error, str) {
          return const Center(
            child: Text('Oops! something went wrong'),
          );
        }),
      ),
    );
  }
}
