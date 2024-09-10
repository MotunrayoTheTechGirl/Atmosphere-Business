import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/transaction_history.dart/features/screen/history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_divider.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../billing/presentation/widgets/billing_tile.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../data/repository/transaction_history_repository.dart';

class TransactionHistoryScreen extends ConsumerWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    final userId =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.id ?? 0;
    final firstName =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.firstName ??
            0;
    final lastName =
        ref.watch(userDetailsControllerProvider).data?.data?.user?.lastName ??
            0;
    final historyController =
        ref.watch(transactionHistoryFutureProvider(userId));
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Transaction History',
        suffixIcon: AppIcons.notification,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.hi,
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
                radius: 16.r,
                fillColor: AppColors.tabBarColor,
                controller: searchController,
                hintText: 'Search history',
                hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                suffixIcon: SvgPicture.asset(
                  AppIcons.search,
                  fit: BoxFit.scaleDown,
                  height: 20,
                  width: 20,
                ),
              ),
              10.hi,
              SizedBox(
                height: .7.sh,
                child: historyController.when(data: (data) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final history = data.data[index];
                      String duration = history.createdAt.toString();
                      DateTime dateTime = DateTime.parse(duration);
                      String formattedDate = DateFormat('hh:mm a, dd MMM')
                          .format(dateTime.toLocal());

                      DateTime convertDate = DateTime.parse(duration);
                      String formatDayWithSuffix(int day) {
                        if (day >= 11 && day <= 13) {
                          return '${day}th';
                        }
                        switch (day % 10) {
                          case 1:
                            return '${day}st';
                          case 2:
                            return '${day}nd';
                          case 3:
                            return '${day}rd';
                          default:
                            return '${day}th';
                        }
                      }

                      String detailsDate =
                          "${formatDayWithSuffix(dateTime.day)} "
                          "${DateFormat('MMMM').format(dateTime)} "
                          "${dateTime.year}, "
                          "${DateFormat('h:mm a').format(dateTime)}";

                      return BillingTile(
                        id: history.transactionReference.toString(),
                        dataPlan: 'Data Plan',
                        price: formatNaira(
                          history.total.toString(),
                        ),
                        duration: formattedDate,
                        name: '$firstName $lastName',
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HistoryDetailsScreen(
                              orderId: history.id.toString(),
                              price: formatNaira(
                                history.total.toString(),
                              ),
                              validity: history.validity.toString(),
                              dateTime: detailsDate,
                              amount: formatNaira(
                                history.total.toString(),
                              ),
                              // status: history.orderStatus ?? '',
                            );
                          }));
                        },
                      );
                    },
                    itemCount: data.data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const AppDivider();
                    },
                  );
                }, error: (error, stackTrace) {
                  return Text(error.toString());
                }, loading: () {
                  return const Center(
                    child: SpinKitSpinningLines(
                      color: AppColors.primaryColor,
                    ),
                  );
                }),
              ),
            ],
          ).padHorizontal(16),
        ),
      ),
    );
  }
}
