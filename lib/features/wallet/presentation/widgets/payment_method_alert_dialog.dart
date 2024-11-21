import 'package:dealer_portal_mobile/features/wallet/presentation/widgets/payment_method_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

Future<void> paymentMethodAlertDialog({
  required BuildContext context,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteShade80,
          content: SizedBox(
            height: .6.sh,
            child: const SingleChildScrollView(
              child: PaymentMethodTile(),
            ),
          ),
        );
      });
}
