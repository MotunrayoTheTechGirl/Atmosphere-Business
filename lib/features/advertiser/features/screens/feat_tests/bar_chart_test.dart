import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarChartExample extends StatelessWidget {
  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0DBE4), // Light grayish background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Bar chart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
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
                            showTitles: false, // Hide the right vertical axis
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
                            showTitles: false, // Hide the top horizontal axis
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        horizontalInterval: 1000,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.grey.shade300,
                          strokeWidth: 1,
                          dashArray: [4, 4], // Dashed grid lines
                        ),
                        drawVerticalLine: false, // Disable vertical grid lines
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1), // Left axis border
                          bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1), // Bottom axis border
                          top: BorderSide.none, // Remove top border
                          right: BorderSide.none, // Remove right border
                        ),
                      ),
                      barTouchData: BarTouchData(enabled: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
            color: const Color(0xFF5A1D77), // Purple bar color
            width: 13.w, // Thickness of bars
            borderRadius: BorderRadius.circular(4),
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
