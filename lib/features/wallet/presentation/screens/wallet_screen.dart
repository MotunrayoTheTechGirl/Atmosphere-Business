// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/screens/transaction_history_screen.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/widgets/wallet_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/common_widgets/app_bars/menu_appbar.dart';
import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../data/controller/wallet_history_controller.dart';
import '../widgets/fund_wallet_button.dart';
import '../widgets/wallet_history_tile.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
      ref.read(walletHistoryControllerProvider.notifier).fetchWalletHistory();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final walletHistoryController = ref.watch(walletHistoryControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: MenuAppBar(
        title: "Wallet",
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await ref
              .read(fetchUserBalanceControllerProvider.notifier)
              .userBalance();
          ref
              .read(walletHistoryControllerProvider.notifier)
              .fetchWalletHistory();
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  10.hi,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Overview',
                      style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ).padOnly(left: 8),
                  8.hi,
                  WalletBalanceCard(),
                  32.hi,
                  FundWalletButton(),
                  10.hi,
                  Divider(
                    thickness: 0.2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  10.hi,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wallet History',
                        style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                            fontSize: 15.sp,
                            color: AppColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return TransactionHistoryScreen();
                            }),
                          );
                        },
                        child: Text(
                          'See all',
                          style:
                              AppTheme.lightTextTheme.displayMedium?.copyWith(
                            fontSize: 17.sp,
                            color: AppColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  walletHistoryController.when(
                    data: (data) {
                      return SizedBox(
                        height: .5.sh,
                        child: data.data.isEmpty
                            ? Center(
                                child: Text(
                                    'You currently have no transaction history'),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                itemBuilder: (context, index) {
                                  final history = data.data[index];
                                  return WalletHistoryTile(
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
                ],
              ),
            ),
          ],
        ).padHorizontal(16),
      )),
    );
  }
}
