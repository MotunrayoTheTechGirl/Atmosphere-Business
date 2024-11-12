import 'package:dealer_portal_mobile/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/themes/app_themes.dart';
import '../../widgets/report_metric_card.dart';

class ReportTabView extends StatefulWidget {
  const ReportTabView({
    super.key,
  });

  @override
  State<ReportTabView> createState() => _ReportTabViewState();
}

class _ReportTabViewState extends State<ReportTabView> {
  final List<String> _timeFrames = ['Daily', 'Weekly', 'Monthly'];
  String _selectedTimeFrame = 'Weekly';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: .9.sh,
      child: ListView(
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance',
            style: AppTheme.lightTextTheme.displaySmall?.copyWith(
                color: AppColors.black.withOpacity(0.6),
                fontWeight: FontWeight.w700,
                fontSize: 15.sp),
          ),
          6.hi,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter by:',
                style: AppTheme.lightTextTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackText.withOpacity(0.5),
                    fontSize: 14.sp),
              ),
              SizedBox(
                width: 92.w,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    icon: SvgPicture.asset(
                      AppIcons.arrowDown,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0.h,
                        horizontal: 10.w,
                      ),
                    ),
                    value: _selectedTimeFrame,
                    items: _timeFrames.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTheme.lightTextTheme.bodySmall?.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.blackText,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppTheme.montserratAlternate),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedTimeFrame = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          8.hi,
          ReportMetricsCard(
            metricType: 'Reach',
            metricValue: '7265',
            metricpercentage: '+11.02%',
            onTap: () {},
          ),
          16.hi,
          ReportMetricsCard(
            metricType: 'Visits',
            metricValue: '7265',
            metricpercentage: '+11.02%',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
