import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/constants/app_constants.dart';
import '../utils/screenSize.dart';

class ExpensesSummaryCard extends StatelessWidget {
  const ExpensesSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final totalExpenses = AppConstants.staticTransactions.fold<int>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Expenses',
                style: TextStyle(
                  fontSize: screenWidth(context, dividedBy: 25),
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                AppConstants.formatCurrency(totalExpenses),
                style: TextStyle(
                  fontSize: screenWidth(context, dividedBy: 20),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFE57373),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight(context, dividedBy: 3.5),
            child: PieChart(
              PieChartData(
                sections: _buildPieChartSections(),
                centerSpaceRadius: 60,
                sectionsSpace: 2,
                startDegreeOffset: -90,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildCategoryLegend(),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final categories = AppConstants.categoryBreakdown;
    final totalAmount = categories.fold<int>(0, (sum, cat) => sum + cat.amount);

    return categories.map((category) {
      final percentage = (category.amount / totalAmount) * 100;
      return PieChartSectionData(
        value: category.amount.toDouble(),
        color: category.color,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 70,
        titleStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  List<Widget> _buildCategoryLegend() {
    return AppConstants.categoryBreakdown
        .take(3)
        .map(
          (category) => Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: category.color,
                ),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.type,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppConstants.formatCurrency(category.amount),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .toList();
  }
}
