// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:developer';

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/cancel_button.dart';
import '../../../../core/common_widgets/custom_pin_input_field.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/enums.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/data/controller/create_order_controller.dart';
import '../../../subscriptions/data/controller/generate_reference_controller.dart';
import '../../data/controller/charge_dealer_wallet_controller.dart';
import '../../data/controller/confirm_order_controller.dart';
import '../../data/controller/dealer_user_details_controller.dart';
import '../../data/controller/get_dealer_by_identity_controller.dart';
import '../../data/controller/user_balance_controller.dart';

class ConfirmOrderScreen extends ConsumerStatefulWidget {
  const ConfirmOrderScreen({required this.amount, Key? key}) : super(key: key);

  final num amount;

  @override
  ConsumerState<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends ConsumerState<ConfirmOrderScreen> {
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pin = ValueNotifier<String>('');
    final dealerCustomerDetailsController =
        ref.watch(fetchDealerUserDetailsControllerProvider);
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    final digitalOrderController =
        ref.watch(createDigitalOrderControllerProvider.notifier).state.data;
    final reference =
        ref.watch(generateReferenceControllerProvider.notifier).state.data;
    final dealerIdentityController =
        ref.watch(fetchDealerByIdentityControllerProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Authorize Order',
              style: AppTheme.lightTextTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            CancelButton(),
          ],
        ),
        30.hi,
        Text(
          'To complete this process,\nPlease enter the otp code sent to your phone number or email.',
          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            color: AppColors.deepAsh,
            fontWeight: FontWeight.w400,
            fontFamily: AppTheme.montserratAlternate,
          ),
        ),
        40.hi,
        ValueListenableBuilder(
            valueListenable: pin,
            builder: (context, value, child) {
              return CustomPinInputField(
                length: 4,
                controller: otpController,
                onCompleted: (val) {
                  setState(() {
                    pin.value = val;
                  });
                },
              );
            }),
        50.hi,
        AppElevatedButton(
          isLoading: ref.watch(confirmOrderControllerProvider).status ==
                  ResponseStatus.loading ||
              ref.watch(generateReferenceControllerProvider).status ==
                  ResponseStatus.loading ||
              ref.watch(chargeDealerUserWalletControllerProvider).status ==
                  ResponseStatus.loading,
          onTap: () async {
            //! confirm order endpoint
            final hasConfirmedOrder = await ref
                .read(confirmOrderControllerProvider.notifier)
                .confirmOrder(
                  orderId: digitalOrderController?.id ?? 0,
                  email: userDetailsController?.email ?? '',
                  dealerId: dealerIdentityController.data?.data?.id ?? 0,
                  dealerPhoneNumber: userDetailsController?.phoneNumber ?? '',
                  orderCode: otpController.text,
                );
            if (hasConfirmedOrder) {
              log('confirm order successful ');

              ///!charge dealer wallet
              final hasChargeDealerWallet = await ref
                  .read(chargeDealerUserWalletControllerProvider.notifier)
                  .chargeDealerWallet(
                      reference: int.parse(reference ?? ""),
                      userId:
                          dealerCustomerDetailsController.data?.id.toString() ??
                              '',
                      orderId: digitalOrderController?.id ?? 0,
                      amount: widget.amount,
                      phoneNumber:
                          dealerCustomerDetailsController.data?.phoneNumber ??
                              '');
              if (hasChargeDealerWallet) {
                log('----charge dealer wallet successful!--');
                // await ref
                //     .read(fetchUserBalanceControllerProvider.notifier)
                //     .userBalance(
                //         userId: ref
                //                 .watch(userDetailsControllerProvider.notifier)
                //                 .state
                //                 .data
                //                 ?.data
                //                 ?.user
                //                 ?.id
                //                 .toString() ??
                //             '');
                await ref
                    .read(fetchUserBalanceControllerProvider.notifier)
                    .userBalance();
                CustomSnackBar.showSnackBar(
                    context: context, message: 'SuccessFul');
                otpController.clear();
                Future.delayed(
                    Duration(
                      seconds: 1,
                    ), () {
                  Navigator.pop(context);
                });
              } else {
                log('----charge dealer wallet Unsuccessful!--');
                CustomSnackBar.showSnackBar(
                    context: context, message: 'UnSuccessFul', isError: true);
                otpController.clear();
                Future.delayed(
                    Duration(
                      seconds: 1,
                    ), () {
                  Navigator.pop(context);
                });
              }
            } else {
              log('confirm order unsuccessful ');
              final message = ref
                  .watch(confirmOrderControllerProvider.notifier)
                  .state
                  .message;
              CustomSnackBar.showSnackBar(
                  context: context,
                  message: message ?? "Order hasn\t been confirmed",
                  isError: true);
            }
          },
          label: 'Submit',
        )
      ],
    ).padHorizontal(8);
  }
}
