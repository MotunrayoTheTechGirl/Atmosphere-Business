import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/subscriptions/presentation/widgets/dotted_container.dart';
import '../utils/app_colors.dart';
import '../utils/themes/app_themes.dart';

Future<void> customAlertDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.bottomCenter,
        backgroundColor: AppColors.white,
        // insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
        ),
        content: Container(
          height: 580.h,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              RichText(
                text: TextSpan(
                  text: 'Upload Bank Teller or Receipt ',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    // fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '*',
                      style: AppTheme.lightTextTheme.bodyLarge
                          ?.copyWith(color: AppColors.red),
                    )
                  ],
                ),
              ),
              30.hi,
              DottedContainer(
                onTap: () {},
              ),
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: AppColors.dividerColor,
              //       width: 2,
              //     ),
              //     borderRadius: const BorderRadius.all(
              //       Radius.circular(18),
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           SvgPicture.asset(
              //             AppIcons.file,
              //             width: 26.w,
              //             height: 30.h,
              //             fit: BoxFit.scaleDown,
              //           ),
              //           10.wi,
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Receipt for INV-10022004-001',
              //                 style: AppTheme.lightTextTheme.displaySmall
              //                     ?.copyWith(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 12.sp,
              //                   color: AppColors.blackShade400,
              //                 ),
              //               ),
              //               8.hi,
              //               Text(
              //                 'JPG | 4.3MB',
              //                 style: AppTheme.lightTextTheme.displaySmall
              //                     ?.copyWith(
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 12.sp,
              //                   color: AppColors.blackShade50,
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //       18.hi,
              //       Divider(
              //         height: 1,
              //         color: AppColors.blackShade50.withOpacity(0.5),
              //       ),
              //       14.hi,
              //       Row(
              //         children: [
              //           AppElevatedButton(
              //             width: 120.w,
              //             onTap: () {},
              //             isLightBlue: true,
              //             rowLabel: 'Swap file',
              //             rowIcon: AppIcons.swap,
              //             rowIconWidth: 16.w,
              //             rowIconHeight: 18.h,
              //             rowLabelstyle:
              //                 AppTheme.lightTextTheme.displaySmall?.copyWith(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 13.sp,
              //               color: AppColors.lightBlue,
              //             ),
              //           ),
              //           4.wi,
              //           AppElevatedButton(
              //             width: 120.w,
              //             onTap: () {},
              //             isLightBlue: true,
              //             rowLabel: 'Delete',
              //             rowLabelstyle:
              //                 AppTheme.lightTextTheme.displaySmall?.copyWith(
              //               fontWeight: FontWeight.w400,
              //               fontSize: 13.sp,
              //               color: AppColors.lightBlue,
              //             ),
              //             rowIcon: AppIcons.delete,
              //             rowIconWidth: 16.w,
              //             rowIconHeight: 18.h,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),

              30.hi,
              AppElevatedButton(
                onTap: () {
                  Navigator.pop(context);
                },
                label: 'Submit',
                isActive: false,
              ),
              20.hi,
              AppElevatedButton(
                onTap: () {
                  Navigator.pop(context);
                },
                isLightBlue: true,
                rowLabel: 'Close',
              ),
            ],
          ),
        ),
      );
    },
  );
}
