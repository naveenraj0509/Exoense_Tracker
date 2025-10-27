import 'package:flutter/material.dart';

class CategorySummary {
  final String type;
  final int amount;
  final int percentage;
  final Color color;

  const CategorySummary({
    required this.type,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}
