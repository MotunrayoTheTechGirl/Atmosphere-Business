import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/themes/app_themes.dart';

class PaymentTypeButton extends StatelessWidget {
  PaymentTypeButton({
    this.onTap,
    required this.label,
    this.isClicked = false,
    super.key,
  });

  final void Function()? onTap;
  final String label;
  bool isClicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: isClicked ? AppColors.lightPurple : AppColors.lightGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                  color: AppColors.deepBrown,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp),
            ),
            Container(
              width: 26.w,
              height: 30.h,
              // padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isClicked ? AppColors.w5Color : AppColors.white,
                  border: Border.all(color: AppColors.greyWhite, width: 1)),
              child: isClicked
                  ? Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 16.w,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
