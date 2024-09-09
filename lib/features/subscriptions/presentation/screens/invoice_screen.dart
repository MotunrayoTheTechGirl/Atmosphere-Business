// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/status_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/ui_helper.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/screenshot_test2.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_table_header.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/invoice_breakdown_tile.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/invoice_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';

import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/custom_alert_dialog.dart';
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

                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      text: data.invoiceReference ??
                                          'INV-10022004-001',
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
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          // return const ScreenShotTest();
                                          return const ScreenshotCapture();
                                        }));
                                      },
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
                                Text(
                                  'SUMMARY',
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                                26.hi,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const InvoiceSummary(
                                          leading: 'Invoice ID:',
                                          trailing: ' INV-10022004-001',
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Name:',
                                          trailing:
                                              ' ${userDetailsController?.firstName} ${userDetailsController?.lastName}',
                                        ),
                                        14.hi,
                                        InvoiceSummary(
                                          leading: 'Email:',
                                          trailing:
                                              ' ${userDetailsController?.email}',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  style: AppTheme.lightTextTheme.bodySmall
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                                18.hi,
                              ],
                            ).padHorizontal(16),
                            const CustomTableHeader(
                              forInvoice: true,
                            ),
                            SizedBox(
                              height: 140.h,
                              child: ListView.separated(
                                itemCount: data.items.length,
                                itemBuilder: (context, index) {
                                  final item = data.items[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 12),
                                    child: InvoiceBreakDownTile(
                                      plan: item.itemName ?? '',
                                      quantity: item.totalHours.toString(),
                                      amount: formatNaira(
                                          item.unitPrice.toString()),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const AppDivider();
                                },
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            10.hi,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sub total:',
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                                Text(
                                  formatNaira(data.amount ?? ''),
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                              ],
                            ).padHorizontal(12),
                            10.hi,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax (7.5%)',
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                                Text(
                                  '',
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                  ),
                                ),
                              ],
                            ).padHorizontal(12),
                            10.hi,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total:',
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  formatNaira(data.amount ?? ''),
                                  style: AppTheme.lightTextTheme.bodyLarge
                                      ?.copyWith(
                                    color: AppColors.deepAsh,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ).padHorizontal(12),
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
