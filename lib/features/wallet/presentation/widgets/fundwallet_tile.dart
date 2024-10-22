// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/invoice_screen.dart';
import 'package:dealer_portal_mobile/features/wallet/data/controller/paystack_link_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/enums.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/data/controller/create_order_controller.dart';
import '../../../subscriptions/data/controller/generate_reference_controller.dart';
import '../../data/controller/create_digital_prd_controller.dart';

final amountStateProvider = StateProvider<num>((ref) => 0);
final generatedReferenceStateProvider = StateProvider<String>((ref) => "");
final userIdStateProvider = StateProvider<String>((ref) => "");

class FundWalletTile extends ConsumerStatefulWidget {
  const FundWalletTile({
    super.key,
  });

  @override
  ConsumerState<FundWalletTile> createState() => _FundWalletTileState();
}

class _FundWalletTileState extends ConsumerState<FundWalletTile> {
  final validation = GlobalKey<FormState>();
  bool isAmountValid = false;
  final amountController = TextEditingController();
  // bool isAmountAboveLimit = false;

  void validateAmount() {
    setState(() {
      isAmountValid = valiadteAmountToFund(amountController.text) == null;
    });
  }

  @override
  void initState() {
    amountController.addListener(validateAmount);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // String? valiadteAmountToFund(String? amount) {
  //   if (amount == null || amount.isEmpty) {
  //     isAmountValid = false;
  //     return 'Amount  cannot be blank';
  //   }
  //   if (int.parse(amount) < 300) {
  //     isAmountValid = false;
  //     return 'Amount cannot be less than ₦300';
  //   }

  //   isAmountValid = true;
  //   return null;
  // }

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
    return amountController.text.isEmpty || !isAmountValid;
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsController = ref.watch(userDetailsControllerProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fund Wallet',
                style: AppTheme.lightTextTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // color: AppColors.whiteShade80.withOpacity(0.6),
                      color: AppColors.lighterText.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14.4),
                      ),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.cancel,
                      width: 12,
                      height: 12,
                    ),
                  )),
            ],
          ),
          30.hi,
          Text(
            'Enter the amount you want to wallet your wallet with',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
              color: AppColors.deepAsh,
              fontFamily: AppTheme.montserratAlternate,
              fontWeight: FontWeight.w400,
            ),
          ),
          20.hi,
          Stack(
            children: [
              AppTextField(
                fillColor: AppColors.lighterText.withOpacity(0.08),
                // contentPadding: const EdgeInsets.symmetric(
                //   vertical: 18,
                //   horizontal: 8,
                // ),
                contentPadding: const EdgeInsets.only(
                  top: 40,
                  left: 8,
                  right: 8,
                ),
                validator: valiadteAmountToFund,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                radius: 16.r,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.sp,
                  color: AppColors.greyText,
                ),

                controller: amountController,
                hintText: "",
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 24, right: 10),
                  child: Text(
                    'NGN',
                    style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                      color: AppColors.lighterText,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 10,
                  top: 24,
                  child: IgnorePointer(
                    child: Text(
                      'Amount',
                      style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.lighterText,
                          fontWeight: FontWeight.w400),
                    ),
                  ))
            ],
          ),
          80.hi,
          AppElevatedButton(
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
                        .read(createDigitalProductsControllerProvider.notifier)
                        .createDigitalPrd(
                            amount: int.parse(amountController.text));
                    if (hasCreateDigitalProduct) {
                      log('digital product created successfully');
                      //! checking if amount is above limit
                      if (int.parse(amountController.text) >= 10000000) {
                        log('--Amount is above limit----');
                        //! generate reference for offline payment
                        final isReferenceOfflineGenerated = await ref
                            .read(generateReferenceControllerProvider.notifier)
                            .generateReference(
                              amount: int.parse(amountController.text),
                              userId: userDetailsController.data?.data?.user?.id
                                      .toString() ??
                                  '',
                              paymentMethod: "offline",
                              note: "credit",
                              transactionType: "credit",
                            );
                        if (isReferenceOfflineGenerated) {
                          final createOrderReference = ref
                              .read(
                                  generateReferenceControllerProvider.notifier)
                              .state
                              .data;
                          final createdDigitalProduct = ref
                              .read(createDigitalProductsControllerProvider
                                  .notifier)
                              .state
                              .data;
                          //! create digital order
                          final hasCreateDigitalOrder = await ref
                              .read(
                                  createDigitalOrderControllerProvider.notifier)
                              .createDigitalOrders(
                                reference: createOrderReference ?? '',
                                userId: userDetailsController
                                        .data?.data?.user?.id ??
                                    0,
                                dealerId: userDetailsController
                                        .data?.data?.user?.id ??
                                    0,
                                dealerUserId: userDetailsController
                                        .data?.data?.user?.id ??
                                    0,
                                amount: int.parse(amountController.text),
                                total: int.parse(amountController.text),
                                totalHrs: 24,
                                orderItems: [
                                  {
                                    "product_id": createdDigitalProduct?.id,
                                    "order_quantity": 1,
                                    "unit_price": createdDigitalProduct?.price,
                                    "subtotal": createdDigitalProduct?.price,
                                    "item_name": createdDigitalProduct?.name,
                                    "total_hours": createdDigitalProduct?.hours,
                                    "validity":
                                        createdDigitalProduct?.totalValidity,
                                    "vendor_id": 0,
                                    "dealer_id":
                                        createdDigitalProduct?.dealerId,
                                    "sub_dealer":
                                        createdDigitalProduct?.subDealerId,
                                    "product_type": "dealer",
                                    "discount": 0
                                  }
                                ],
                                paymentMethod: "offline",
                              );
                          if (hasCreateDigitalOrder) {
                            log('digital order created successfully');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return InvoiceScreen();
                              }),
                            );
                          } else {
                            ('--failed to create digital order----');
                          }
                        } else {
                          log('--failed to genrate eOffline reference----');
                        }
                      } else {
                        //! generate reference
                        final isReferenceGenerated = await ref
                            .read(generateReferenceControllerProvider.notifier)
                            .generateReference(
                              amount: int.parse(amountController.text),
                              userId: userDetailsController.data?.data?.user?.id
                                      .toString() ??
                                  '',
                              paymentMethod: "paystack",
                              note: "fund wallet",
                              transactionType: "credit",
                            );
                        if (isReferenceGenerated) {
                          final reference = ref
                              .read(
                                  generateReferenceControllerProvider.notifier)
                              .state
                              .data;
                          log('--generated reference---: $reference');
                          //! generate payment url
                          final hasgeneratedPaymentLink = await ref
                              .read(
                                  generatePaystackLinResModelProvider.notifier)
                              .paystackPaymentLink(
                                  identity: userDetailsController
                                          .data?.data?.user?.id
                                          .toString() ??
                                      '',
                                  amount:
                                      int.parse(amountController.text) * 100,
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
                                int.parse(amountController.text);
                            ref
                                .read(generatedReferenceStateProvider.notifier)
                                .state = reference ?? '';
                            ref.read(userIdStateProvider.notifier).state =
                                userDetailsController.data?.data?.user?.id
                                        .toString() ??
                                    '';
                            // await Navigator.pushReplacement(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return CustomInAppBrowser(
                            //     url: paymentLink ?? '',
                            //     isFunding: true,
                            //   );
                            // }));
                          } else {
                            log('--failed to generate payment link ----');
                          }
                        } else {
                          log('--failed to generate refernce ----');
                        }
                      }
                    } else {
                      log('--failed to create digital product----');
                    }
                  },
            label: "Continue",
            isActive: !isFormValid,
          ),
          10.hi,
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
