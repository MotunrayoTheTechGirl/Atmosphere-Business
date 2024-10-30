import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../screens/confirm_order_screen.dart';

Future<void> authorizeOrderAlertDialog({
  required BuildContext context,
  required num amount,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteShade80,
          content: SizedBox(
            height: .5.sh,
            child: SingleChildScrollView(
              child: ConfirmOrderScreen(
                amount: amount,
              ),
            ),
          ),
        );
      });
}
