import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/home/presentation/widgets/usage_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/custom_drawer.dart';
import '../../../../core/utils/app_icons.dart';
import '../widgets/available_data_balnce_card.dart';
import '../widgets/drop_down_form_field.dart';
import '../widgets/overview_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(
              AppIcons.menu,
              fit: BoxFit.scaleDown,
            ),
          ).padOnly(left: 12);
        }),
        title: Text(
          'Overview',
          style: AppTheme.lightTextTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blackText,
          ),
        ),
        actions: [
          SvgPicture.asset(AppIcons.notification).padOnly(right: 20),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              30.hi,
              SizedBox(
                height: 200.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const AvailableDataBalanceCard().padOnly(right: 16),
                    const UsageCard(),
                  ],
                ),
              ).padOnly(left: 20),
              6.hi,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // ref
                      //     .read(generateReferenceControllerProvider.notifier)
                      //     .generateReference();
                    },
                    child: Text(
                      'Filter by:',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackText,
                      ),
                    ),
                  ),
                  SizedBox(width: 92.w, child: const DropDownFormField()),
                ],
              ).padHorizontal(20),
              10.hi,
              SizedBox(
                height: .5.sh,
                child: ListView(
                  children: [
                    const OverviewCard(
                      title: 'Total Orders',
                      amount: '3465',
                      suffixNumber: '+234 ',
                      icon: AppIcons.greenGraph,
                      suffixColor: AppColors.green,
                    ),
                    16.hi,
                    const OverviewCard(
                      title: 'Total Revenue',
                      amount: '₦190,000,000',
                      suffixNumber: '-134 ',
                      icon: AppIcons.redGraph,
                      suffixColor: AppColors.red,
                    ),
                    16.hi,
                    const OverviewCard(
                      title: 'Total Data Plan Created ',
                      amount: '10',
                      showWidget: false,
                    ),
                    16.hi,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
