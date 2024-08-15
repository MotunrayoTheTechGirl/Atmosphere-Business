import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/status_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_table_header.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/invoice_breakdown_tile.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/invoice_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/custom_alert_dialog.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: AppColors.whiteShade80,
                borderRadius: BorderRadius.all(
                  Radius.circular(14.4),
                ),
              ),
              child: SvgPicture.asset(AppIcons.cancel),
            ).padRight(16),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.invoice),
                    8.wi,
                    Text(
                      'Invoice',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp,
                        color: AppColors.blackText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                20.hi,
                RichText(
                  text: TextSpan(
                      text: 'INV-10022004-001',
                      style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontSize: 21,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppTheme.montserratAlternate,
                      ),
                      children: [
                        TextSpan(
                          text: ' for ₦40,000,000',
                          style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontFamily: AppTheme.montserratAlternate,
                          ),
                        ),
                      ]),
                ),
                10.hi,
                const PaymentStatus(
                  label: 'Unpaid',
                  color: AppColors.red,
                ),
                40.hi,
                Row(
                  children: [
                    SizedBox(
                      width: 202.w,
                      child: AppElevatedButton(
                        borderRadius: 8,
                        labelFontSize: 14.sp,
                        label: 'Submit Bank Receipt',
                        onTap: () {
                          customAlertDialog(context: context);
                        },
                      ),
                    ),
                    10.wi,
                    AppElevatedButton(
                      borderRadius: 8,
                      rowIcon: AppIcons.share,
                      width: 112.w,
                      rowLabel: 'share',
                      onTap: () {},
                      isLightBlue: true,
                    ),
                  ],
                ),
                10.hi,
                Row(
                  children: [
                    AppElevatedButton(
                      borderRadius: 8,
                      rowIcon: AppIcons.download,
                      width: 149.w,
                      rowLabel: 'Download',
                      onTap: () {},
                      isLightBlue: true,
                    ),
                    10.wi,
                    AppElevatedButton(
                      borderRadius: 8,
                      rowIcon: AppIcons.print,
                      width: 125.w,
                      rowLabel: 'Print',
                      onTap: () {},
                      isLightBlue: true,
                    ),
                  ],
                ),
                18.hi,
                const AppDivider(),
                18.hi,
                Column(
                  children: [
                    Text(
                      'SUMMARY',
                      style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                        color: AppColors.deepAsh,
                      ),
                    ),
                  ],
                ),
                26.hi,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InvoiceSummary(
                          leading: 'Invoice ID:',
                          trailing: ' INV-10022004-001',
                        ),
                        14.hi,
                        const InvoiceSummary(
                          leading: 'Name:',
                          trailing: ' Oge Ege',
                        ),
                        14.hi,
                        const InvoiceSummary(
                          leading: 'Email:',
                          trailing: ' aogejogn@gmail.com',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InvoiceSummary(
                          leading: 'Currency:',
                          trailing: ' Naira',
                        ),
                        14.hi,
                        const InvoiceSummary(
                          leading: 'Time:',
                          trailing: ' 10:00 PM',
                        ),
                        14.hi,
                        const InvoiceSummary(
                          leading: 'Date:',
                          trailing: ' Feb 12, 2023',
                        ),
                      ],
                    ),
                  ],
                ),
                18.hi,
                const AppDivider(),
                18.hi,
                Text(
                  'BREAKDOWN',
                  style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                    color: AppColors.deepAsh,
                  ),
                ),
              ],
            ).padHorizontal(16),
            20.hi,
            const CustomTableHeader(
              forInvoice: true,
            ),
            SizedBox(
              height: .3.sh,
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                    child: InvoiceBreakDownTile(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const AppDivider();
                },
              ),
            ),
            28.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub total:',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                  ),
                ),
                Text(
                  '₦40,000,000',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                  ),
                ),
              ],
            ).padHorizontal(12),
            22.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax (7.5%)',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                  ),
                ),
                Text(
                  '₦2,000',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                  ),
                ),
              ],
            ).padHorizontal(12),
            22.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '₦40,002,000',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    color: AppColors.deepAsh,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ).padHorizontal(12),
            20.hi,
          ],
        )),
      ),
    );
  }
}
