// ignore_for_file: override_on_non_overriding_member, prefer_const_constructors

import 'dart:developer';

import 'package:dealer_portal_mobile/core/common_widgets/app_bars/primary_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/custom_snackbar.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/my_plans/data/models/captive_prd_res_model.dart';
import 'package:dealer_portal_mobile/features/my_plans/data/repository/my_plan_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/ui_helper.dart';
import '../../../wallet/presentation/widgets/wallet_balance_card.dart';
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
  String _selectedPlan = "All Plans";
  final List<String> plans = [
    "All Plans",
    "Atmosphere Plan",
    "Glo Cooperate gifting",
    "Mtn Cooperate gifting",
    "9mobile Cooperate gifting",
    "Airtel Cooperate gifting",
    "Glo Atmosphere plan",
  ];

  List<Datum> filterPlans(List<Datum> allPlans) {
    switch (_selectedPlan) {
      case "Glo Cooperate gifting":
        return allPlans
            .where((plan) =>
                plan.totalBandwidth!.isNotEmpty &&
                plan.isCombined == true &&
                plan.hours == 0 &&
                plan.vendorId == 2)
            .toList();

      case "Mtn Cooperate gifting":
        return allPlans
            .where((plan) =>
                plan.totalBandwidth!.isNotEmpty &&
                plan.isCombined == true &&
                plan.hours == 0 &&
                plan.vendorId == 1)
            .toList();

      case "9mobile Cooperate gifting":
        return allPlans
            .where((plan) =>
                plan.totalBandwidth!.isNotEmpty &&
                plan.isCombined == true &&
                plan.hours == 0 &&
                plan.vendorId == 3)
            .toList();

      case "Airtel Cooperate gifting":
        return allPlans
            .where((plan) =>
                plan.totalBandwidth!.isNotEmpty &&
                plan.isCombined == true &&
                plan.hours == 0 &&
                plan.vendorId == 4)
            .toList();

      case "Atmosphere Plan":
        return allPlans.where((plan) => plan.isCombined == false).toList();

      case "Glo Atmosphere plan":
        return allPlans
            .where((plan) =>
                plan.isCombined == true &&
                plan.totalBandwidth!.isNotEmpty &&
                (plan.hours ?? 0) > 0)
            .toList();

      default:
        return allPlans;
    }
  }

  @override
  Widget build(BuildContext context) {
    final captiveProductsController = ref.watch(captiveProductsFutureProvider);
    final dealerBalanceController =
        ref.watch(fetchUserBalanceControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:
          const PrimaryAppBar(title: 'Data Plans', icon: AppIcons.notification),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const DataBalanceCard(
            //   width: double.infinity,
            // ),
            const WalletBalanceCard(),
            // 20.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter By:',
                  style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                      color: AppColors.blackText.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp),
                ),
                10.wi,
                SizedBox(
                  width: 140.w,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                      icon: SvgPicture.asset(
                        AppIcons.arrowDown,
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                        ),
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.white,
                            width: 0,
                          ),
                        ),
                      ),
                      value: _selectedPlan,
                      items: plans.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: 100,
                            child: Text(
                              value,
                              style:
                                  AppTheme.lightTextTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.blackText,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedPlan = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            20.hi,
            captiveProductsController.when(
              data: (data) {
                final filteredPlans = filterPlans(data.data);
                if (filteredPlans.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        140.hi,
                        Text(
                          'This Plan is currently not availbale!',
                          style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                              color: AppColors.blackText,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                        140.hi,
                      ],
                    ),
                  );
                }
                return SizedBox(
                  height: .4.sh,
                  child: ListView.builder(
                    itemCount: filteredPlans.length,
                    itemBuilder: (context, index) {
                      final planList = filteredPlans.reversed.toList();
                      final plan = planList[index];

                      return DataPlanContainer(
                        productLogo: Image.asset(AppIcons.atmosphere),
                        allocation: plan.name ?? '',
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

                                // String newUsersBalance = data.hasBalance == "ooo" ? "0" : "";

                                if (!data.hasBalance) {
                                  log('This user is a new user without a balance');
                                  CustomSecondarySnackBar.showSnackBar(
                                      context: context,
                                      message:
                                          'Insufficient fund! Fund wallet to proceed',
                                      isError: true);
                                } else if (plan.price! >
                                    int.parse(dealerBalance)) {
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
