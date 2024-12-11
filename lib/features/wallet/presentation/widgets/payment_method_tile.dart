// ignore_for_file: use_build_context_synchronously, invalid_use_of_protected_member

import 'dart:developer';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/widgets/fundwallet_tile.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/widgets/payment_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/cancel_button.dart';
import '../../../../core/enums.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/custom_inapp_browser.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/data/controller/generate_reference_controller.dart';
import '../../data/controller/paystack_link_controller.dart';

final paymentMethodStateProvider = StateProvider<String>((ref) => "");

class PaymentMethodTile extends ConsumerStatefulWidget {
  const PaymentMethodTile({Key? key}) : super(key: key);

  @override
  _PaymentMethodTileState createState() => _PaymentMethodTileState();
}

class _PaymentMethodTileState extends ConsumerState<PaymentMethodTile> {
  bool isPayStack = true;
  bool isMonify = false;
  @override
  Widget build(BuildContext context) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    return Container(
      width: double.infinity,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fund Wallet',
                style: AppTheme.lightTextTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              const CancelButton(),
            ],
          ),
          30.hi,
          Text(
            'Payment method',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.deepAsh,
                fontFamily: AppTheme.montserratAlternate,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          ),
          20.hi,
          PaymentTypeButton(
            label: 'Paystack',
            isClicked: isPayStack,
            onTap: () {
              setState(() {
                isPayStack = !isPayStack;
                isMonify = !isMonify;
              });
            },
          ),
          // 16.hi,
          // PaymentTypeButton(
          //   label: 'Monify',
          //   isClicked: isMonify,
          //   onTap: () {
          //     setState(() {
          //       isMonify = !isMonify;
          //       isPayStack = !isPayStack;
          //     });
          //   },
          // ),
          80.hi,
          AppElevatedButton(
            label: 'Continue',
            isLoading: ref.watch(generateReferenceControllerProvider).status ==
                    ResponseStatus.loading ||
                ref.watch(generatePaymentkLinkProvider).status ==
                    ResponseStatus.loading,
            onTap: () async {
              if (isPayStack == true) {
                log('---paystack payment method---');
                //! generate reference for paystack
                final isReferenceGenerated = await ref
                    .read(generateReferenceControllerProvider.notifier)
                    .generateReference(
                      amount: ref.watch(amountStateProvider),
                      userId: userDetailsController.data?.data?.user?.id
                              .toString() ??
                          '',
                      paymentMethod: "paystack",
                      note: "fund wallet",
                      transactionType: "credit",
                    );
                if (isReferenceGenerated) {
                  final reference = ref
                      .read(generateReferenceControllerProvider.notifier)
                      .state
                      .data;
                  log('--generated paystack reference---: $reference');
                  //! generate payment url for paystack
                  final hasgeneratedPaymentLink = await ref
                      .read(generatePaymentkLinkProvider.notifier)
                      .paymentLink(
                          identity: userDetailsController.data?.data?.user?.id
                                  .toString() ??
                              '',
                          amount: ref.watch(amountStateProvider) * 100,
                          reference: reference ?? '',
                          isPaystack: true);
                  if (hasgeneratedPaymentLink) {
                    final paymentLink = ref
                        .read(generatePaymentkLinkProvider.notifier)
                        .state
                        .data
                        ?.data
                        ?.authorizationUrl;
                    log('paystack url: $paymentLink');
                    // ref.read(amountStateProvider.notifier).state =
                    //     int.parse(
                    //         amountController.text.replaceAll(',', ''));
                    ref.read(generatedReferenceStateProvider.notifier).state =
                        reference ?? '';
                    ref.read(paymentMethodStateProvider.notifier).state =
                        "paystack";
                    ref.read(userIdStateProvider.notifier).state =
                        userDetailsController.data?.data?.user?.id.toString() ??
                            '';
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomInAppBrowser(
                        url: paymentLink ?? '',
                        isFunding: true,
                      );
                    }));
                  } else {
                    log('--failed to generate payment link for paystack ----');
                  }
                } else {
                  log('--failed to generate refernce for paystack----');
                }
              } else if (isMonify == true) {
                //! generate reference for monify

                log('---monify payment method ---');

                final isReferenceGenerated = await ref
                    .read(generateReferenceControllerProvider.notifier)
                    .generateReference(
                      amount: ref.watch(amountStateProvider),
                      userId: userDetailsController.data?.data?.user?.id
                              .toString() ??
                          '',
                      paymentMethod: "monify",
                      note: "fund wallet",
                      transactionType: "credit",
                    );
                if (isReferenceGenerated) {
                  final reference = ref
                      .read(generateReferenceControllerProvider.notifier)
                      .state
                      .data;
                  log('--generated paystack reference---: $reference');
                  //! generate payment url for monify
                  final hasgeneratedPaymentLink = await ref
                      .read(generatePaymentkLinkProvider.notifier)
                      .paymentLink(
                          identity: userDetailsController.data?.data?.user?.id
                                  .toString() ??
                              '',
                          amount: ref.watch(amountStateProvider),
                          reference: reference ?? '',
                          isPaystack: false);
                  if (hasgeneratedPaymentLink) {
                    final paymentLink = ref
                        .read(generatePaymentkLinkProvider.notifier)
                        .state
                        .data
                        .responseBody
                        .checkoutUrl;
                    log('monify payment link: $paymentLink');
                    ref.read(generatedReferenceStateProvider.notifier).state =
                        reference ?? '';
                    ref.read(userIdStateProvider.notifier).state =
                        userDetailsController.data?.data?.user?.id.toString() ??
                            '';
                    ref.read(paymentMethodStateProvider.notifier).state =
                        "monify";
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomInAppBrowser(
                        url: paymentLink ?? '',
                        isFunding: true,
                      );
                    }));
                  } else {
                    log('--failed to generate payment link for monify ----');
                  }
                } else {
                  log('--failed to generate refernce for monify----');
                }
              }
            },
          ),
          16.hi,
          AppElevatedButton(
            onTap: () {
              Navigator.pop(context);
            },
            isLightShade: true,
            rowLabel: 'Close',
          ),
        ],
      ),
    );
  }
}
