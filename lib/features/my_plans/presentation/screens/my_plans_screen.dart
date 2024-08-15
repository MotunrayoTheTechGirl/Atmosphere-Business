import 'package:dealer_portal_mobile/core/common_widgets/app_bars/primary_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/home/presentation/widgets/available_data_balnce_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/data_plan_container.dart';

class MyPlansScreen extends StatelessWidget {
  const MyPlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const PrimaryAppBar(title: 'Data Plans', icon: AppIcons.notification),
      // appBar: AppBar(
      //   toolbarHeight: 100.0.h,
      //   centerTitle: false,
      //   title: Text(
      //     'Data Plans',
      //     style: AppTheme.lightTextTheme.titleLarge?.copyWith(
      //       fontSize: 26.sp,
      //       color: AppColors.textColor,
      //       fontWeight: FontWeight.w600,
      //       fontFamily: AppTheme.montserratAlternate,
      //     ),
      //   ),
      //   actions: [
      //     SvgPicture.asset(AppIcons.notification).padOnly(right: 20),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AvailableDataBalanceCard(
              width: double.infinity,
            ),
            30.hi,
            AppElevatedButton(
              onTap: () {},
              isLightBlue: true,
              rowIcon: AppIcons.plusBox,
              rowLabel: 'Create Data Plan',
              rowLabelColor: AppColors.primaryColor,
            ).padHorizontal(14),
            20.hi,
            Text(
              'My plans',
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.lighterText,
                fontWeight: FontWeight.w400,
              ),
            ),
            30.hi,
            SizedBox(
              height: .3.sh,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const DataPlanContainer().padBottom(10);
                },
              ),
            ),
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
