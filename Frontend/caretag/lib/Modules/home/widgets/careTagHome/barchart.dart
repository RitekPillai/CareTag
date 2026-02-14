import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarGraphTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: false,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 0,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  "●",
                  GoogleFonts.poppins(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          alignment: BarChartAlignment.spaceBetween,
          maxY: 10,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                  ];
                  return Text(
                    days[value.toInt()],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),

          barGroups: [
            _chartGroupData(0, 3),
            _chartGroupData(1, 5),
            _chartGroupData(2, 7),
            _chartGroupData(3, 4),
            _chartGroupData(4, 6),
            _chartGroupData(5, 5, current: true),
            _chartGroupData(6, 4, isExcepted: true),
          ],
        ),
      ),
    );
  }
}

BarChartGroupData _chartGroupData(
  int x,
  double y, {
  bool isExcepted = false,
  bool current = false,
}) {
  Color lightOrange = Color.fromRGBO(248, 94, 0, 0.1);
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: !isExcepted ? Color(0xffF85E00) : lightOrange,
        width: 10,
      ),
    ],
    showingTooltipIndicators: current ? [0] : [],
  );
}
