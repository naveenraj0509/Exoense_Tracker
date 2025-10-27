import 'package:flutter/material.dart';

class IncomeModel {
  final int id;
  final String source;
  final int amount;
  final IconData icon;
  final Color iconColor;
  final String date;
  final String description;

  const IncomeModel({
    required this.id,
    required this.source,
    required this.amount,
    required this.icon,
    required this.iconColor,
    required this.date,
    required this.description,
  });
}
