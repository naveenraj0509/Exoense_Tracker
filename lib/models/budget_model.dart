import 'package:hive/hive.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 3)
class BudgetModel {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final int monthlyLimit;
  @HiveField(2)
  final int spentAmount;

  const BudgetModel({
    required this.category,
    required this.monthlyLimit,
    required this.spentAmount,
  });
}
