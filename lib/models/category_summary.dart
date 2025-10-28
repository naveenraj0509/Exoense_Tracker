import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category_summary.g.dart';

@HiveType(typeId: 2)
class CategorySummary {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final int percentage;
  @HiveField(3)
  final int colorValue;

  const CategorySummary({
    required this.type,
    required this.amount,
    required this.percentage,
    required this.colorValue,
  });

  Color get color => Color(colorValue);
}
