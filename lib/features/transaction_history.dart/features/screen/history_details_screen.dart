import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/common_widgets/status_button.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/presentation/widgets/invoice_summary.dart';

class HistoryDetailsScreen extends ConsumerWidget {
  const HistoryDetailsScreen(
      {required this.transactionId,
      required this.transactionType,
      required this.date,
      required this.amount,
      required this.description,
      required this.time,
      Key? key})
      : super(key: key);

  final String transactionId, description, transactionType, date, time, amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Details',
        backgroundColor: AppColors.white,
        icon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.leftArrow,
            width: 16.w,
            height: 8.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            20.hi,
            Row(
              children: [
                SizedBox(
                  width: 150.w,
                  child: AppElevatedButton(
                    width: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    borderRadius: 8,
                    labelFontSize: 14.sp,
                    label: 'View Receipt',
                    onTap: () {},
                  ),
                ),
                10.wi,
                SizedBox(
                  width: 150.w,
                  child: AppElevatedButton(
                    borderRadius: 8,
                    rowIcon: AppIcons.share,
                    width: 0,
                    rowLabel: 'share',
                    onTap: () {},
                    isLightShade: true,
                  ),
                ),
              ],
            ),
            28.hi,
            InvoiceSummary(
              leading: 'Transaction ID:  ',
              trailing: transactionId,
            ),
            14.hi,
            InvoiceSummary(
              leading: 'Description:  ',
              trailing: description,
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Amount:  ',
              trailing: amount,
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Date:  ',
              trailing: date,
            ),
            18.hi,
            InvoiceSummary(
              leading: 'Time:  ',
              trailing: time,
            ),
            18.hi,
            Row(
              children: [
                const InvoiceSummary(
                  leading: 'Status:  ',
                  trailing: '',
                ),
                PaymentStatus(
                  label: transactionType,
                  color: AppColors.greenShade900,
                  bgColor: AppColors.greenShade50,
                )
              ],
            ),
          ]).padHorizontal(16),
        ),
      ),
    );
  }
}
