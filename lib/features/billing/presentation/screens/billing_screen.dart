import 'package:dealer_portal_mobile/core/common_widgets/app_divider.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/billing/presentation/widgets/billing_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/primary_appbar.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../data/repository/billing_repository.dart';

class BillingScreen extends ConsumerWidget {
  BillingScreen({Key? key}) : super(key: key);
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceController = ref.watch(billingRepositoryFutureProvider);
    final firstName =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.firstName ??
            '';
    final lastName =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.lastName ??
            '';
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
              invoiceController.when(
                data: (data) {
                  return SizedBox(
                    height: .6.sh,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final invoice = data[index];
                        String duration = invoice.createdAt.toString();
                        DateTime dateTime = DateTime.parse(duration);
                        String formattedDate = DateFormat('hh:mm a, dd MMM')
                            .format(dateTime.toLocal());
                        return BillingTile(
                          onTap: () {},
                          duration: formattedDate,
                          id: 'INV-${invoice.id}',
                          price: formatNaira(
                            invoice.amount ?? '',
                          ),
                          dataPlan: 'Data Plan',
                          name: '$firstName $lastName',
                          status: invoice.paymentStatus ?? '',
                          statusColorBg: invoice.paymentStatus == 'pending'
                              ? AppColors.redShade50
                              : AppColors.greenShade50,
                          statusColor: invoice.paymentStatus == 'pending'
                              ? AppColors.red
                              : AppColors.green,
                        );
                      },
                      itemCount: data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const AppDivider();
                      },
                    ),
                  );
                },
                error: (e, str) {
                  return const Text('Oops! something went wrong');
                },
                loading: () {
                  return const Center(
                    child: SpinKitSpinningLines(
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ).padHorizontal(16),
        ),
      ),
    );
  }
}
