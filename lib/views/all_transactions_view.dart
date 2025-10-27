import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../utils/screenSize.dart';
import '../widgets/transaction_list_widget.dart';
import '../models/transaction_model.dart';

class AllTransactionsView extends StatefulWidget {
  const AllTransactionsView({super.key});

  @override
  State<AllTransactionsView> createState() => _AllTransactionsViewState();
}

class _AllTransactionsViewState extends State<AllTransactionsView> {
  late List<TransactionModel> allTransactions;

  @override
  void initState() {
    super.initState();
    allTransactions = AppConstants.staticTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = allTransactions.fold<int>(
      0,
      (sum, transaction) => sum + transaction.amount,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE57373),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 20)),
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
                child: TransactionListWidget(transactions: allTransactions),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
