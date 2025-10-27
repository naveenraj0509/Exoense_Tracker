import 'package:flutter/material.dart';
import '../utils/screenSize.dart';
import '../widgets/expenses_summary_card.dart';
import '../widgets/filter_buttons_widget.dart';
import '../widgets/income_expenses_summary_widget.dart';
import '../widgets/recent_transactions_section_widget.dart';
import '../widgets/add_transaction_dialog.dart';
import '../core/constants/app_constants.dart';
import '../models/transaction_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<TransactionModel> filteredTransactions;

  @override
  void initState() {
    super.initState();
    filteredTransactions = AppConstants.staticTransactions.take(5).toList();
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddTransactionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: screenHeight(context, dividedBy: 30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: screenWidth(context, dividedBy: 18),
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1 Feb 2023 - 28 Feb 2023',
                      style: TextStyle(
                        fontSize: screenWidth(context, dividedBy: 28),
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context, dividedBy: 25)),
                const ExpensesSummaryCard(),
                SizedBox(height: screenHeight(context, dividedBy: 25)),
                FilterButtonsWidget(
                  onFilterChanged: (filter) {
                    setState(() {
                      // Filter logic can be added here
                    });
                  },
                ),
                SizedBox(height: screenHeight(context, dividedBy: 25)),
                const IncomeExpensesSummaryWidget(),
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
        onPressed: _showAddTransactionDialog,
        backgroundColor: const Color(0xFFE57373),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
