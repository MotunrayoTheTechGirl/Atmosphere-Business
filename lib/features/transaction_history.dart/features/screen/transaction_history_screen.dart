import 'package:dealer_portal_mobile/core/common_widgets/app_drawer/custom_drawer.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/transaction_history.dart/features/screen/history_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../wallet/data/controller/wallet_history_controller.dart';
import '../../../wallet/presentation/widgets/wallet_history_tile.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(walletHistoryControllerProvider.notifier).fetchWalletHistory();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final walletHistoryController = ref.watch(walletHistoryControllerProvider);
    final searchController = TextEditingController();
    // final historyController =
    //     ref.watch(transactionHistoryFutureProvider(userId));
    return Scaffold(
      appBar: const MenuAppBar(
        title: "Transaction History",
      ),
      drawer: const CustomDrawer(),
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
                child: walletHistoryController.when(
                  data: (data) {
                    return SizedBox(
                      height: .4.sh,
                      child: data.data.isEmpty
                          ? const Center(
                              child: Text(
                                  'You currently have no transaction history'),
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              itemBuilder: (context, index) {
                                final history = data.data[index];
                                String duration = history.createdAt.toString();
                                DateTime dateTime = DateTime.parse(duration);
                                // String formattedDate =
                                //     DateFormat('hh:mm a, dd MMM')
                                //         .format(dateTime.toLocal());
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
                                    "${dateTime.year}, ";

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return HistoryDetailsScreen(
                                        transactionId: history.id.toString(),
                                        description: history.note ?? '',
                                        date: detailsDate,
                                        amount: history.transactionType ==
                                                "credit"
                                            ? formatNaira(history.debit ?? '')
                                            : formatNaira(history.debit ?? ''),
                                        time: DateFormat('h : mm a')
                                            .format(dateTime),
                                        transactionType:
                                            history.transactionType == "credit"
                                                ? "credit"
                                                : "debit",
                                      );
                                    }));
                                  },
                                  child: WalletHistoryTile(
                                    date: intl.DateFormat('dd/MM/yy').format(
                                        history.createdAt ?? DateTime.now()),
                                    dataPlan: history.note ?? '',
                                    amount: history.transactionType == "credit"
                                        ? '+${formatNaira(history.debit ?? '')}'
                                        : '-${formatNaira(history.debit ?? '')}',
                                    amountTextColor:
                                        history.transactionType == "credit"
                                            ? AppColors.blackShade400
                                            : AppColors.redShade500,
                                    icon: history.transactionType == "credit"
                                        ? AppIcons.greenArrow
                                        : AppIcons.redArrow,
                                    iconBgColor:
                                        history.transactionType == "credit"
                                            ? AppColors.greenShade200
                                                .withOpacity(0.2)
                                            : AppColors.redShade200,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 0.2,
                                  color: Colors.black.withOpacity(0.5),
                                );
                              },
                              itemCount: data.data.length),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: SpinKitSpinningLines(
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                  error: (error, str) {
                    return const Center(
                      child: Text('Oops! something went wrong'),
                    );
                  },
                ),
              )
            ],
          ).padHorizontal(16),
        ),
      ),
    );
  }
}
