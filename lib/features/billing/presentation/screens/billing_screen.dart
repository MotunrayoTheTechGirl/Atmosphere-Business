import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/billing/presentation/widgets/billing_tile.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/primary_appbar.dart';

class BillingScreen extends StatelessWidget {
  BillingScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: 'Billing',
        icon: AppIcons.filter,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                hintText: 'Search invoices',
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
                height: .6.sh,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return BillingTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const InvoiceScreen();
                          }),
                        );
                      },
                    );
                  },
                  itemCount: 4,
                  separatorBuilder: (BuildContext context, int index) {
                    return const AppDivider();
                  },
                ),
              ),
            ],
          ).padHorizontal(16),
        ),
      ),
    );
  }
}
