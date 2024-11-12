import 'package:dealer_portal_mobile/core/common_widgets/app_bars/menu_appbar.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../billing/data/repository/billing_repository.dart';
import '../../../billing/presentation/widgets/billing_tile.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../widgets/fundwallet_tile.dart';

class InvoiceHistoryScreen extends ConsumerWidget {
  InvoiceHistoryScreen({Key? key}) : super(key: key);
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
      appBar: const MenuAppBar(title: "Invoice"),
      drawer: const CustomDrawer(),
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
                hintText: 'Search History',
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
                    height: .8.sh,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final dataList = data.reversed.toList();
                        // final invoice = data[index];
                        final invoice = dataList[index];
                        String duration = invoice.createdAt.toString();
                        DateTime dateTime = DateTime.parse(duration);
                        String formattedDate =
                            DateFormat('hh:mm a, dd MMM, yyyy')
                                .format(dateTime.toLocal());
                        return BillingTile(
                          onTap: () {
                            ref.read(orderIdStateProvider.notifier).state =
                                invoice.orderId ?? 0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const InvoiceScreen(
                                  viewUploadedReceipt: true,
                                );
                              }),
                            );
                          },
                          duration: formattedDate,
                          id: 'INV-${invoice.id}',
                          price: formatNaira(
                            invoice.amount ?? '',
                          ),
                          name: '$firstName $lastName',
                          status: invoice.paymentStatus == 'pending'
                              ? 'Unpaid'
                              : 'Paid',
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
