import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/data_pack_screen.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/subs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.hi,
            Text(
              'Subscription',
              style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                fontSize: 26.sp,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppTheme.montserratAlternate,
              ),
            ),
            8.hi,
            Text(
              'Purchase data hours with pre-defined buy plan or custom plan amount',
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.lighterText,
              ),
            ),
            40.hi,
            SubsCard(
              title: 'Choose a Data Pack',
              subTitle:
                  'Pick from our ready-made data hour packs,\nlike 100 hours for 100 Naira. Click below to see\nall options.',
              buttonLabel: 'Buy data pack',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DataPackScreen();
                    },
                  ),
                );
              },
            ),
            // 20.hi,
            // SubsCard(
            //   title: 'Customize Your Hours',
            //   subTitle:
            //       'Enter the hours you need, and we\'ll\ncalculate the price. For example, 150 hours for 150\nNaira.',
            //   buttonLabel: 'Buy custom volume',
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return const CustomizeHoursScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ).padHorizontal(
          16,
        )),
      ),
    );
  }
}
