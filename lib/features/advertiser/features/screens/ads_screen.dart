import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/ads_card.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/ads_summation_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../data/repository/get_adverts_repository.dart';

class AdsScreen extends ConsumerWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advertsController =
        ref.watch(getAdvertsByAdvertiserRepositoryFutureProvider(''));
    final searchController = TextEditingController();
    return Scaffold(
      appBar: const MenuAppBar(
        title: "Ads",
      ),
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            25.hi,
            const AdsSummationBox(),
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
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.h,
                    mainAxisSpacing: 16.w,
                    // childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, child) {
                    return AdsCard(
                      adsType: 'Video Ad',
                      adsTitile: 'My perfect video ad campaign title',
                      date: '09/03/24',
                      status: 'Active',
                      onTap: () {
                        print('tapped');
                      },
                    );
                  }),
            )
          ],
        ).padHorizontal(20),
      ),
    );
  }
}
