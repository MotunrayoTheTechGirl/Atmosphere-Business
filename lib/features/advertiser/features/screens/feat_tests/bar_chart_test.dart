import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class MetricBarChart extends StatelessWidget {
  const MetricBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: 300.h,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              maxY: 5000,
              minY: 0,
              barGroups: _buildBarGroups(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(
                        value.toInt().toString(),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    interval: 1000,
                    reservedSize: 40,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _getDateForIndex(value.toInt()),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    interval: 1,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 1000,
                getDrawingHorizontalLine: (value) => const FlLine(
                  color: AppColors.barChartColor,
                  strokeWidth: 1,
                  dashArray: [4, 4],
                ),
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(
                    color: AppColors.barChartColor,
                    width: 1,
                  ),
                  bottom: BorderSide(color: AppColors.barChartColor, width: 1),
                  top: BorderSide(color: AppColors.barChartColor, width: 1),
                  right: BorderSide(color: AppColors.barChartColor, width: 1),
                ),
              ),
              barTouchData: BarTouchData(enabled: false),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    final values = [1800, 3200, 2500, 1700, 700, 870, 2400];
    return List.generate(
      values.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: values[index].toDouble(),
            color: const Color(0xFF5A1D77),
            width: 13.w,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  String _getDateForIndex(int index) {
    // Assuming 12/03/2024 is the start date.
    const dates = [
      '12/03',
      '13/03',
      '14/03',
      '15/03',
      '16/03',
      '17/03',
      '18/03',
    ];
    return dates[index % dates.length];
  }
}
