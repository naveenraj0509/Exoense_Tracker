import 'package:flutter/material.dart';
import '../utils/screenSize.dart';
import '../views/all_transactions_view.dart';
import 'transaction_list_widget.dart';
import '../models/transaction_model.dart';

class RecentTransactionsSectionWidget extends StatelessWidget {
  final List<TransactionModel> transactions;

  const RecentTransactionsSectionWidget({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: screenWidth(context, dividedBy: 22),
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllTransactionsView(),
                  ),
                );
              },
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: screenWidth(context, dividedBy: 28),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE57373),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TransactionListWidget(transactions: transactions),
      ],
    );
  }
}
