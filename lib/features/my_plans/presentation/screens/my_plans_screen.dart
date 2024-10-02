import 'dart:developer';

import 'package:dealer_portal_mobile/core/common_widgets/app_bars/primary_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/custom_snackbar.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/my_plans/data/repository/my_plan_repository.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/data_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/ui_helper.dart';
import '../../data/controller/user_balance_controller.dart';
import '../widgets/assign_to_customer_bottom_sheet.dart';
import '../widgets/data_plan_container.dart';

class MyPlansScreen extends ConsumerStatefulWidget {
  const MyPlansScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPlansScreen> createState() => _MyPlansScreenState();
}

class _MyPlansScreenState extends ConsumerState<MyPlansScreen> {
  @override
  final String _selectedPlan = "All";
  final List<String> plans = [
    "All",
    "Atmosphere Plan",
    "Glo Atmosphere Plan",
    "Glo Cooperate gifting",
  ];
  @override
  Widget build(BuildContext context) {
    final captiveProductsController = ref.watch(captiveProductsFutureProvider);
    final dealerBalanceController =
        ref.watch(fetchUserBalanceControllerProvider);
    return Scaffold(
      appBar:
          const PrimaryAppBar(title: 'Data Plans', icon: AppIcons.notification),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DataBalanceCard(
              width: double.infinity,
            ),
            // 30.hi,
            // AppElevatedButton(
            //   onTap: () {},
            //   isLightBlue: true,
            //   rowIcon: AppIcons.plusBox,
            //   rowLabel: 'Create Data Plan',
            //   rowLabelColor: AppColors.primaryColor,
            // ).padHorizontal(14),
            20.hi,
            Row(
              children: [
                Text(
                  'My plans',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                    color: AppColors.lighterText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(
                //   width: 140.w,
                //   child: DropdownButtonHideUnderline(
                //     child: Directionality(
                //       textDirection: TextDirection.ltr,
                //       child: DropdownButtonFormField<String>(
                //         icon: SvgPicture.asset(
                //           AppIcons.arrowDown,
                //           color: AppColors.black,
                //         ),
                //         decoration: InputDecoration(
                //           fillColor: AppColors.white,
                //           contentPadding: EdgeInsets.symmetric(
                //             horizontal: 8.w,
                //           ),
                //           filled: true,
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(6),
                //             borderSide: const BorderSide(
                //               color: AppColors.greyText,
                //               width: 0.5,
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(6),
                //             borderSide: const BorderSide(
                //               color: AppColors.greyText,
                //               width: 0.5,
                //             ),
                //           ),
                //         ),
                //         value: _selectedPlan,
                //         items: plans.map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: SizedBox(
                //               width: 110.w,
                //               child: Text(
                //                 value,
                //                 style:
                //                     AppTheme.lightTextTheme.bodySmall?.copyWith(
                //                   fontSize: 12.sp,
                //                   color: AppColors.black,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //                 overflow: TextOverflow.ellipsis,
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //         onChanged: (String? newValue) {
                //           if (newValue != null) {
                //             setState(() {
                //               _selectedPlan = newValue;
                //               // initialTimeFrame = newValue;
                //             });
                //             // fetchData(newValue);
                //           }
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            20.hi,
            captiveProductsController.when(
              data: (data) {
                return SizedBox(
                  height: .4.sh,
                  child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final planList = data.data.reversed.toList();
                      final plan = planList[index];
                      return DataPlanContainer(
                        productLogo: Image.asset(AppIcons.atmosphere),
                        allocation: plan.name ?? '',
                        // '${plan.hours}${plan.hours! > 1 ? 'Hrs' : 'Hr'} + ${plan.totalBandwidth}',

                        // () {
                        //   switch (plan.name) {
                        //     case "Glo atmosphere data plan":
                        //       return '${plan.hours}Hrs + ${plan.totalBandwidth}';
                        //     case "Glo data plan":
                        //       return '${plan.description}';
                        //     case "Daily Subscription":
                        //       // return '${plan.hours > 1 ? '' : ''}Hrs';
                        //       return '${plan.hours}${plan.hours! > 1 ? 'Hrs' : 'Hr'}';
                        //     default:
                        //       return '';
                        //   }
                        // }(),
                        price: formatNaira(plan.price.toString()),
                        validity: '${plan.totalValidity}days',
                        onTap: () {
                          // final dealerBalance = dealerBalanceController
                          //         .data?.balance?.isDealerWalletBalance ??
                          //     '';

                          dealerBalanceController.when(
                              data: (data) {
                                final dealerBalance =
                                    data.balance?.isDealerWalletBalance ?? '';
                                if (plan.price! > int.parse(dealerBalance)) {
                                  log('Amount is greater than wallet balance');
                                  CustomSecondarySnackBar.showSnackBar(
                                      context: context,
                                      message:
                                          'Insufficient fund! Fund wallet to proceed',
                                      isError: true);
                                } else {
                                  assignToCustomerBottomSheet(
                                    context: context,
                                    ref: ref,
                                    amount: plan.price ?? 0,
                                    totalHrs: plan.hours ?? 0,
                                    productId: plan.id ?? 0,
                                    itemName: plan.name ?? '',
                                    validity: plan.totalValidity ?? 0,
                                  );
                                }
                              },
                              error: (error, str) {},
                              loading: () {});

                          // if (plan.price! > int.parse(dealerBalance)) {
                          //   log('Amount is greater than wallet balance');
                          //   CustomSecondarySnackBar.showSnackBar(
                          //       context: context,
                          //       message:
                          //           'Insufficient fund! Fund wallet to proceed',
                          //       isError: true);
                          // } else {
                          //   assignToCustomerBottomSheet(
                          //     context: context,
                          //     ref: ref,
                          //     amount: plan.price ?? 0,
                          //     totalHrs: plan.hours ?? 0,
                          //     productId: plan.id ?? 0,
                          //     itemName: plan.name ?? '',
                          //     validity: plan.totalValidity ?? 0,
                          //   );
                          // }
                        },
                      ).padBottom(10);
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return const Center(
                  child: Text('Oops! something went wrong'),
                );
              },
              loading: () {
                return const Center(
                  child: SpinKitSpinningLines(
                    color: AppColors.primaryColor,
                  ),
                );
              },
            ),
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
