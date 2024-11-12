import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/cancel_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class AddAccountTile extends StatelessWidget {
  const AddAccountTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bizNameController = TextEditingController();
    final bizEmailController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Account',
                style: AppTheme.lightTextTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              const CancelButton(),
            ],
          ),
          30.hi,
          Text(
            'Sign In',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.deepAsh,
                fontFamily: AppTheme.montserratAlternate,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          ),
          20.hi,
          AppTextField(
            controller: bizNameController,
            hintText: '',
            defaultLabelText: 'Business Name',
            radius: 10.r,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 8,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.greyText,
            ),
          ),
          24.hi,
          AppTextField(
            controller: bizEmailController,
            hintText: '',
            defaultLabelText: 'Business Email',
            radius: 10.r,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 8,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: AppColors.greyText,
            ),
          ),
          50.hi,
          AppElevatedButton(
            onTap: () {},
            label: 'Sign in',
            isActive: false,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
