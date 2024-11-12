import 'package:dealer_portal_mobile/features/advertiser/features/widgets/reward_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

Future<void> rewardAlertDialog({
  required BuildContext context,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SizedBox(
            height: .5.sh,
            child: const SingleChildScrollView(
              child: RewardTile(),
            ),
          ),
        );
      });
}
