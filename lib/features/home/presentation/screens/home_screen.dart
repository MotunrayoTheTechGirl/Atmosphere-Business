import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/custom_drawer.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../billing/data/repository/billing_repository.dart';
import '../../../billing/presentation/widgets/billing_tile.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../widgets/overview_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final invoiceController = ref.watch(billingRepositoryFutureProvider);
    final userDetailsController =
        ref.watch(userDetailsControllerProvider).data?.data?.user;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset(
              AppIcons.menu,
              fit: BoxFit.scaleDown,
            ),
          ).padOnly(left: 12);
        }),
        title: Text(
          'Overview',
          style: AppTheme.lightTextTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.blackText,
          ),
        ),
        actions: [
          SvgPicture.asset(AppIcons.notification).padOnly(right: 20),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              10.hi,
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
                  // SizedBox(
                  //   width: 92.w,
                  //   child: DropDownFormField(
                  //     dropDownList: const ['Daily', 'Weekly', 'Monthly'],
                  //     selectedListItem: 'Weekly',
                  //   ),
                  // ),
                ],
              ),
              10.hi,
              const OverviewCard(
                title: 'Plan Amount Sold',
                amount: '3465',
                suffixNumber: '+234 ',
                icon: AppIcons.greenGraph,
                suffixColor: AppColors.green,
              ),
              16.hi,
              const OverviewCard(
                title: 'Total Revenue',
                amount: '10000',
                suffixNumber: '-134 ',
                icon: AppIcons.redGraph,
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
                    height: .3.sh,
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
