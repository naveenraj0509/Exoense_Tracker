import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../utils/screen_size.dart';
import '../view_models/transaction_provider.dart';
import '../core/constants/transaction_constants.dart';
import '../models/transaction_model.dart';

class ExpensesSummaryCard extends StatelessWidget {
  const ExpensesSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final expenseTransactions = provider.transactions
            .where((t) => TransactionConstants.isExpenseCategory(t.type))
            .toList();
        final totalExpenses = expenseTransactions.fold<int>(
          0,
          (sum, transaction) => sum + transaction.amount,
        );

        return Container(
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 16),
              SizedBox(
                height: screenHeight(context, dividedBy: 4.5),
                child: expenseTransactions.isEmpty
                    ? const Center(
                        child: Text(
                          'No expenses yet.\nAdd your first expense to see the chart!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : PieChart(
                        PieChartData(
                          sections: _buildPieChartSections(expenseTransactions),
                          centerSpaceRadius: 50,
                          sectionsSpace: 2,
                          startDegreeOffset: -90,
                        ),
                      ),
              ),
              const SizedBox(height: 12),
              expenseTransactions.isEmpty
                  ? const SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildCategoryLegend(expenseTransactions),
                    ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    List<TransactionModel> expenseTransactions,
  ) {
    // Group expenses by type
    Map<String, int> categoryTotals = {};
    for (var transaction in expenseTransactions) {
      categoryTotals[transaction.type] =
          (categoryTotals[transaction.type] ?? 0) + transaction.amount;
    }

    final totalAmount = categoryTotals.values.fold<int>(
      0,
      (sum, amount) => sum + amount,
    );

    if (totalAmount == 0) {
      return [];
    }

    return categoryTotals.entries.map((entry) {
      final percentage = (entry.value / totalAmount) * 100;
      // Use a default color or map based on type
      final color = _getColorForCategory(entry.key);
      return PieChartSectionData(
        value: entry.value.toDouble(),
        color: color,
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

  Color _getColorForCategory(String category) {
    // Simple color mapping, can be expanded
    switch (category.toLowerCase()) {
      case 'shopping':
        return const Color(0xFFE57373);
      case 'grocery':
        return const Color(0xFFA5D6A7);
      case 'coffee':
        return const Color(0xFF81C784);
      case 'utilities':
        return const Color(0xFFFFD54F);
      case 'entertainment':
        return const Color(0xFF64B5F6);
      default:
        return Colors.grey;
    }
  }

  List<Widget> _buildCategoryLegend(
    List<TransactionModel> expenseTransactions,
  ) {
    Map<String, int> categoryTotals = {};
    for (var transaction in expenseTransactions) {
      categoryTotals[transaction.type] =
          (categoryTotals[transaction.type] ?? 0) + transaction.amount;
    }

    return categoryTotals.entries
        .take(3)
        .map(
          (entry) => Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getColorForCategory(entry.key),
                ),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppConstants.formatCurrency(entry.value),
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
