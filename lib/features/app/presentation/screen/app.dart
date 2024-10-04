// ignore_for_file: must_be_immutable

import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/features/app/data/controller/app_controller.dart';
import 'package:dealer_portal_mobile/features/billing/presentation/screens/billing_screen.dart';
import 'package:dealer_portal_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/screens/my_plans_screen.dart';
import 'package:dealer_portal_mobile/features/onboarding/data/controller/user_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../my_plans/data/controller/get_dealer_by_identity_controller.dart';
import '../../../my_plans/data/controller/user_balance_controller.dart';
import '../widgets/navbar_item.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  List<Widget> screens = [
    HomeScreen(),
    // const SubscriptionScreen(),
    // const CreatePlanScreen(),
    const MyPlansScreen(),
    BillingScreen(),
  ];
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
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: const BoxDecoration(
          color: AppColors.selectedColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 0
                  ? AppIcons.activeHomeNew
                  : AppIcons.home,
              isPng:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 0,
              onTap: () {
                ref.read(appControllerProvider).newPageIndex = 0;
              },
              label: 'Home',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 0,
            ),
            // NavbarItem(
            //   icon: ref.watch(appControllerProvider.notifier).pageListIndex == 1
            //       ? AppIcons.activeSubs
            //       : AppIcons.subscriptions,
            //   onTap: () {
            //     ref.read(appControllerProvider).newPageIndex = 1;
            //   },
            //   label: 'Subscriptions',
            //   isActive:
            //       ref.watch(appControllerProvider.notifier).pageListIndex == 1,
            // ),
            // NavbarItem(
            //   icon: ref.watch(appControllerProvider.notifier).pageListIndex == 2
            //       ? AppIcons.createPlan
            //       : AppIcons.createPlan,
            //   onTap: () {
            //     ref.watch(appControllerProvider).newPageIndex = 2;
            //   },
            //   label: 'Create plan',
            //   isActive:
            //       ref.watch(appControllerProvider.notifier).pageListIndex == 2,
            // ),
            NavbarItem(
                icon:
                    ref.watch(appControllerProvider.notifier).pageListIndex == 1
                        ? AppIcons.myPlans
                        : AppIcons.myPlans,
                onTap: () {
                  ref.read(appControllerProvider).newPageIndex = 1;
                },
                label: 'My plans',
                isActive:
                    ref.watch(appControllerProvider.notifier).pageListIndex ==
                        1),
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 2
                  ? AppIcons.billing
                  : AppIcons.billing,
              onTap: () {
                ref.read(appControllerProvider).newPageIndex = 2;
              },
              label: 'Billing',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 2,
            ),
          ],
        ),
      ),
      body: screens[ref.watch(appControllerProvider).pageListIndex],
    );
  }
}
