import 'package:expense_tracker/models/transaction_model.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/models/category_summary.dart';

class AppConstants {
  // Transaction Model
  static const List<TransactionModel> staticTransactions = [
    TransactionModel(
      id: 1,
      type: 'Shopping',
      amount: 2430,
      iconCode: 0xe59c,
      iconColorValue: 0xFFE57373,
      date: '2023-02-15',
      description: 'Clothes and accessories',
    ),
    TransactionModel(
      id: 2,
      type: 'Grocery',
      amount: 1200,
      iconCode: 0xe54f,
      iconColorValue: 0xFFA5D6A7,
      date: '2023-02-18',
      description: 'Weekly grocery shopping',
    ),
    TransactionModel(
      id: 3,
      type: 'Coffee',
      amount: 1560,
      iconCode: 0xe541,
      iconColorValue: 0xFF81C784,
      date: '2023-02-20',
      description: 'Coffee and snacks',
    ),
    TransactionModel(
      id: 4,
      type: 'Utilities',
      amount: 800,
      iconCode: 0xe3a0,
      iconColorValue: 0xFFFFD54F,
      date: '2023-02-21',
      description: 'Electricity bill',
    ),
    TransactionModel(
      id: 5,
      type: 'Entertainment',
      amount: 500,
      iconCode: 0xe404,
      iconColorValue: 0xFF64B5F6,
      date: '2023-02-22',
      description: 'Movie tickets',
    ),
  ];

  static const List<IncomeModel> staticIncome = [
    IncomeModel(
      id: 1,
      source: 'Salary',
      amount: 50000,
      iconCode: 0xe227,
      iconColorValue: 0xFF66BB6A,
      date: '2023-02-01',
      description: 'Monthly salary',
    ),
  ];

  static const List<CategorySummary> categoryBreakdown = [
    CategorySummary(
      type: 'Shopping',
      amount: 2430,
      percentage: 36,
      colorValue: 0xFFE57373,
    ),
    CategorySummary(
      type: 'Grocery',
      amount: 1200,
      percentage: 18,
      colorValue: 0xFFA5D6A7,
    ),
    CategorySummary(
      type: 'Coffee',
      amount: 1560,
      percentage: 23,
      colorValue: 0xFF81C784,
    ),
    CategorySummary(
      type: 'Utilities',
      amount: 800,
      percentage: 12,
      colorValue: 0xFFFFD54F,
    ),
    CategorySummary(
      type: 'Entertainment',
      amount: 500,
      percentage: 7,
      colorValue: 0xFF64B5F6,
    ),
  ];

  // Currency formatter
  static String formatCurrency(int amount) {
    return '₹${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
