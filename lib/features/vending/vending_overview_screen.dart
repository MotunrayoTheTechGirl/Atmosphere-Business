import 'package:dealer_portal_mobile/core/common_widgets/app_bars/menu_appbar.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/vending/common_widget/vending_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../core/common_widgets/app_divider.dart';
import '../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/themes/app_themes.dart';
import '../../core/utils/ui_helper.dart';
import '../billing/data/repository/billing_repository.dart';
import '../billing/presentation/widgets/billing_tile.dart';
import '../onboarding/data/controller/user_details_controller.dart';

class VendingOverviewScreen extends ConsumerStatefulWidget {
  VendingOverviewScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _VendingOverviewScreenState createState() => _VendingOverviewScreenState();
}

class _VendingOverviewScreenState extends ConsumerState<VendingOverviewScreen> {
  final List<String> _timeFrames = ['Daily', 'Weekly', 'Monthly'];
  String _selectedTimeFrame = 'Weekly';
  @override
  Widget build(BuildContext context) {
    final invoiceController = ref.watch(billingRepositoryFutureProvider);
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MenuAppBar(title: 'Vending'),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              10.hi,
              // SizedBox(
              //   height: 200.h,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       const AvailableDataBalanceCard().padOnly(right: 16),
              //       const UsageCard(),
              //     ],
              //   ),
              // ).padOnly(left: 20),
              // 6.hi,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter by:',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackText,
                    ),
                  ),
                  SizedBox(
                    width: 92.w,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                        icon: SvgPicture.asset(
                          AppIcons.arrowDown,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.h,
                            horizontal: 10.w,
                          ),
                        ),
                        value: _selectedTimeFrame,
                        items: _timeFrames.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: AppTheme.lightTextTheme.bodySmall
                                  ?.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.blackText,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppTheme.montserratAlternate),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedTimeFrame = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              10.hi,
              const VendingOverviewCard(
                title: 'Plan Amount Sold',
                amount: '3465',
                suffixNumber: '+234 ',
                suffixColor: AppColors.green,
              ),
              16.hi,
              const VendingOverviewCard(
                title: 'Total Orders',
                amount: '10000',
                suffixNumber: '-134 ',
                suffixColor: AppColors.red,
              ),
              16.hi,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invoice history',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        color: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp),
                  ),
                  Text(
                    'See all',
                    style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                        color: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp),
                  ),
                ],
              ),
              16.hi,
              invoiceController.when(
                data: (data) {
                  return SizedBox(
                    height: .5.sh,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final dataList = data.reversed.toList();

                        final invoice = dataList[index];
                        String duration = invoice.createdAt.toString();
                        DateTime dateTime = DateTime.parse(duration);
                        String formattedDate = DateFormat('hh:mm a, dd MMM')
                            .format(dateTime.toLocal());
                        return BillingTile(
                          onTap: () {},
                          duration: formattedDate,
                          id: 'INV-${invoice.id}',
                          price: formatNaira(
                            invoice.amount ?? '',
                          ),
                          dataPlan: 'Data Plan',
                          name: userDetailsController?.name,
                          status: invoice.paymentStatus ?? '',
                          statusColorBg: invoice.paymentStatus == 'pending'
                              ? AppColors.redShade50
                              : AppColors.greenShade50,
                          statusColor: invoice.paymentStatus == 'pending'
                              ? AppColors.red
                              : AppColors.green,
                        );
                      },
                      itemCount: data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const AppDivider();
                      },
                    ),
                  );
                },
                error: (e, str) {
                  return const Text('Oops! something went wrong');
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
          ).padHorizontal(20),
        ),
      ),
    );
  }
}
