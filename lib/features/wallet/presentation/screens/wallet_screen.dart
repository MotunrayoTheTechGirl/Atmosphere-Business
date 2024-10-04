// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/wallet/data/repository/wallet_history_repo.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/screens/fund_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_history_tile.dart';
import 'wallet_history_screen.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
      ref.read(walletHistoryRepositoryFutureProvider(ref
              .watch(userDetailsControllerProvider.notifier)
              .state
              .data
              ?.data
              ?.user
              ?.id
              .toString() ??
          ''));
    });

    super.initState();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // Refresh wallet balance when app is resumed
  //     ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final walletHistoryController = ref.watch(
        walletHistoryRepositoryFutureProvider(ref
                .watch(userDetailsControllerProvider.notifier)
                .state
                .data
                ?.data
                ?.user
                ?.id
                .toString() ??
            ''));
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Wallet',
        suffixIcon: AppIcons.notification,
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
          child: RefreshIndicator.adaptive(
        onRefresh: () async {
          await ref
              .read(fetchUserBalanceControllerProvider.notifier)
              .userBalance();
          ref.read(walletHistoryRepositoryFutureProvider(ref
                  .watch(userDetailsControllerProvider.notifier)
                  .state
                  .data
                  ?.data
                  ?.user
                  ?.id
                  .toString() ??
              ''));
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  WalletBalanceCard(),
                  20.hi,
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FundWalletScreen();
                      }));
                      _refreshTimer =
                          Timer.periodic(Duration(seconds: 5), (timer) {
                        ref.read(fetchUserBalanceControllerProvider);
                      });
                      Future.delayed(Duration(minutes: 2), () {
                        _refreshTimer?.cancel();
                      });
                    },
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color:
                                  AppColors.textFieldBorder.withOpacity(0.5)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Fund Wallet',
                          style:
                              AppTheme.lightTextTheme.displayMedium?.copyWith(
                            fontSize: 15,
                            color: AppColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).padHorizontal(6),
                  ),
                  20.hi,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wallet History',
                        style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                            fontSize: 15,
                            color: AppColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return WalletHistoryScreen();
                            }),
                          );
                        },
                        child: Text(
                          'See all',
                          style:
                              AppTheme.lightTextTheme.displayMedium?.copyWith(
                            fontSize: 17,
                            color: AppColors.black.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  10.hi,
                  walletHistoryController.when(
                    data: (data) {
                      return SizedBox(
                        height: .4.sh,
                        child: data.data.isEmpty
                            ? Center(
                                child: Text(
                                    'You currently have no transaction history'),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17.0),
                                child: ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 17.0),
                                    itemBuilder: (context, index) {
                                      final history = data.data[index];
                                      return WalletHistoryTile(
                                        date: intl.DateFormat('dd/MM/yy')
                                            .format(history.createdAt ??
                                                DateTime.now()),
                                        dataPlan: history.note ?? '',
                                        amount: history.credit == "0"
                                            ? history.debit == "0"
                                                ? formatNaira(
                                                    history.debit ?? '')
                                                : '-${formatNaira(history.debit ?? '')}'
                                            : '+${formatNaira(history.credit ?? '')}',
                                        amountTextColor: history.credit == "0"
                                            ? AppColors.redShade500
                                            : AppColors.blackShade400,
                                        icon: history.credit == "0"
                                            ? AppIcons.redArrow
                                            : AppIcons.greenArrow,
                                        iconBgColor: history.credit == "0"
                                            ? AppColors.redShade200
                                            : AppColors.greenShade200
                                                .withOpacity(0.3),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        thickness: 0.2,
                                        color: Colors.black.withOpacity(0.5),
                                      );
                                    },
                                    itemCount: data.data.length),
                              ),
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
