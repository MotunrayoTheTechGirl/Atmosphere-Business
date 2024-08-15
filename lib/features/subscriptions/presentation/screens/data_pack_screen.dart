import 'package:dealer_portal_mobile/core/common_widgets/app_bars/custom_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/data_pack_card.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/subscription_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_tab_bar.dart';

class DataPackScreen extends StatefulWidget {
  const DataPackScreen({Key? key}) : super(key: key);

  @override
  _DataPackScreenState createState() => _DataPackScreenState();
}

class _DataPackScreenState extends State<DataPackScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Buy data pack',
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            28.hi,
            Center(
              child: Text(
                'Choose one or more plans to purchase',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  color: AppColors.textColor,
                ),
              ),
            ),
            20.hi,
            CustomPrimaryTabbar(
              controller: _tabController,
              tabs: const [
                Text('All plans'),
                Text('Atmosphere'),
              ],
            ),
            SizedBox(
              height: .8.sh,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SizedBox(
                    height: .6.sh,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: .5.sh,
                            child: GridView.builder(
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 12.w,
                                // mainAxisExtent: 240,
                                mainAxisExtent: .3.sh,
                                // mainAxisExtent: .3.sh,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return const DataPackCard();
                              },
                            ),
                          ),
                          20.hi,
                          AppElevatedButton(
                            label: 'Buy selected plans',
                            onTap: () {
                              subsriptionBottomSheet(context: context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ).padOnly(
                    top: 20,
                  ),
                  SizedBox(
                    height: .5.sh,
                  ),
                ],
              ),
            ),
          ],
        ).padHorizontal(
          16,
        ),
      )),
    );
  }
}
