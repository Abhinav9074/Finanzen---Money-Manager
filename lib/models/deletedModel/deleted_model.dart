import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
part 'deleted_model.g.dart';

@HiveType(typeId: 4)
class DeletedModel{

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

  @HiveField(8)
  final DateTime deleteDate;

  DeletedModel({required this.id, required this.purpose, required this.amount, required this.date, required this.dateSum, required this.recieptImage, required this.type, required this.categorySubType,required this.deleteDate});
  
}