// ignore_for_file: library_private_types_in_public_api

import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../core/common_widgets/app_text_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';
import '../widgets/subscription_bottom_sheet.dart';

class CustomizeHoursScreen extends StatefulWidget {
  const CustomizeHoursScreen({Key? key}) : super(key: key);

  @override
  _CustomizeHoursScreenState createState() => _CustomizeHoursScreenState();
}

class _CustomizeHoursScreenState extends State<CustomizeHoursScreen> {
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Buy custom volume',
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
              AppTextField(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 8,
                ),
                radius: 16.r,
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: AppColors.textColor,
                ),
                controller: amountController,
                hintText: "Amount",
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 10),
                  child: Text(
                    'NGN',
                    style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                      color: AppColors.lighterText,
                      fontSize: 17.sp,
                    ),
                  ),
                ),
                // suffixText: 'NGN',
                // suffixStyle: AppTheme.lightTextTheme.titleLarge?.copyWith(
                //   color: AppColors.lighterText,
                //   fontSize: 17.sp,
                // ),
              ),
              20.hi,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // color: AppColors.whiteShade80,
                  color: AppColors.appbarColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allocation',
                      style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                          color: AppColors.lighterText,
                          fontWeight: FontWeight.w400),
                    ),
                    4.hi,
                    RichText(
                      text: TextSpan(
                          text: '30 ', // Default style applied to this part
                          style: AppTheme.lightTextTheme.titleLarge?.copyWith(
                            fontSize: 24.sp,
                            color: AppColors.greyText,
                          ),
                          children: [
                            TextSpan(
                              text: 'TB',
                              style:
                                  AppTheme.lightTextTheme.titleLarge?.copyWith(
                                color: AppColors.lighterText,
                              ),
                            ),
                            TextSpan(
                              text: '       +     ',
                              style:
                                  AppTheme.lightTextTheme.titleLarge?.copyWith(
                                fontSize: 24.sp,
                                color: AppColors.greyText,
                              ),
                            ),
                            TextSpan(
                              text: '100K ',
                              style:
                                  AppTheme.lightTextTheme.titleLarge?.copyWith(
                                fontSize: 24.sp,
                                color: AppColors.greyText,
                              ),
                            ),
                            TextSpan(
                              text: 'HOURS',
                              style:
                                  AppTheme.lightTextTheme.titleLarge?.copyWith(
                                color: AppColors.lighterText,
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
              50.hi,
              AppElevatedButton(
                label: 'Buy Data',
                onTap: () {
                  subsriptionBottomSheet(context: context);
                },
              ),
            ],
          ).padHorizontal(
            16,
          ),
        ),
      ),
    );
  }
}
