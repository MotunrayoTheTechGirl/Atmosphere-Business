// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/subscriptions/logic/selected_data_pack_notifier.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/custom_table_header.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/data_hour_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_elevated_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../data/controller/create_order_controller.dart';
import '../../data/controller/generate_reference_controller.dart';
import '../../data/models/get_digital_products_res_model.dart';
import '../screens/invoice_screen.dart';

Future<dynamic> subsriptionBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        final selectedProducts = ref
            .watch(selectedDataProvider)
            .where((product) => product.isSelected)
            .toList();
        final userDetailsController =
            ref.watch(userDetailsControllerProvider).data?.data?.user;
        // log('Selected Products: $selectedProducts');
        final total = selectedProducts.fold(
            0.0, (sum, product) => sum + (product.price ?? 0));
        final totalHours = selectedProducts.fold(
            0, (sum, product) => sum + (product.hours ?? 0));
        return SingleChildScrollView(
          child: SizedBox(
            height: .7.sh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  Text(
                    'Selected data hours',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(),
                  ),
                  18.hi,
                  const CustomTableHeader(),
                  SizedBox(
                    height: .2.sh,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final prd = selectedProducts[index];
                        return DataHourTile(
                          plan: prd.name ?? '',
                          quantity: prd.hours.toString(),
                          amount: formatNaira(prd.price.toString()),
                          isSelected: prd.isSelected,
                          onRemove: () {
                            ref
                                .read(selectedDataProvider.notifier)
                                .toggleSelection(prd);
                            log('clicked');
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: AppColors.dividerColor,
                        );
                      },
                      itemCount: selectedProducts.length,
                    ),
                  ),
                  5.hi,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                      Text(
                        formatNaira(total.toString()),
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                  14.hi,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AppElevatedButton(
                      label: 'Generate Invoice',
                      isLoading: ref
                              .watch(generateReferenceControllerProvider)
                              .status ==
                          ResponseStatus.loading,
                      //     ||
                      // ref
                      //         .watch(createDigitalOrderControllerProvider)
                      //         .status ==
                      //     ResponseStatus.loading,
                      onTap: () async {
                        Map<String, dynamic> productToOrder(
                            DigitalProductsResModel product) {
                          return {
                            "product_id": product.id,
                            "order_quantity": 1,
                            "unit_price": product.price,
                            "subtotal": product.price,
                            "item_name": product.name,
                            "total_hours": product.hours,
                            "validity": product.totalValidity,
                            "vendor_id": 0,
                            "dealer_id": 1,
                            "sub_dealer": 0,
                            "product_type": "dealer",
                            "discount": 0
                          };
                        }

                        final generateReference = await ref
                            .read(generateReferenceControllerProvider.notifier)
                            .generateReference(
                              amount: total,
                              userId:
                                  userDetailsController?.id.toString() ?? '',
                              paymentMethod: "offline",
                            );
                        log('joromi: $generateReference');

                        if (generateReference) {
                          final reference = ref
                              .read(
                                  generateReferenceControllerProvider.notifier)
                              .state
                              .data;
                          log('joro: $reference');
                          log('..Kolo...');

                          List<Map<String, dynamic>> orderItems =
                              selectedProducts
                                  .map((product) => productToOrder(product))
                                  .toList();
                          // log('OrderItems: $orderItems');
                          final createOrder = await ref
                              .read(
                                  createDigitalOrderControllerProvider.notifier)
                              .createDigitalOrders(
                                reference: reference ?? '',
                                userId: userDetailsController?.id ?? 0,
                                dealerId: userDetailsController?.id ?? 0,
                                dealerUserId: userDetailsController?.id ?? 0,
                                amount: total,
                                total: total,
                                totalHrs: totalHours,
                                orderItems: orderItems,
                                paymentMethod: "offline",
                              );
                          if (createOrder) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const InvoiceScreen();
                                },
                              ),
                            );
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const InvoiceScreen();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
