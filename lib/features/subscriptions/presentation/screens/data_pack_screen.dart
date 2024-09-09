import 'package:dealer_portal_mobile/core/common_widgets/app_bars/custom_appbar.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/core/utils/ui_helper.dart';
import 'package:dealer_portal_mobile/features/subscriptions/data/repository/digital_prd_repository.dart';
import 'package:dealer_portal_mobile/features/subscriptions/logic/selected_data_pack_notifier.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/data_pack_card.dart';
import 'package:dealer_portal_mobile/features/subscriptions/presentation/widgets/subscription_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';

import '../../../../core/common_widgets/custom_tab_bar.dart';

class DataPackScreen extends ConsumerStatefulWidget {
  const DataPackScreen({Key? key}) : super(key: key);

  @override
  _DataPackScreenState createState() => _DataPackScreenState();
}

class _DataPackScreenState extends ConsumerState<DataPackScreen>
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
    var logger = Logger(
      printer: PrettyPrinter(),
    );
    final digitalPrdController = ref.watch(fetchDigitalPrdProvider);
    final selectDataController = ref.watch(selectedDataProvider);

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
                    child: digitalPrdController.when(
                      data: (data) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: .5.sh,
                                child: data.isEmpty
                                    ? const Center(
                                        child: Text('Empty!!'),
                                      )
                                    : GridView.builder(
                                        primary: false,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10.h,
                                          crossAxisSpacing: 12.w,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final product = data[index];
                                          final isSelected =
                                              selectDataController.any(
                                            (prd) => prd.id == product.id,
                                          );
                                          return DataPackCard(
                                            name: product.name ?? '',
                                            description:
                                                product.description ?? '',
                                            price: formatNaira(
                                                product.price.toString()),
                                            isSelected: isSelected,
                                            onTap: () {
                                              ref
                                                  .read(selectedDataProvider
                                                      .notifier)
                                                  .toggleSelection(product);
                                              // log('toggle: $selectDataController');
                                            },
                                          );
                                        },
                                      ),
                              ),
                              20.hi,
                              AppElevatedButton(
                                label: 'Buy selected plans',
                                isActive: selectDataController.isNotEmpty,
                                onTap: selectDataController.isEmpty
                                    ? () {}
                                    : () {
                                        subsriptionBottomSheet(
                                            context: context, ref: ref);
                                      },
                              ),
                            ],
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        logger.i('error: ${error.toString()}');
                        return const Center(
                          child: Text('Oops! something went wrong'),
                        );
                      },
                      loading: () {
                        return const SpinKitSpinningLines(
                          color: AppColors.primaryColor,
                        );
                      },
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
