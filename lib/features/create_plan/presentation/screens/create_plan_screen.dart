import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/create_plan/presentation/widgets/textfiel_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/utils/app_icons.dart';

class CreatePlanScreen extends StatelessWidget {
  CreatePlanScreen({Key? key}) : super(key: key);
  final planController = TextEditingController();
  final priceController = TextEditingController();
  final volumeController = TextEditingController();
  final wifiTimeController = TextEditingController();
  final validityPeriodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Create Data Plan',
        suffixIcon: AppIcons.delete,
        icon: SizedBox.shrink(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hi,
            const TextFieldLabel(label: 'Plan name'),
            10.hi,
            AppTextField(
              radius: 14,
              filled: false,
              controller: planController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'Enter name',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(
                  0.5,
                ),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            20.hi,
            const TextFieldLabel(
              label: 'Price',
            ),
            10.hi,
            AppTextField(
              keyboardType: TextInputType.number,
              radius: 14,
              filled: false,
              controller: priceController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'Enter amount',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(
                  0.5,
                ),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 0,
                ),
                child: SizedBox(
                  width: 80,
                  height: 20.h,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 6,
                        ),
                        child: VerticalDivider(
                          color: AppColors.dividerColor,
                        ),
                      ),
                      6.wi,
                      Text(
                        'NGN',
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  left: 12,
                ),
                child: Text(
                  '₦',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.textFieldBorder.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            20.hi,
            const TextFieldLabel(label: 'Data Volume'),
            10.hi,
            AppTextField(
              keyboardType: TextInputType.number,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  width: 90,
                  height: 20.h,
                  child: Row(
                    children: [
                      Text(
                        'GB',
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText,
                        ),
                      ),
                      8.wi,
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 18,
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SvgPicture.asset(AppIcons.arrowUp),
                              4.hi,
                              SvgPicture.asset(AppIcons.arrowDownn),
                            ],
                          ),
                        ),
                      ),
                      8.wi,
                      const VerticalDivider(
                        color: AppColors.dividerColor,
                      ),
                    ],
                  ),
                ),
              ),
              radius: 14,
              filled: false,
              controller: volumeController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'Eg. 20',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(
                  0.5,
                ),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder,
              ),
            ),
            20.hi,
            const TextFieldLabel(label: 'Allocated Atmosphere Wi-Fi time'),
            10.hi,
            AppTextField(
              keyboardType: TextInputType.number,
              radius: 14,
              filled: false,
              controller: priceController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: '',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Text(
                  'HRS',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                    color: AppColors.greyText,
                  ),
                ),
              ),
            ),
            20.hi,
            const TextFieldLabel(label: 'Validity period'),
            10.hi,
            AppTextField(
              keyboardType: TextInputType.number,
              radius: 14,
              filled: false,
              controller: priceController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: '',
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Text(
                  'Days',
                  style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.greyText,
                  ),
                ),
              ),
            ),
            30.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevatedButton(
                  width: 160.w,
                  onTap: () {},
                  rowLabel: 'Cancel',
                  isLightBlue: true,
                  rowLabelColor: AppColors.lightBlue,
                ),
                AppElevatedButton(
                  width: 160.w,
                  onTap: () {},
                  label: 'Create Plan',
                ),
              ],
            ),
          ],
        ).padHorizontal(16)),
      ),
    );
  }
}
