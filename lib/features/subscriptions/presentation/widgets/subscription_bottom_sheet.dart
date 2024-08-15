import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_table_header.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/data_hour_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../screens/invoice_screen.dart';

Future<dynamic> subsriptionBottomSheet({
  required BuildContext context,
  WidgetRef? ref,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: SizedBox(
            height: .7.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Text(
                    'Selected data hours',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(),
                  ),
                  18.hi,
                  const CustomTableHeader(),
                  SizedBox(
                    height: .3.sh,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return const DataHourTile();
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: AppColors.dividerColor,
                          );
                        },
                        itemCount: 4),
                  ),
                  8.hi,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                      Text(
                        '₦40,000,000',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  14.hi,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AppElevatedButton(
                      label: 'Generate Invoice',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InvoiceScreen();
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
