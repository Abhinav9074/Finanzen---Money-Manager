import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
part 'transactions_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel{

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String purpose;

  @HiveField(2)
  final String amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final int dateSum;

  @HiveField(5)
  final String? recieptImage;

  @HiveField(6)
  final CategoryType type;

  @HiveField(7)
  final String categorySubType;

  TransactionModel({required this.id, required this.purpose, required this.amount, required this.date, required this.dateSum, this.recieptImage='', required this.type, required this.categorySubType}); 
}