import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  late TransactionService _transactionService;
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    _transactionService = TransactionService();
  }

  Future<void> init() async {
    await _transactionService.init();
    _loadTransactions();
  }

  void _loadTransactions() {
    _transactions = _transactionService.getAllTransactions();
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionService.addTransaction(transaction);
    _loadTransactions();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await _transactionService.updateTransaction(transaction);
    _loadTransactions();
  }

  Future<void> removeTransaction(int id) async {
    await _transactionService.removeTransaction(id);
    _loadTransactions();
  }

  int get totalIncome => _transactionService.getTotalIncome();

  int get totalExpenses => _transactionService.getTotalExpenses();

  int get balance => totalIncome - totalExpenses;

  int generateTransactionId() => _transactionService.generateTransactionId();
}
