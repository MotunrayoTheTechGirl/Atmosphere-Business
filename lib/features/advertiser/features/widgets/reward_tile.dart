import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/cancel_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/advertiser/features/widgets/textfield_with_inline_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class RewardTile extends StatefulWidget {
  const RewardTile({Key? key}) : super(key: key);

  @override
  State<RewardTile> createState() => _RewardTileState();
}

class _RewardTileState extends State<RewardTile> {
  final rewardController = TextEditingController();
  final parameterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reward',
                style: AppTheme.lightTextTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              const CancelButton(),
            ],
          ),
          30.hi,
          Text(
            'Input the reward parameters',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.deepAsh,
                fontFamily: AppTheme.montserratAlternate,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          ),
          6.hi,
          TextfieldWithInlineLabel(
            controller: rewardController,
            readOnly: true,
            label: 'Rewards',
            hintText: 'Select',
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppColors.black,
            ),
            onTap: () async {
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(30, 400.h, 0, 60.w),
                color: AppColors.white,
                items: [
                  'Points',
                  'Hours',
                ].map((option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(option),
                    ),
                  );
                }).toList(),
              );
              if (selected != null) {
                rewardController.text = selected;
                setState(() {});
              }
            },
          ),
          10.hi,
          TextfieldWithInlineLabel(
            controller: parameterController,
            label: 'Parameter',
          ),
          20.hi,
          Align(
            alignment: Alignment.topRight,
            child: AppElevatedButton(
              onTap: () {},
              width: 88.w,
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
              label: 'Add more',
              labelFontSize: 13.sp,
              labelColor: AppColors.w5Color,
              bgColor: AppColors.w5Color.withOpacity(0.08),
              borderRadius: 4.r,
            ),
          ),
          20.hi,
          AppElevatedButton(
            onTap: () {},
            label: 'Submit',
          ),
        ],
      ),
    );
  }
}
