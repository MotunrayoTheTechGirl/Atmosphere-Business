// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:developer';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
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
import '../../../../core/utils/ui_helper.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../subscriptions/data/controller/create_order_controller.dart';
import '../../../subscriptions/data/controller/generate_reference_controller.dart';
import '../../data/controller/dealer_user_details_controller.dart';
import '../../data/controller/get_dealer_by_identity_controller.dart';
import '../screens/confirm_order_screen.dart';

class AssignToCustomerTile extends ConsumerStatefulWidget {
  const AssignToCustomerTile(
      {required this.amount,
      required this.totalHrs,
      required this.productId,
      required this.itemName,
      required this.validity,
      Key? key})
      : super(key: key);

  final num amount;
  final num totalHrs;
  final int productId;
  final String itemName;
  final int validity;

  @override
  _AssignToCustomerTileState createState() => _AssignToCustomerTileState();
}

class _AssignToCustomerTileState extends ConsumerState<AssignToCustomerTile> {
  final phoneNumberCrtl = TextEditingController();
  bool isFormValid = false;
  final validation = GlobalKey<FormState>();
  // bool isAmountValid = false;

  void validatePhoneNumber() {
    setState(() {
      isFormValid = valiadteNumber(phoneNumberCrtl.text) == null;
    });
  }

  @override
  void initState() {
    phoneNumberCrtl.addListener(validatePhoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberCrtl.removeListener(validatePhoneNumber);
    super.dispose();
  }

  String? valiadteNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      isFormValid = false;

      return 'phoneNumber  cannot be blank';
    }
    if (phoneNumber.length < 11) {
      isFormValid = false;

      return 'phoneNumber cannot be less than 11 digits';
    }
    if (phoneNumber.length > 11) {
      isFormValid = false;
      return 'phoneNumber cannot be more than 11 digits';
    }
    if (phoneNumber.length == 11 && RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      isFormValid = true;
      return '';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    final dealerIdentityController =
        ref.watch(fetchDealerByIdentityControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: .2.sh,
        height: .3.sh,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Form(
            key: validation,
            child: Column(
              children: [
                SizedBox(
                  width: 300.w,
                  child: Text(
                    widget.itemName,
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyText,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13.sp),
                  ),
                ),
                12.hi,
                AppTextField(
                  radius: 14,
                  filled: true,
                  controller: phoneNumberCrtl,
                  validator: valiadteNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 8,
                  ),
                  hintText: 'Recipient phone number',
                  hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.textFieldBorder.withOpacity(
                      0.5,
                    ),
                  ),
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.textColor,
                  ),
                  prefixIcon: SvgPicture.asset(
                    AppIcons.phone,
                    width: 18.w,
                    height: 18.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                // 10.hi,
                60.hi,
                Consumer(builder: (context, ref, child) {
                  return AppElevatedButton(
                    isActive: isFormValid,
                    //? In progress..
                    isLoading: ref
                                .watch(fetchDealerByIdentityControllerProvider)
                                .status ==
                            ResponseStatus.loading ||
                        ref
                                .watch(fetchDealerUserDetailsControllerProvider)
                                .status ==
                            ResponseStatus.loading ||
                        ref
                                .watch(createDigitalOrderControllerProvider)
                                .status ==
                            ResponseStatus.loading,
                    onTap: !isFormValid
                        ? () {
                            log('form is not valid');
                          }
                        : () async {
                            final phoneNumber =
                                formatPhoneNumber(phoneNumberCrtl.text);
                            log('phone number: $phoneNumber');
                            final trimmedPhoneNumber =
                                phoneNumber.replaceAll("+", "%2B");
                            log("trimmed Phone number: $trimmedPhoneNumber");

                            //TODO: Clean up
                            ///!  endpoint: to get dealer user details
                            final idDealerCustomerDetailsFetched = await ref
                                .read(fetchDealerUserDetailsControllerProvider
                                    .notifier)
                                .getDealerUserDetails(
                                  phoneNumber: phoneNumber,
                                  dealerUserId: dealerIdentityController
                                          .data?.data?.id
                                          .toString() ??
                                      '',
                                );
                            if (idDealerCustomerDetailsFetched) {
                              log('---dealer user details retrived ---');
                              final customerId = ref
                                  .read(fetchDealerUserDetailsControllerProvider
                                      .notifier)
                                  .state
                                  .data
                                  ?.id;

                              ///!  endpoint: to generate reference
                              final isReferenceGenerated = await ref
                                  .read(generateReferenceControllerProvider
                                      .notifier)
                                  .generateReference(
                                      amount: widget.amount,
                                      userId: dealerIdentityController
                                              .data?.data?.dealerAuthId
                                              .toString() ??
                                          '',
                                      paymentMethod: "offline",
                                      transactionType: "debit");
                              if (isReferenceGenerated) {
                                final reference = ref
                                    .read(generateReferenceControllerProvider
                                        .notifier)
                                    .state
                                    .data;

                                ///! endpoint: Create digital order
                                final hasCreatedDigitalOrder = await ref
                                    .read(createDigitalOrderControllerProvider
                                        .notifier)
                                    .createDigitalOrders(
                                  reference: reference ?? '',
                                  userId: customerId ?? 0,
                                  dealerId:
                                      dealerIdentityController.data?.data?.id ??
                                          0,
                                  dealerUserId: dealerIdentityController
                                          .data?.data?.dealerAuthId ??
                                      0,
                                  amount: widget.amount,
                                  total: widget.amount,
                                  totalHrs: widget.totalHrs,
                                  paymentMethod: "offline",
                                  orderItems: [
                                    {
                                      "product_id": widget.productId,
                                      "order_quantity": 1,
                                      "unit_price": widget.amount,
                                      "subtotal": widget.amount,
                                      "item_name": widget.itemName,
                                      "total_hours": widget.totalHrs,
                                      "validity": widget.validity,
                                      "vendor_id": 0,
                                      "dealer_id": 1,
                                      "sub_dealer": 0,
                                      "discount": 0
                                    }
                                  ],
                                );
                                if (hasCreatedDigitalOrder) {
                                  log('---Digital order created succesfully ---');

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ConfirmOrderScreen(
                                      amount: widget.amount,
                                    );
                                  }));
                                } else {
                                  log('---Digital order created Unsuccesfully ---');
                                }
                              }
                            } else {
                              log('---dealer user details not  retrived ---');
                            }
                          },

                    label: 'Send',
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
