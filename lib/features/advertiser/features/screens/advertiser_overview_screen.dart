// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_details_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/ads_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/draft_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/screens/portfolio_account_screen.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/ads_metric_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../widgets/recent_ads_tile.dart';

class AdvertiserOverviewScreen extends StatefulWidget {
  const AdvertiserOverviewScreen({Key? key}) : super(key: key);

  @override
  _AdvertiserOverviewScreenState createState() =>
      _AdvertiserOverviewScreenState();
}

class _AdvertiserOverviewScreenState extends State<AdvertiserOverviewScreen> {
  final List<String> _timeFrames = ['Daily', 'Weekly', 'Monthly'];
  String _selectedTimeFrame = 'Weekly';
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      int index =
          (_scrollController.position.pixels / 196.w).round().clamp(0, 5);
      setState(() {
        _currentIndex = index;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBar(
        title: "Advertise",
      ),
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overview',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PortfolioAccountScreen();
                    }));
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.roundProfile),
                      6.wi,
                      Text(
                        'Login with a different\nportfolio account',
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.w5Color,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
              ],
            ).padHorizontal(16),
            20.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter by:',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackText,
                  ),
                ),
                SizedBox(
                  width: 92.w,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      icon: SvgPicture.asset(
                        AppIcons.arrowDown,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: AppColors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0.h,
                          horizontal: 10.w,
                        ),
                      ),
                      value: _selectedTimeFrame,
                      items: _timeFrames.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.blackText,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppTheme.montserratAlternate),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedTimeFrame = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ).padHorizontal(16),
            25.hi,
            Column(
              children: [
                SizedBox(
                  height: 100.h,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 16.0),
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    children: [
                      AdsMetricCard(
                        label: 'Reach',
                        points: '7265',
                        percent: '+11.02%',
                      ),
                      16.wi,
                      AdsMetricCard(
                        label: 'Visits',
                        points: '7265',
                        percent: '-11.02%',
                        isPositive: false,
                        bgColor: AppColors.lightPurple,
                      ),
                      16.wi,
                      AdsMetricCard(
                        label: 'Impressions',
                        points: '7265',
                        percent: '-11.02%',
                      ),
                      16.wi,
                      AdsMetricCard(
                        label: 'Clicks',
                        points: '7265',
                        percent: '+11.02%',
                        bgColor: AppColors.lightPurple,
                      ),
                      16.wi,
                      AdsMetricCard(
                        label: 'Views',
                        points: '7265',
                        percent: '+11.02%',
                      ),
                    ],
                  ),
                ),
                10.hi,
                DotsIndicator(
                  dotsCount: 5,
                  position: _currentIndex,
                  decorator: DotsDecorator(
                    activeColor: AppColors.w5Color,
                    size: const Size.square(8.0),
                    activeSize: const Size.square(8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ],
            ),
            10.hi,
            AppElevatedButton(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DraftScreen();
                }));
              },
              bgColor: AppColors.white,
              isFilled: true,
              label: "Drafts",
              labelStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  color: AppColors.lighterText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ).padHorizontal(16),
            32.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Ads',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AdsScreen();
                    }));
                  },
                  child: Text(
                    'See all',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        color: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                ),
              ],
            ).padHorizontal(16),
            8.hi,
            SizedBox(
              height: .5.sh,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: RecentAdsTile(
                        label: 'Sparkle & Signss',
                        startDate: 'Feb 24',
                        endDate: 'Feb 24',
                        status: 'Active',
                        statusTextColor: AppColors.deepGreen,
                        statusBgColor: AppColors.greenShade50.withOpacity(0.5),
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
                    return const AppDivider().padHorizontal(16);
                  },
                  itemCount: 4),
            )
          ],
        ),
      ),
    );
  }
}
