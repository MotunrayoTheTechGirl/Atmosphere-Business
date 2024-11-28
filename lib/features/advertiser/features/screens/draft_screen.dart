import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/create_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../data/models/get_adverts_res_model.dart';
import '../../data/repository/get_adverts_repository.dart';
import '../widgets/ads_card.dart';

class DraftScreen extends ConsumerStatefulWidget {
  const DraftScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends ConsumerState<DraftScreen> {
  @override
  Widget build(BuildContext context) {
    final advertsController = ref.watch(
        getAdvertsByAdvertiserRepositoryFutureProvider(
            ref.watch(advertiserIdStateProvider)));

    final searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Drafts',
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
          AppTextField(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 8,
            ),
            radius: 16.r,
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
            height: .8.sh,
            child: advertsController.when(data: (data) {
              final List<GetAdsByAdvertiserIdResModel> ads = [];
              for (var advertsType in data) {
                if (advertsType.status == 'drafts') {
                  ads.add(advertsType);
                }
              }

              return GridView.builder(
                  itemCount: ads.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.h,
                      mainAxisSpacing: 16.w),
                  itemBuilder: (context, index) {
                    final draft = ads[index];

                    log('date created: ${draft.dateCreated}');
                    String draftDateOverviewFormat(String? date) {
                      DateTime? parsedEndDate =
                          date == null ? null : DateTime.tryParse(date);

                      final String formattedDate = parsedEndDate == null
                          ? ''
                          : DateFormat("dd/MM/yy").format(parsedEndDate);
                      return formattedDate;
                    }

                    log('draft date overview: ${draftDateOverviewFormat(draft.dateCreated.toString())}');

                    return AdsCard(
                      onTap: () {},
                      adsType: draft.type ?? '',
                      adsTitile: draft.title ?? '',
                      date: draftDateOverviewFormat(
                        draft.dateCreated.toString(),
                      ),
                      status: draft.type ?? '',
                      showPoint: false,
                      statusBgColor: AppColors.skyeBlue.withOpacity(0.1),
                      statusTextColor: AppColors.babyblue,
                    );
                  });
            }, error: (error, str) {
              return const Center(
                child: Text('Oops! something went wrong'),
              );
            }, loading: () {
              return const Center(
                child: SpinKitSpinningLines(
                  color: AppColors.w5Color,
                ),
              );
            }),
          ),
        ],
      ).padHorizontal(24)),
    );
  }
}
