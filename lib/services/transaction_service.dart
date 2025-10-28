import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';
import '../core/constants/transaction_constants.dart';

class TransactionService {
  static const String _boxName = 'transactions';
  late Box<TransactionModel> _transactionBox;

  Future<void> init() async {
    _transactionBox = await Hive.openBox<TransactionModel>(_boxName);
  }

  Box<TransactionModel> get transactionBox => _transactionBox;

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _transactionBox.put(transaction.id, transaction);
  }

  Future<void> removeTransaction(int id) async {
    await _transactionBox.delete(id);
  }

  List<TransactionModel> getAllTransactions() {
    return _transactionBox.values.toList();
  }

  List<TransactionModel> getExpenseTransactions() {
    return _transactionBox.values
        .where((t) => TransactionConstants.isExpenseCategory(t.type))
        .toList();
  }

  List<TransactionModel> getIncomeTransactions() {
    return _transactionBox.values
        .where((t) => TransactionConstants.isIncomeCategory(t.type))
        .toList();
  }

  int getTotalIncome() {
    return getIncomeTransactions().fold(0, (sum, t) => sum + t.amount);
  }

  int getTotalExpenses() {
    return getExpenseTransactions().fold(0, (sum, t) => sum + t.amount);
  }

  int generateTransactionId() {
    return Random().nextInt(999999) + 1;
  }

  Future<void> close() async {
    await _transactionBox.close();
  }
}
