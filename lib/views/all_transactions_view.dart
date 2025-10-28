import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../utils/screen_size.dart';
import '../widgets/transaction_list_widget.dart';
import '../view_models/transaction_provider.dart';
import '../widgets/add_transaction_dialog.dart';
import '../core/constants/transaction_constants.dart';

class AllTransactionsView extends StatelessWidget {
  const AllTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final allTransactions = provider.transactions;
        final totalExpenses = allTransactions
            .where((t) => TransactionConstants.isExpenseCategory(t.type))
            .fold<int>(0, (sum, transaction) => sum + transaction.amount);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE57373),
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(
                left: screenWidth(context, dividedBy: 20),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            leadingWidth: 70,
            title: Text(
              'Transactions',
              style: TextStyle(
                fontSize: screenWidth(context, dividedBy: 22),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            centerTitle: false,
            actions: [],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth(context, dividedBy: 20)),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Expenses',
                          style: TextStyle(
                            fontSize: screenWidth(context, dividedBy: 28),
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppConstants.formatCurrency(totalExpenses),
                          style: TextStyle(
                            fontSize: screenWidth(context, dividedBy: 18),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFE57373),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, dividedBy: 20),
                    ),
                    child: TransactionListWidget(
                      transactions: allTransactions,
                      onEdit: (transaction) =>
                          _editTransaction(context, transaction),
                      onDelete: (transaction) =>
                          _deleteTransaction(context, provider, transaction),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editTransaction(BuildContext context, dynamic transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTransactionDialog(transactionToEdit: transaction);
      },
    );
  }

  void _deleteTransaction(
    BuildContext context,
    TransactionProvider provider,
    dynamic transaction,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Transaction'),
          content: const Text(
            'Are you sure you want to delete this transaction?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.removeTransaction(transaction.id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction deleted')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
