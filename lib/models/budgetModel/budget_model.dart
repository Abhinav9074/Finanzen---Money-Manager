import 'package:hive_flutter/adapters.dart';
part 'budget_model.g.dart';

@HiveType(typeId: 0)
class BudgetModel {
  @HiveField(0)
  final String CategoryName;

  @HiveField(1)
  final String BudgetAmount;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String currentAmount;

  @HiveField(4)
  final double progress;

  BudgetModel(
      {required this.CategoryName,
      required this.BudgetAmount,
      required this.id,
      required this.currentAmount,
      required this.progress});
}
