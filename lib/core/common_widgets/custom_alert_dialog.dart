// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/custom_snackbar.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/subscriptions/data/controller/file_upload_controller.dart';
import '../../features/subscriptions/data/controller/update_receipt_url_controller.dart';
import '../../features/subscriptions/presentation/widgets/dotted_container.dart';
import '../enums.dart';
import '../utils/app_colors.dart';
import '../utils/app_icons.dart';
import '../utils/themes/app_themes.dart';

// Future<void> customAlertDialog({
//   required BuildContext context,
// }) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       FilePickerResult? result;
//       return AlertDialog(
//         alignment: Alignment.bottomCenter,
//         backgroundColor: AppColors.white,
//         // insetPadding: EdgeInsets.zero,
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(
//             Radius.circular(
//               16.r,
//             ),
//           ),
//         ),
//         content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//           return Container(
//             height: 580.h,
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   16.r,
//                 ),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 80.hi,
//                 RichText(
//                   text: TextSpan(
//                     text: 'Upload Bank Teller or Receipt ',
//                     style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
//                       // fontWeight: FontWeight.w600,
//                       color: AppColors.black,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: '*',
//                         style: AppTheme.lightTextTheme.bodyLarge
//                             ?.copyWith(color: AppColors.red),
//                       )
//                     ],
//                   ),
//                 ),
//                 30.hi,
//                 DottedContainer(
//                   label: 'Tap to upload',
//                   onTap: () async {
//                     result = await FilePicker.platform
//                         .pickFiles(allowMultiple: true);
//                     if (result == null) {
//                       print("No file selected");
//                     } else {
//                       setState(() {});
//                       for (var element in result!.files) {
//                         print('Selected File: ${element.name}');
//                       }
//                     }
//                   },
//                 ),
//                 if (result != null)
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColors.dividerColor,
//                         width: 2,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(18),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                               AppIcons.file,
//                               width: 26.w,
//                               height: 30.h,
//                               fit: BoxFit.scaleDown,
//                             ),
//                             10.wi,
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   // 'Receipt for INV-10022004-001',
//                                   result?.files.first.name ?? '',
//                                   style: AppTheme.lightTextTheme.displaySmall
//                                       ?.copyWith(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12.sp,
//                                     color: AppColors.blackShade400,
//                                   ),
//                                 ),
//                                 8.hi,
//                                 Text(
//                                   // 'JPG | 4.3MB',
//                                   '',
//                                   style: AppTheme.lightTextTheme.displaySmall
//                                       ?.copyWith(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12.sp,
//                                     color: AppColors.blackShade50,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         18.hi,
//                         Divider(
//                           height: 1,
//                           color: AppColors.blackShade50.withOpacity(0.5),
//                         ),
//                         14.hi,
//                         Row(
//                           children: [
//                             AppElevatedButton(
//                               width: 120.w,
//                               onTap: () {},
//                               isLightBlue: true,
//                               rowLabel: 'Swap file',
//                               rowIcon: AppIcons.swap,
//                               rowIconWidth: 16.w,
//                               rowIconHeight: 18.h,
//                               rowLabelstyle: AppTheme
//                                   .lightTextTheme.displaySmall
//                                   ?.copyWith(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 13.sp,
//                                 color: AppColors.lightBlue,
//                               ),
//                             ),
//                             4.wi,
//                             AppElevatedButton(
//                               width: 120.w,
//                               onTap: () {},
//                               isLightBlue: true,
//                               rowLabel: 'Delete',
//                               rowLabelstyle: AppTheme
//                                   .lightTextTheme.displaySmall
//                                   ?.copyWith(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 13.sp,
//                                 color: AppColors.lightBlue,
//                               ),
//                               rowIcon: AppIcons.delete,
//                               rowIconWidth: 16.w,
//                               rowIconHeight: 18.h,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 30.hi,
//                 AppElevatedButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   label: 'Submit',
//                   isActive: false,
//                 ),
//                 20.hi,
//                 AppElevatedButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   isLightBlue: true,
//                   rowLabel: 'Close',
//                 ),
//               ],
//             ),
//           );
//         }),
//       );
//     },
//   );
// }

Future<void> customAlertDialog({
  required BuildContext context,
  required WidgetRef ref,
  required int invoiceId,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      FilePickerResult? result;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: AlertDialog(
          alignment: Alignment.bottomCenter,
          backgroundColor: AppColors.white,
          // contentPadding: const EdgeInsets.symmetric(vertical: 100),
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
              // height: 620.h,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
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
                        color: AppColors.black,
                        fontSize: 13.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '*',
                          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                            color: AppColors.red,
                            fontSize: 13.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  30.hi,
                  if (result != null)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.dividerColor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result?.files.first.name ?? '',
                            style:
                                AppTheme.lightTextTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.blackShade400,
                            ),
                          ),
                          8.hi,
                          Text(
                            '${result?.files.first.extension ?? ''} | ${(result?.files.first.size ?? 0) / 1024}MB',
                            style:
                                AppTheme.lightTextTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.blackShade50,
                            ),
                          ),
                          18.hi,
                          Divider(
                            height: 1,
                            color: AppColors.blackShade50.withOpacity(0.5),
                          ),
                          14.hi,
                          Row(
                            children: [
                              AppElevatedButton(
                                width: 120.w,
                                onTap: () async {
                                  result = await FilePicker.platform
                                      .pickFiles(allowMultiple: true);
                                  if (result == null) {
                                    print("No file selected");
                                  } else {
                                    setState(() {});
                                    for (var element in result!.files) {
                                      print('Selected File: ${element.name}');
                                    }
                                  }
                                },
                                isLightBlue: true,
                                rowLabel: 'Swap file',
                                rowIcon: AppIcons.swap,
                                rowIconWidth: 16.w,
                                rowIconHeight: 18.h,
                                rowLabelstyle: AppTheme
                                    .lightTextTheme.displaySmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: AppColors.lightBlue,
                                ),
                              ),
                              4.wi,
                              AppElevatedButton(
                                width: 120.w,
                                onTap: () {},
                                isLightBlue: true,
                                rowLabel: 'Delete',
                                rowLabelstyle: AppTheme
                                    .lightTextTheme.displaySmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: AppColors.lightBlue,
                                ),
                                rowIcon: AppIcons.delete,
                                rowIconWidth: 16.w,
                                rowIconHeight: 18.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (result == null)
                    DottedContainer(
                      label: 'Tap to upload',
                      onTap: () async {
                        result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);
                        if (result == null) {
                          print("No file selected");
                        } else {
                          setState(() {});
                          for (var element in result!.files) {
                            print('Selected File: ${element.name}');
                          }
                        }
                      },
                    ),
                  30.hi,
                  AppElevatedButton(
                    onTap: () async {
                      if (result != null && result!.files.isNotEmpty) {
                        final file = File(result?.files.first.path ?? '');

                        final hasUploadedFile = await ref
                            .read(receiptFileUploadControllerProvider.notifier)
                            .uploadFile(file: file);
                        log('check first file: ${ref.watch(receiptFileUploadControllerProvider).status == ResponseStatus.loading}');
                        final data =
                            ref.read(fileUploadControllerProvider).data;
                        print('fileUpload data: $data');
                        if (hasUploadedFile) {
                          log('file upload successful');
                          final trimmedData = data?.substring(
                            data.indexOf('/dealer'),
                          );
                          log('trimmed Data: $trimmedData');
                          final hasUpdatedReceiptUrl = await ref
                              .read(updateReceiptUrlControllerProvider.notifier)
                              .updateReceiptUrl(
                                  invoiceId: invoiceId,
                                  receiptfileUrl: trimmedData ?? '');
                          log('check second file: ${ref.watch(updateReceiptUrlControllerProvider).status == ResponseStatus.loading}');
                          if (hasUpdatedReceiptUrl) {
                            print('Receipt Url Successfully updated');
                            Navigator.pop(context);
                            CustomSnackBar.showSnackBar(
                                context: context, message: 'Upload successful');
                          } else {
                            print(' UnSuccessfully  Url update');
                          }
                        } else {
                          log('file upload unsuccessful');
                        }
                      }
                    },
                    isLoading: ref
                                .watch(receiptFileUploadControllerProvider)
                                .status ==
                            ResponseStatus.loading &&
                        ref.watch(updateReceiptUrlControllerProvider).status ==
                            ResponseStatus.loading,
                    label: 'Submit',
                    isActive: !(result == null || result!.files.isEmpty),
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
            );
          }),
        ),
      );
    },
  );
}
