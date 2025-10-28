import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_constants.dart';
import '../utils/screen_size.dart';
import '../view_models/transaction_provider.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final balance = provider.balance;
        final totalIncome = provider.totalIncome;
        final totalExpenses = provider.totalExpenses;
        final isPositive = balance >= 0;

        // App bar color
        const Color appBarColor = Color(0xFFE57373);
        // Create a slightly lighter version
        final HSLColor hsl = HSLColor.fromColor(appBarColor);
        final HSLColor lighterHsl = hsl.withLightness(
          (hsl.lightness + 0.02).clamp(0.0, 1.0),
        );
        final Color lightAppBarColor = lighterHsl.toColor();
        final Color evenLighterColor = lighterHsl
            .withLightness((lighterHsl.lightness + 0.02).clamp(0.0, 1.0))
            .toColor();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [lightAppBarColor, evenLighterColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: lightAppBarColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background overlay for better text contrast
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.03),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Balance',
                            style: TextStyle(
                              fontSize: screenWidth(context, dividedBy: 25),
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 120),
                          ),
                          Text(
                            AppConstants.formatCurrency(balance.abs()),
                            style: TextStyle(
                              fontSize: screenWidth(context, dividedBy: 12),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPositive ? Icons.trending_up : Icons.trending_down,
                          color: Colors.white,
                          size: screenWidth(context, dividedBy: 15),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight(context, dividedBy: 100)),

                  // Income and Expenses summary
                  Row(
                    children: [
                      // Income
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.white,
                                    size: screenWidth(context, dividedBy: 28),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: screenWidth(
                                        context,
                                        dividedBy: 32,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 150),
                              ),
                              Text(
                                AppConstants.formatCurrency(totalIncome),
                                style: TextStyle(
                                  fontSize: screenWidth(context, dividedBy: 22),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Expenses
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                    size: screenWidth(context, dividedBy: 28),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'Expenses',
                                    style: TextStyle(
                                      fontSize: screenWidth(
                                        context,
                                        dividedBy: 32,
                                      ),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight(context, dividedBy: 150),
                              ),
                              Text(
                                AppConstants.formatCurrency(totalExpenses),
                                style: TextStyle(
                                  fontSize: screenWidth(context, dividedBy: 22),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
