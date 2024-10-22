import 'package:dealer_portal_mobile/core/utils/app_colors.dart';
import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/core/utils/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    this.label,
    this.labelFontSize,
    required this.onTap,
    this.width,
    this.isLightShade = false,
    this.isLoading = false,
    this.isActive = true,
    this.rowIcon,
    this.rowLabel,
    this.rowLabelColor,
    this.rowIconHeight,
    this.rowIconWidth,
    this.borderRadius,
    this.rowLabelstyle,
    this.child,
    this.padding,
    super.key,
  });

  final String? label;
  final double? labelFontSize;
  final double? width, borderRadius;
  final void Function()? onTap;
  final bool isLightShade;
  final String? rowIcon, rowLabel;
  final double? rowIconHeight, rowIconWidth;
  final Color? rowLabelColor;
  final bool isActive;
  final TextStyle? rowLabelstyle;
  final Widget? child;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isLightShade
              ? AppColors.w5Color.withOpacity(0.05)
              : isActive
                  ? AppColors.w5Color
                  : AppColors.w5Color.withOpacity(0.3),
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 16.5.r),
          ),
        ),
        child: isLoading
            ? const SpinKitChasingDots(
                size: 20,
                color: AppColors.white,
              )
            : isLightShade
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        rowIcon ?? '',
                        width: rowIconWidth,
                        height: rowIconHeight,
                      ),
                      10.wi,
                      Text(
                        rowLabel ?? '',
                        style: rowLabelstyle ??
                            AppTheme.lightTextTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: rowLabelColor ?? AppColors.w5Color,
                            ),
                      )
                    ],
                  )
                : Center(
                    child: child ??
                        Text(
                          label ?? '',
                          style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                              color: AppColors.white,
                              fontSize: labelFontSize ?? 16.sp),
                        ),
                  ),
      ),
    );
  }
}
