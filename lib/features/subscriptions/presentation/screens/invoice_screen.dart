// ignore_for_file: prefer_final_fields

import 'dart:developer';
import 'dart:io';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/status_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/ui_helper.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/invoice_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/custom_alert_dialog.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../data/controller/create_order_controller.dart';
import '../../data/controller/file_upload_controller.dart';
import '../../data/controller/invoice_url_controller.dart';
import '../../data/repository/order_invoice_repository.dart';

class InvoiceScreen extends ConsumerStatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends ConsumerState<InvoiceScreen> {
  int invoiceId = 0;
  ScreenshotController _screenshotController = ScreenshotController();
  Future<String> _generateTemporaryUrl(String filePath) async {
    final temoraryDirectory = await getApplicationDocumentsDirectory();
    final temporaryFile = File(
        '${temoraryDirectory.path}/temp_${DateTime.now().millisecondsSinceEpoch}.pdf');

    await temporaryFile.writeAsBytes(await File(filePath).readAsBytes());
    final url = Uri.file(temporaryFile.path).toFilePath();
    return url;
  }

  Future<void> _captureScreenshot() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
    final pdfPath =
        '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.pdf';

    await _screenshotController.capture().then((image) async {
      final file = File(imagePath);
      await file.writeAsBytes(image!.cast<int>());
      final pdfFile = File(pdfPath);
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(build: (context) {
          return pw.Center(
            child: pw.Image(pw.MemoryImage(image)),
          );
        }),
      );
      await pdf.save().then((pdfBtyes) async {
        pdfFile.writeAsBytesSync(pdfBtyes);
        String temporaryUrl = await _generateTemporaryUrl(pdfFile.path);

        final isPdfUploaded =
            await ref.read(fileUploadControllerProvider.notifier).uploadFile(
                  file: File(pdfPath),
                );
        if (isPdfUploaded) {
          final response = ref.read(fileUploadControllerProvider).data;

          final trimmedData = response?.substring(
            response.indexOf('/dealer'),
          );
          final hasUploadInvoice = await ref
              .read(invoiceUrlControllerProvider.notifier)
              .uploadInvoiceUrl(
                  invoiceId: invoiceId, invoicefileUrl: trimmedData ?? '');
          if (hasUploadInvoice) {
            // log('...SuccessFull invoice upload...');
          } else {
            // log('...unSuccessFull invoice upload...');
          }
        } else {
          // log('Invoice not  Uploaded');
        }
      });
    }).catchError((onError) => print('image path error: $onError'));
  }

  @override
  Widget build(BuildContext context) {
    var logger = Logger(
      printer: PrettyPrinter(),
    );

    final orderId = ref.watch(createDigitalOrderControllerProvider).data?.id;
    final invoiceFutureController =
        ref.watch(orderInvoiceRepositoryFutureProvider(orderId ?? 0));
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
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
        child: Screenshot(
          controller: _screenshotController,
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
                    ).padHorizontal(12),
                    20.hi,
                    invoiceFutureController.when(
                      data: (data) {
                        setState(() {
                          invoiceId = data.id ?? 0;
                        });
                        _captureScreenshot();

                        String inputDate = data.createdAt.toString();
                        DateTime dateTime = DateTime.parse(inputDate);
                        String formattedTime =
                            DateFormat('hh:mma').format(dateTime).toLowerCase();

                        DateTime parseDate = DateTime.parse(inputDate);
                        String formattedDate =
                            DateFormat('MMM dd, yyyy').format(parseDate);
                        log(formattedDate);
                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: 'INV-${data.id}',
                                      style: AppTheme.lightTextTheme.bodyLarge
                                          ?.copyWith(
                                        fontSize: 21,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            AppTheme.montserratAlternate,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' for ${formatNaira(data.amount ?? '')}',
                                          style: AppTheme
                                              .lightTextTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor,
                                            fontSize: 18,
                                            fontFamily:
                                                AppTheme.montserratAlternate,
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
                                          customAlertDialog(
                                              context: context,
                                              ref: ref,
                                              invoiceId: data.id ?? 0);
                                        },
                                      ),
                                    ),
                                    10.wi,
                                    AppElevatedButton(
                                      borderRadius: 8,
                                      rowIcon: AppIcons.share,
                                      width: 112.w,
                                      rowLabel: 'share',
                                      rowLabelstyle: AppTheme
                                          .lightTextTheme.bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.w5Color,
                                              fontSize: 16.sp),
                                      onTap: () {},
                                      isLightShade: true,
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
                                      isLightShade: true,
                                      rowLabelstyle: AppTheme
                                          .lightTextTheme.bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.w5Color,
                                              fontSize: 16.sp),
                                    ),
                                    10.wi,
                                    AppElevatedButton(
                                      borderRadius: 8,
                                      rowIcon: AppIcons.print,
                                      width: 125.w,
                                      rowLabel: 'Print',
                                      onTap: () {},
                                      isLightShade: true,
                                      rowLabelstyle: AppTheme
                                          .lightTextTheme.bodyLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.w5Color,
                                              fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                                18.hi,
                                const AppDivider(),
                                18.hi,
                                Text(
                                  'SUMMARY',
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                          color: AppColors.deepAsh,
                                          fontSize: 12.sp),
                                ),
                                20.hi,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InvoiceSummary(
                                          leading: 'Invoice ID:',
                                          trailing: '   INV-${data.id}',
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Name:',
                                          trailing:
                                              '  ${userDetailsController?.name} ',
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Email:',
                                          trailing:
                                              '  ${userDetailsController?.email}',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const InvoiceSummary(
                                          leading: 'Currency:',
                                          trailing: '  Naira',
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Time:  ',
                                          trailing: formattedTime,
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Date:  ',
                                          trailing: formattedDate,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                18.hi,
                                const AppDivider(),
                                18.hi,
                                Text(
                                  'ACCOUNT DETAILS',
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                          color: AppColors.deepAsh,
                                          fontSize: 12.sp),
                                ),
                                20.hi,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const InvoiceSummary(
                                      leading: 'Bank Name:',
                                      trailing: ' Wema',
                                    ),
                                    14.hi,
                                    Row(
                                      children: [
                                        const InvoiceSummary(
                                          leading: 'Account Number:',
                                          trailing: ' 5003553283',
                                        ),
                                        8.wi,
                                        InkWell(
                                          onTap: () async =>
                                              await Clipboard.setData(
                                            const ClipboardData(
                                                text: '5003553283'),
                                          ).then(
                                            (value) => CustomSnackBar.showSnackBar(
                                                context: context,
                                                message:
                                                    'Account number copied to clipboard'),
                                          ),
                                          child:
                                              SvgPicture.asset(AppIcons.copy),
                                        ),
                                      ],
                                    ),
                                    14.hi,
                                    const InvoiceSummary(
                                      leading: 'Account Name:',
                                      trailing: ' Wave 5 Wireless',
                                    ),
                                  ],
                                ),
                                18.hi,
                                const AppDivider(),
                                18.hi,
                                Text(
                                  'BREAKDOWN',
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                          color: AppColors.deepAsh,
                                          fontSize: 12.sp),
                                ),
                                18.hi,
                              ],
                            ).padHorizontal(16),

                            BreakDownTile(
                              prefix: 'Top up',
                              suffix: 'Amount',
                              isFilled: true,
                            ),
                            const AppDivider(),
                            10.hi,
                            BreakDownTile(
                              prefix: 'Fund Wallet',
                              suffix: formatNaira(data.amount ?? ''),
                            ),
                            const AppDivider(),
                            10.hi,
                            BreakDownTile(
                              prefix: 'Tax (7.5%)',
                              suffix: '',
                            ),
                            const AppDivider(),
                            // 10.hi,
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       'Total:',
                            //       style: AppTheme.lightTextTheme.bodyLarge
                            //           ?.copyWith(
                            //         color: AppColors.deepAsh,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     Text(
                            //       formatNaira(data.amount ?? ''),
                            //       style: AppTheme.lightTextTheme.bodyLarge
                            //           ?.copyWith(
                            //         color: AppColors.deepAsh,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //   ],
                            // ).padHorizontal(12),

                            BreakDownTile(
                              prefix: 'Total:',
                              prefixTextStyle:
                                  AppTheme.lightTextTheme.bodyLarge?.copyWith(
                                color: AppColors.deepAsh,
                                fontWeight: FontWeight.w600,
                              ),
                              suffix: formatNaira(data.amount ?? ''),
                              suffixTextSyle:
                                  AppTheme.lightTextTheme.bodyLarge?.copyWith(
                                color: AppColors.deepAsh,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      },
                      error: (error, stackTrace) {
                        logger.i('error: ${error.toString()}');
                        return const Center(
                          child: Text('Oops! something went wrong'),
                        );
                      },
                      loading: () {
                        return const SpinKitSpinningLines(
                          color: AppColors.primaryColor,
                        );
                      },
                    ),
                    20.hi,
                  ],
                ),
                20.hi,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BreakDownTile extends StatelessWidget {
  BreakDownTile({
    required this.prefix,
    required this.suffix,
    this.prefixTextStyle,
    this.suffixTextSyle,
    this.isFilled = false,
    super.key,
  });
  final String prefix, suffix;
  final TextStyle? prefixTextStyle, suffixTextSyle;
  bool isFilled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 14),
      decoration: BoxDecoration(
        color: isFilled ? AppColors.greyShade50 : Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                prefix,
                style: prefixTextStyle ??
                    AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: AppColors.deepAsh, fontSize: 13.17.sp),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                suffix,
                style: suffixTextSyle ??
                    AppTheme.lightTextTheme.bodyLarge?.copyWith(
                        color: AppColors.deepAsh, fontSize: 13.17.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
