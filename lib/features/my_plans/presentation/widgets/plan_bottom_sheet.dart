// ignore_for_file: prefer_const_constructors

import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/plan_bottom_sheet_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Tested snackbar dispay on the a bottomSheet
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
Future<dynamic> planBottomSheet({
  required BuildContext parentContext,
  WidgetRef? ref,
  required Key key,
}) {
  return showModalBottomSheet(
    context: parentContext,
    enableDrag: true,
    showDragHandle: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              child: SizedBox(
                height: .3.sh,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    children: [
                      Text(
                        'Glo Atmosphere plan',
                        style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText,
                        ),
                      ),
                      18.hi,
                      PlanBottomSheetTile(
                        label: 'Edit plan',
                        icon: AppIcons.edit,
                        onTap: () {
                          // CustomSnackBar.showSnackBar(
                          //     context: context,
                          //     message:
                          //         'Insufficient Fund! Enter an amount less than your current balance');
                          scaffoldMessengerKey.currentState?.showSnackBar(
                            SnackBar(
                              // content: Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(5),
                              //   ),
                              //   child: const Text('Simple snackbar text.',
                              //       style: TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w300)),
                              // ),
                              // behavior: SnackBarBehavior.floating,
                              behavior: SnackBarBehavior.floating,
                              // margin: EdgeInsets.only(
                              //     // bottom: MediaQuery.of(context).size.height - 130,
                              //     bottom:
                              //         MediaQuery.of(context).size.height - 160,
                              //     right: 20.0,
                              //     left: 20.0),
                              backgroundColor: Colors.green,
                              content: const Text("Errorrrr!"),
                            ),
                          );
                        },
                      ),
                      10.hi,
                      PlanBottomSheetTile(
                        label: 'Delete Plan',
                        labelColor: AppColors.red,
                        icon: AppIcons.delete,
                        iconColor: AppColors.red,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    },
  );
}
