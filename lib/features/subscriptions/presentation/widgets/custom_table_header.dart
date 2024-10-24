import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/table_header.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomTableHeader extends StatelessWidget {
  const CustomTableHeader({
    this.forInvoice = false,
    super.key,
  });

  final bool forInvoice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.greyShade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        border: Border(
          bottom: BorderSide(
            width: 0.7,
            color: AppColors.dividerColor,
          ),
        ),
      ),
      child: forInvoice
          ? const Padding(
              padding: EdgeInsets.only(left: 2),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TableHeader(heading: 'Top up'),
                    ),
                  ),
                  // 160.wi,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TableHeader(heading: 'Amount'),
                    ),
                  ),
                ],
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TableHeader(
                  heading: 'Select',
                ),
                TableHeader(
                  heading: 'Plan',
                ),
                TableHeader(
                  heading: 'Quantity',
                ),
                TableHeader(
                  heading: 'Amount',
                ),
              ],
            ),
    );
  }
}
