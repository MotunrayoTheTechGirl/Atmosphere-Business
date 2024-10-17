import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:dealer_portal_mobile/features/my_plans/presentation/widgets/buy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common_widgets/linear_progess_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/themes/app_themes.dart';

class DataBalanceCard extends StatefulWidget {
  const DataBalanceCard({
    this.width,
    super.key,
  });
  final double? width;

  @override
  State<DataBalanceCard> createState() => _DataBalanceCardState();
}

class _DataBalanceCardState extends State<DataBalanceCard> {
  String _selectedPlan = "Atmosphere Plan";
  final List<String> plans = [
    "Atmosphere Plan",
    "Glo Atmosphere Plan",
    "Glo Cooperate gifting",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 284.w,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(width: 1.2, color: AppColors.lightBorder),
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available data balance',
                style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(
                width: 120.w,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    icon: SvgPicture.asset(
                      AppIcons.angleArrow,
                    ),
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.w,
                      ),
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    value: _selectedPlan,
                    items: plans.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 100,
                          child: Text(
                            value,
                            style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedPlan = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          // 14.hi,
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '30.6',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  6.hi,
                  Text(
                    'Terabytes',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.hi,
                  BuyButton(
                    label: 'Buy Data',
                    onTap: () {},
                  ),
                ],
              ),
              40.wi,
              SizedBox(
                height: 100.h,
                child: const VerticalDivider(
                  thickness: 1,
                  color: AppColors.lightBorder,
                ),
              ),
              40.wi,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '996,748',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  6.hi,
                  Text(
                    'Wi-Fi Hours',
                    style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                      color: AppColors.greyText,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  6.hi,
                  BuyButton(
                    label: 'Buy Hours',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          16.hi,
          LinearProgressBar(
            color: AppColors.green,
            max: 6,
            height: 14.h,
            trackColor: AppColors.green.withOpacity(0.1),
            current: 3,
          ),
        ],
      ),
    );
  }
}
