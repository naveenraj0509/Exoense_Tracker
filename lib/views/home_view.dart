import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/screen_size.dart';
import '../widgets/balance_card.dart';
import '../widgets/expenses_summary_card.dart';
import '../widgets/filter_buttons_widget.dart';
import '../widgets/recent_transactions_section_widget.dart';
import '../widgets/add_transaction_dialog.dart';
import '../view_models/transaction_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddTransactionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final filteredTransactions = provider.transactions.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE57373),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 20)),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // Add menu action
              },
            ),
          ),
        ),
        leadingWidth: 70,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: screenWidth(context, dividedBy: 20),
            ),
            child: Center(
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'ET',
                    style: TextStyle(
                      fontSize: screenWidth(context, dividedBy: 24),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE57373),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context, dividedBy: 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Space between app bar and balance card
                SizedBox(height: screenHeight(context, dividedBy: 50)),
                // Balance Card (now with same margins as other cards)
                const BalanceCard(),
                SizedBox(height: screenHeight(context, dividedBy: 35)),
                const ExpensesSummaryCard(),
                SizedBox(height: screenHeight(context, dividedBy: 25)),
                FilterButtonsWidget(
                  onFilterChanged: (filter) {
                    // Filter logic can be added here
                  },
                ),
                SizedBox(height: screenHeight(context, dividedBy: 25)),
                RecentTransactionsSectionWidget(
                  transactions: filteredTransactions,
                ),
                SizedBox(height: screenHeight(context, dividedBy: 15)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionDialog(context),
        backgroundColor: const Color(0xFFE57373),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
