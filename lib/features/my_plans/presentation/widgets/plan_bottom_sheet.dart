import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/app_icons.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/plan_bottom_sheet_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> planBottomSheet({
  required BuildContext context,
  WidgetRef? ref,
}) {
  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
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
                    onTap: () {},
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
        );
      });
    },
  );
}
