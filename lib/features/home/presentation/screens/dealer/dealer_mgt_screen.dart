import 'package:dealer_portal_mobile/core/common_widgets/app_bars/menu_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/home/presentation/screens/dealer/invite_dealer_screen.dart';
import 'package:dealer_portal_mobile/features/home/presentation/widgets/dealer_mgt_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/common_widgets/app_text_field.dart';

class DealerMgtScreen extends StatelessWidget {
  DealerMgtScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return InviteDealerScreen();
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          width: 180.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
            color: AppColors.primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.customer),
              8.wi,
              Text(
                'Invite dealer',
                style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.buttonBg,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).padOnly(right: 10),
      ),
      appBar: const MenuAppBar(title: 'Dealer management'),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hi,
            AppTextField(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              radius: 16.r,
              fillColor: AppColors.tabBarColor,
              controller: searchController,
              hintText: 'Search ID or Name',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
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
            20.hi,
            SizedBox(
              height: .9.sh,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return const DealerMgtTile().padSymmetric(
                      vertical: 6,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const AppDivider();
                  },
                  itemCount: 8),
            )
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
