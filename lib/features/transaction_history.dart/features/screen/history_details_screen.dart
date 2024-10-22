import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/common_widgets/status_button.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/presentation/widgets/invoice_summary.dart';

class HistoryDetailsScreen extends ConsumerWidget {
  const HistoryDetailsScreen(
      {required this.orderId,
      required this.price,
      required this.validity,
      required this.dateTime,
      required this.amount,
      // required this.status,
      Key? key})
      : super(key: key);

  final String orderId, price, validity, dateTime, amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Transaction Details',
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            20.hi,
            Row(
              children: [
                SizedBox(
                  width: 136.w,
                  child: AppElevatedButton(
                    borderRadius: 8,
                    labelFontSize: 14.sp,
                    label: 'View Receipt',
                    onTap: () {},
                  ),
                ),
                10.wi,
                AppElevatedButton(
                  borderRadius: 8,
                  rowIcon: AppIcons.share,
                  width: 112.w,
                  rowLabel: 'share',
                  onTap: () {},
                  isLightShade: true,
                ),
              ],
            ),
            28.hi,
            InvoiceSummary(
              leading: 'Order ID:  ',
              trailing: orderId,
            ),
            14.hi,
            InvoiceSummary(
              leading: 'Phone Number:  ',
              trailing: userDetailsController?.phoneNumber ?? '',
            ),
            18.hi,
            const InvoiceSummary(
              leading: 'Data Plan:  ',
              trailing: 'Data Plan',
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Amount:  ',
              trailing: validity,
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Date / Time:  ',
              trailing: dateTime,
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Validity:  ',
              trailing: validity,
            ),
            18.hi,
            const Row(
              children: [
                InvoiceSummary(
                  leading: 'Status:  ',
                  trailing: '',
                ),
                PaymentStatus(
                  label: 'Used',
                  color: AppColors.green,
                  bgColor: AppColors.greyShade50,
                )
              ],
            ),
          ]).padHorizontal(16),
        ),
      ),
    );
  }
}
