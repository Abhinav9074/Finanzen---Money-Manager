import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/budgetModel/budget_model.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
import 'package:money_manager/models/deletedModel/deleted_model.dart';
import 'package:money_manager/models/transactionModel/transactions_model.dart';
import 'package:money_manager/models/userModel/user_model.dart';


// ignore: non_constant_identifier_names
Future<void>InitDb()async{
  await Hive.initFlutter();

  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
  {
    Hive.registerAdapter(CategoryTypeAdapter());
  }


  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
  {
    Hive.registerAdapter(CategoryModelAdapter());
  }

if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)){
  Hive.registerAdapter(TransactionModelAdapter());
}

if(!Hive.isAdapterRegistered(DeletedModelAdapter().typeId)){
  Hive.registerAdapter(DeletedModelAdapter());
}

if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
  Hive.registerAdapter(UserModelAdapter());
}

if(!Hive.isAdapterRegistered(BudgetModelAdapter().typeId)){
  Hive.registerAdapter(BudgetModelAdapter());
}

}