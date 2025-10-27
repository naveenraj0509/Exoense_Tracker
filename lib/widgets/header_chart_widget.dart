import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/screenSize.dart';

class HeaderChartWidget extends StatelessWidget {
  const HeaderChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Prepare data for the chart - daily expenses for the month
    final dailyExpenses = _generateDailyExpenseData();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Expenses Trend',
            style: TextStyle(
              fontSize: screenWidth(context, dividedBy: 25),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight(context, dividedBy: 3.5),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 500,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 500,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '₹${(value / 1000).toStringAsFixed(1)}k',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    left: BorderSide(color: Colors.grey[300]!, width: 1),
                    right: const BorderSide(style: BorderStyle.none),
                    top: const BorderSide(style: BorderStyle.none),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: dailyExpenses,
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE57373), Color(0xFFEF9A9A)],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: const Color(0xFFE57373),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFE57373).withValues(alpha: 0.3),
                          const Color(0xFFEF9A9A).withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                minX: 1,
                maxX: 28,
                minY: 0,
                maxY: 2500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generate sample daily expense data
  List<FlSpot> _generateDailyExpenseData() {
    return [
      const FlSpot(1, 800),
      const FlSpot(2, 1200),
      const FlSpot(3, 950),
      const FlSpot(4, 1500),
      const FlSpot(5, 1100),
      const FlSpot(6, 1800),
      const FlSpot(7, 1300),
      const FlSpot(8, 1600),
      const FlSpot(9, 900),
      const FlSpot(10, 2100),
      const FlSpot(11, 1400),
      const FlSpot(12, 1700),
      const FlSpot(13, 1200),
      const FlSpot(14, 2000),
      const FlSpot(15, 1500),
      const FlSpot(16, 1300),
      const FlSpot(17, 1800),
      const FlSpot(18, 1100),
      const FlSpot(19, 1600),
      const FlSpot(20, 2200),
      const FlSpot(21, 1400),
      const FlSpot(22, 1900),
      const FlSpot(23, 1000),
      const FlSpot(24, 1700),
      const FlSpot(25, 1300),
      const FlSpot(26, 1500),
      const FlSpot(27, 2000),
      const FlSpot(28, 1800),
    ];
  }
}
