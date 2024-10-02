// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_bars/primary_appbar.dart';
import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/enums.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/custom_inapp_browser.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/data/controller/generate_reference_controller.dart';
import '../../data/controller/create_digital_prd_controller.dart';
import '../../data/controller/paystack_link_controller.dart';

final amountStateProvider = StateProvider<num>((ref) => 0);
final generatedReferenceStateProvider = StateProvider<String>((ref) => "");
final userIdStateProvider = StateProvider<String>((ref) => "");

class FundWalletScreen extends ConsumerStatefulWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends ConsumerState<FundWalletScreen> {
  final amountCtrl = TextEditingController();
  final validation = GlobalKey<FormState>();
  bool isAmountValid = false;

  void validateAmount() {
    setState(() {
      isAmountValid = valiadteAmountToFund(amountCtrl.text) == null;
    });
  }

  @override
  void initState() {
    amountCtrl.addListener(validateAmount);
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // When app is resumed, refresh balance and pop back to WalletScreen
  //     ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
  //     if (mounted) {
  //       Navigator.of(context).pop(true); // Pass true to indicate refresh needed
  //     }
  //   }
  // }

  @override
  void dispose() {
    amountCtrl.removeListener(validateAmount);
    // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String? valiadteAmountToFund(String? amount) {
    if (amount == null || amount.isEmpty) {
      isAmountValid = false;
      return 'Amount  cannot be blank';
    }
    if (int.parse(amount) < 300) {
      isAmountValid = false;
      return 'Amount cannot be less than ₦300';
    }

    isAmountValid = true;
    return null;
  }

  bool get isFormValid {
    return amountCtrl.text.isEmpty || !isAmountValid;
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PrimaryAppBar(
        title: 'Fund Wallet',
        icon: AppIcons.cancel,
        style: AppTheme.lightTextTheme.titleLarge?.copyWith(
          fontSize: 26.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
          fontFamily: AppTheme.dmSans,
        ),
        onTap: () {
          Navigator.pop(context);
          // Navigator.of(context).pop(false);
        },
      ),
      body: SingleChildScrollView(
          child: Form(
        key: validation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hi,
            Text(
              'Enter the amount you would like to fund into your wallet.',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontSize: 16,
              ),
            ),
            40.hi,
            AppTextField(
              radius: 14,
              filled: false,
              controller: amountCtrl,
              validator: valiadteAmountToFund,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'Enter Amount',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 8,
                ),
                child: SizedBox(
                  width: 90.w,
                  height: 20.h,
                  child: Row(
                    children: [
                      Text(
                        '₦',
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText,
                        ),
                      ),
                      const VerticalDivider(
                        color: AppColors.dividerColor,
                      )
                    ],
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(0.5),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            30.hi,
            RichText(
              text: TextSpan(
                text: 'Please note that transactions above ',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '₦10,000,000',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' (Ten million naira) would require a manual process of paying to the company specified bank account on the invoice.',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            140.hi,
            // AppElevatedButton(
            //   onTap: () {
            //     fundWalletconfirmationDialog(context: context, ref: ref);
            //   },
            //   label: "Next",
            //   isActive: !isFormValid,
            // ),
            // 30.hi,
            Consumer(builder: (context, ref, child) {
              return AppElevatedButton(
                isLoading:
                    ref.watch(createDigitalProductsControllerProvider).status ==
                            ResponseStatus.loading ||
                        ref.watch(generateReferenceControllerProvider).status ==
                            ResponseStatus.loading ||
                        ref.watch(generatePaystackLinResModelProvider).status ==
                            ResponseStatus.loading,
                onTap: isFormValid
                    ? () {
                        log('Test');
                      }
                    : () async {
                        //! create didgital products
                        final hasCreateDigitalProduct = await ref
                            .read(createDigitalProductsControllerProvider
                                .notifier)
                            .createDigitalPrd(
                                amount: int.parse(amountCtrl.text));
                        if (hasCreateDigitalProduct) {
                          log('digital order created successfully');
                          //! generate reference
                          final isReferenceGenerated = await ref
                              .read(
                                  generateReferenceControllerProvider.notifier)
                              .generateReference(
                                amount: int.parse(amountCtrl.text),
                                userId: userDetailsController
                                        .data?.data?.user?.id
                                        .toString() ??
                                    '',
                                paymentMethod: "paystack",
                                note: "fund wallet",
                                transactionType: "credit",
                              );
                          if (isReferenceGenerated) {
                            final reference = ref
                                .read(generateReferenceControllerProvider
                                    .notifier)
                                .state
                                .data;
                            //! generate payment url
                            final hasgeneratedPaymentLink = await ref
                                .read(generatePaystackLinResModelProvider
                                    .notifier)
                                .paystackPaymentLink(
                                    identity: userDetailsController
                                            .data?.data?.user?.id
                                            .toString() ??
                                        '',
                                    amount: int.parse(amountCtrl.text) * 100,
                                    reference: reference ?? '');
                            if (hasgeneratedPaymentLink) {
                              final paymentLink = ref
                                  .read(generatePaystackLinResModelProvider
                                      .notifier)
                                  .state
                                  .data
                                  ?.data
                                  ?.authorizationUrl;
                              ref.read(amountStateProvider.notifier).state =
                                  int.parse(amountCtrl.text);
                              ref
                                  .read(
                                      generatedReferenceStateProvider.notifier)
                                  .state = reference ?? '';
                              ref.read(userIdStateProvider.notifier).state =
                                  userDetailsController.data?.data?.user?.id
                                          .toString() ??
                                      '';

                              await Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return CustomInAppBrowser(
                                  url: paymentLink ?? '',
                                  isFunding: true,
                                );
                              }));
                            } else {
                              log('--failed to generate payment link order----');
                            }
                          } else {
                            log('--failed to generate refernce order----');
                          }
                        } else {
                          log('--failed to create digital order----');
                        }
                      },
                label: 'Continue',
                isActive: !isFormValid,
              );
            }),
          ],
        ).padHorizontal(16),
      )),
    );
  }
}
