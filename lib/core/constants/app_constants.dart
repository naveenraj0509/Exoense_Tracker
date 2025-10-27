import 'package:flutter/material.dart';
import 'package:expensive_tracker/models/transaction_model.dart';
import 'package:expensive_tracker/models/income_model.dart';
import 'package:expensive_tracker/models/category_summary.dart';

class AppConstants {
  // Transaction Model
  static const List<TransactionModel> staticTransactions = [
    TransactionModel(
      id: 1,
      type: 'Shopping',
      amount: 2430,
      icon: Icons.shopping_bag,
      iconColor: Color(0xFFE57373),
      date: '2023-02-15',
      description: 'Clothes and accessories',
    ),
    TransactionModel(
      id: 2,
      type: 'Grocery',
      amount: 1200,
      icon: Icons.local_grocery_store,
      iconColor: Color(0xFFA5D6A7),
      date: '2023-02-18',
      description: 'Weekly grocery shopping',
    ),
    TransactionModel(
      id: 3,
      type: 'Coffee',
      amount: 1560,
      icon: Icons.local_cafe,
      iconColor: Color(0xFF81C784),
      date: '2023-02-20',
      description: 'Coffee and snacks',
    ),
    TransactionModel(
      id: 4,
      type: 'Utilities',
      amount: 800,
      icon: Icons.lightbulb,
      iconColor: Color(0xFFFFD54F),
      date: '2023-02-21',
      description: 'Electricity bill',
    ),
    TransactionModel(
      id: 5,
      type: 'Entertainment',
      amount: 500,
      icon: Icons.movie,
      iconColor: Color(0xFF64B5F6),
      date: '2023-02-22',
      description: 'Movie tickets',
    ),
  ];

  static const List<IncomeModel> staticIncome = [
    IncomeModel(
      id: 1,
      source: 'Salary',
      amount: 50000,
      icon: Icons.attach_money,
      iconColor: Color(0xFF66BB6A),
      date: '2023-02-01',
      description: 'Monthly salary',
    ),
  ];

  static const List<CategorySummary> categoryBreakdown = [
    CategorySummary(
      type: 'Shopping',
      amount: 2430,
      percentage: 36,
      color: Color(0xFFE57373),
    ),
    CategorySummary(
      type: 'Grocery',
      amount: 1200,
      percentage: 18,
      color: Color(0xFFA5D6A7),
    ),
    CategorySummary(
      type: 'Coffee',
      amount: 1560,
      percentage: 23,
      color: Color(0xFF81C784),
    ),
    CategorySummary(
      type: 'Utilities',
      amount: 800,
      percentage: 12,
      color: Color(0xFFFFD54F),
    ),
    CategorySummary(
      type: 'Entertainment',
      amount: 500,
      percentage: 7,
      color: Color(0xFF64B5F6),
    ),
  ];

  // Currency formatter
  static String formatCurrency(int amount) {
    return '₹${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}
