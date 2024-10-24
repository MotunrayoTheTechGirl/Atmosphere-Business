import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_drawer/custom_drawer.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/ui_helper.dart';
import '../../../billing/data/repository/billing_repository.dart';
import '../../../my_plans/data/controller/get_dealer_by_identity_controller.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../../../wallet/presentation/widgets/wallet_balance_card.dart';
import '../widgets/overview_card.dart';
import '../widgets/quick_link_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userDetailsControllerProvider.notifier).getUserDetails();
      await ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
      await ref
          .read(fetchDealerByIdentityControllerProvider.notifier)
          .dealerIdentity(
              phoneNumber: ref
                      .watch(userDetailsControllerProvider.notifier)
                      .state
                      .data
                      ?.data
                      ?.user
                      ?.phoneNumber ??
                  "");
    });

    super.initState();
  }

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
            fontSize: 16.sp,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.hi,
              Row(
                children: [
                  Text(
                    'Welcome back, ${formatFirstName(userDetailsController?.name ?? '')}',
                    style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.blackSupplementary,
                    ),
                  ),
                  8.wi,
                  Image.asset(
                    AppIcons.waveIcon,
                    width: 18.w,
                    height: 18.h,
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
              const WalletBalanceCard(),
              16.hi,
              const OverviewCard(),
              30.hi,
              Text(
                'Quick links',
                style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.black.withOpacity(0.6),
                ),
              ),
              8.hi,
              Text(
                'Essentials actions',
                style: AppTheme.lightTextTheme.displayMedium?.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighterText,
                    fontFamily: AppTheme.montserratAlternate),
              ),
              16.hi,
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  QuickLinksButton(
                    icon: AppIcons.access,
                    label: 'Access Control',
                    onTap: () {},
                  ),
                  QuickLinksButton(
                    icon: AppIcons.walletNew,
                    label: 'Wallet',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const WalletScreen();
                      }));
                    },
                  ),
                  QuickLinksButton(
                    icon: AppIcons.report,
                    label: 'Reports',
                    onTap: () {},
                  ),
                ],
              )
            ],
          ).padHorizontal(20),
        ),
      ),
    );
  }
}
