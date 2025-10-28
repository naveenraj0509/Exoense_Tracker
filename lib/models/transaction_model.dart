import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final int amount;
  @HiveField(3)
  final int iconCode;
  @HiveField(4)
  final int iconColorValue;
  @HiveField(5)
  final String date;
  @HiveField(6)
  final String description;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.iconCode,
    required this.iconColorValue,
    required this.date,
    required this.description,
  });

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
  Color get iconColor => Color(iconColorValue);
}
