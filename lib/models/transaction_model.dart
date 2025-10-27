import 'package:flutter/material.dart';

class TransactionModel {
  final int id;
  final String type;
  final int amount;
  final IconData icon;
  final Color iconColor;
  final String date;
  final String description;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.date,
    required this.description,
  });
}
