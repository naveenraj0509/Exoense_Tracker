import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../view_models/transaction_provider.dart';
import '../core/constants/transaction_constants.dart';

class AddTransactionDialog extends StatefulWidget {
  final dynamic transactionToEdit;

  const AddTransactionDialog({super.key, this.transactionToEdit});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  String? selectedType;
  String? selectedCategory;

  final Map<String, List<String>> categoryOptions = {
    TransactionConstants.expense: TransactionConstants.expenseCategories,
    TransactionConstants.income: TransactionConstants.incomeCategories,
  };

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    descriptionController = TextEditingController();
    // Start with blank selections or pre-fill if editing
    if (widget.transactionToEdit != null) {
      // Pre-fill for editing
      amountController.text = widget.transactionToEdit.amount.toString();
      descriptionController.text = widget.transactionToEdit.description;
      // Determine type based on category
      selectedType =
          TransactionConstants.isIncomeCategory(widget.transactionToEdit.type)
          ? TransactionConstants.income
          : TransactionConstants.expense;
      selectedCategory = widget.transactionToEdit.type;
    } else {
      selectedType = null;
      selectedCategory = null;
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _handleAddTransaction() async {
    final amountText = amountController.text;
    final description = descriptionController.text;

    if (amountText.isEmpty ||
        selectedType == null ||
        selectedCategory == null ||
        description.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final amount = int.tryParse(amountText);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final date = DateTime.now().toString().split(' ')[0]; // YYYY-MM-DD

    try {
      final provider = context.read<TransactionProvider>();
      if (widget.transactionToEdit != null) {
        // Edit existing transaction
        final updatedTransaction = TransactionModel(
          id: widget.transactionToEdit.id,
          type: selectedCategory!,
          amount: amount,
          iconCode: TransactionConstants.getIconCodeForType(selectedType!),
          iconColorValue: TransactionConstants.getColorValueForType(
            selectedType!,
          ),
          date: date,
          description: description,
        );
        await provider.updateTransaction(updatedTransaction);
      } else {
        // Add new transaction
        final id = Random().nextInt(999999) + 1;
        final transaction = TransactionModel(
          id: id,
          type: selectedCategory!,
          amount: amount,
          iconCode: TransactionConstants.getIconCodeForType(selectedType!),
          iconColorValue: TransactionConstants.getColorValueForType(
            selectedType!,
          ),
          date: date,
          description: description,
        );
        await provider.addTransaction(transaction);
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.transactionToEdit != null
                  ? 'Transaction updated'
                  : 'Transaction added',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      elevation: 10,
      title: Row(
        children: [
          Icon(
            widget.transactionToEdit != null ? Icons.edit : Icons.add_circle,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            widget.transactionToEdit != null
                ? 'Edit Transaction'
                : 'Add Transaction',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.currency_rupee),
                filled: true,
                fillColor: Colors.grey[50],
                hintText: '0.00',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(
                  value: TransactionConstants.expense,
                  child: Text('💸 Expense'),
                ),
                DropdownMenuItem(
                  value: TransactionConstants.income,
                  child: Text('💰 Income'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                  selectedCategory = value != null
                      ? categoryOptions[value]!.first
                      : null;
                });
              },
              decoration: InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: selectedType != null
                  ? categoryOptions[selectedType]!
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ),
                        )
                        .toList()
                  : [],
              onChanged: selectedType != null
                  ? (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  : null,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                hintText: 'Enter description',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
        ElevatedButton(
          onPressed: _handleAddTransaction,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE57373),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            widget.transactionToEdit != null
                ? 'Update Transaction'
                : 'Add Transaction',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
