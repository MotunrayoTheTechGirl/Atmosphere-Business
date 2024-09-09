// ignore_for_file: must_be_immutable

import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/features/app/data/controller/app_controller.dart';
import 'package:dealer_portal_mobile/features/billing/presentation/screens/billing_screen.dart';
import 'package:dealer_portal_mobile/features/create_plan/presentation/screens/create_plan_screen.dart';
import 'package:dealer_portal_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/screens/my_plans_screen.dart';
import 'package:dealer_portal_mobile/features/onboarding/data/controller/user_details_controller.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/screens/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/navbar_item.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  List<Widget> screens = [
    HomeScreen(),
    const SubscriptionScreen(),
    const CreatePlanScreen(),
    const MyPlansScreen(),
    BillingScreen(),
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userDetailsControllerProvider.notifier).getUserDetails();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 1
                  ? AppIcons.activeSubs
                  : AppIcons.subscriptions,
              onTap: () {
                ref.read(appControllerProvider).newPageIndex = 1;
              },
              label: 'Subscriptions',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 1,
            ),
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 2
                  ? AppIcons.createPlan
                  : AppIcons.createPlan,
              onTap: () {
                ref.watch(appControllerProvider).newPageIndex = 2;
              },
              label: 'Create plan',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 2,
            ),
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 3
                  ? AppIcons.myPlans
                  : AppIcons.myPlans,
              onTap: () {
                ref.read(appControllerProvider).newPageIndex = 3;
              },
              label: 'My plans',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 3,
            ),
            NavbarItem(
              icon: ref.watch(appControllerProvider.notifier).pageListIndex == 4
                  ? AppIcons.billing
                  : AppIcons.billing,
              onTap: () {
                ref.read(appControllerProvider).newPageIndex = 4;
              },
              label: 'Billing',
              isActive:
                  ref.watch(appControllerProvider.notifier).pageListIndex == 4,
            ),
          ],
        ),
      ),
      body: screens[ref.watch(appControllerProvider).pageListIndex],
    );
  }
}
