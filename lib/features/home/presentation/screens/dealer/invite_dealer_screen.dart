import 'package:dealer_portal_mobile/core/common_widgets/app_elevated_button.dart';
import 'package:dealer_portal_mobile/core/common_widgets/app_text_field.dart';
import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:dealer_portal_mobile/features/create_plan/presentation/widgets/textfiel_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/common_widgets/app_bars/custom_appbar.dart';
import '../../../../../core/utils/app_icons.dart';

class InviteDealerScreen extends StatelessWidget {
  InviteDealerScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Invite Dealer',
        icon: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.cancel,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.hi,
            const TextFieldLabel(label: 'Dealer name'),
            10.hi,
            AppTextField(
              radius: 14,
              filled: false,
              controller: nameController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'Enter name',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(0.5),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            20.hi,
            const TextFieldLabel(
              label: 'Email address',
            ),
            10.hi,
            AppTextField(
              radius: 14,
              filled: false,
              controller: nameController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'example@gmail.com',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(0.5),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            20.hi,
            const TextFieldLabel(
              label: 'Phone number',
            ),
            10.hi,
            AppTextField(
              radius: 14,
              filled: false,
              controller: nameController,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 8,
              ),
              hintText: 'enter phone number',
              hintStyle: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textFieldBorder.withOpacity(0.5),
              ),
              // prefixText: '+234  |   ',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  left: 8,
                ),
                child: SizedBox(
                  width: 90.w,
                  height: 20.h,
                  child: Row(
                    children: [
                      Text(
                        '+234',
                        style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyText,
                        ),
                      ),
                      const VerticalDivider(
                        color: AppColors.dividerColor,
                      )
                    ],
                  ),
                ),
              ),
              style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            260.hi,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevatedButton(
                  width: 160.w,
                  onTap: () {},
                  rowLabel: 'Cancel',
                  isLightShade: true,
                  rowLabelColor: AppColors.lightBlue,
                ),
                AppElevatedButton(
                  width: 160.w,
                  onTap: () {},
                  label: 'Send Invite',
                ),
              ],
            ),
          ],
        ).padSymmetric(
          horizontal: 16,
        )),
      ),
    );
  }
}
