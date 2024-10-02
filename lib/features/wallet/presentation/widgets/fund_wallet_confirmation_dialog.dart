import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

Future<void> fundWalletconfirmationDialog({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: AlertDialog(
          alignment: Alignment.bottomCenter,
          backgroundColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                16.r,
              ),
            ),
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.r,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  80.hi,
                  SvgPicture.asset(AppIcons.cancel),
                  20.hi,
                  Text(
                    'Fund Wallet',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  30.hi,
                  AppElevatedButton(
                    width: 120.w,
                    onTap: () {},
                    isLightBlue: true,
                    rowLabel: 'Delete',
                    rowLabelstyle:
                        AppTheme.lightTextTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.lightBlue,
                    ),
                    rowIcon: AppIcons.delete,
                    rowIconWidth: 16.w,
                    rowIconHeight: 18.h,
                  ),
                ],
              ),
            );
          }),
        ),
      );
    },
  );
}
