import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/budgetModel/budget_model.dart';

abstract class Budget{
  Future<void>addBudget(BudgetModel values);
  Future<List<BudgetModel>>getAllBudgets();
  Future<void>refreshUi();
  Future<void>deleteBudget(String id);
  Future<String>getTotalCurrentAmount(String categoryName);
  Future<double>getTotalProgress(String categoryName,String budgetAmount);
  Future<void>AutoUpdateTotal();
  int CalucuateRemaningDays();
  Future<void>AutoDeleteBudget();
  Future<bool>CheckBudgetOverFlow(String CategoryName , String amount);
  Future<bool>CheckExisitingBudget(String CategoryName);
  Future<bool>CheckExisitingBudget2(String CategoryName , String oldCategoryName);
}

const BUDGET_DB = "budget_database";



class BudgetDb implements Budget{

  BudgetDb._internal();

  static BudgetDb instance = BudgetDb._internal();
  factory BudgetDb(){
    return instance;
  }


  ValueNotifier<List<BudgetModel>> BudgetListNotifier = ValueNotifier([]);


  @override
  Future<void> addBudget(BudgetModel values) async{
    final budgets = await Hive.openBox<BudgetModel>(BUDGET_DB);
    await budgets.put(values.id, values);
    refreshUi();
  }

  @override
  Future<List<BudgetModel>> getAllBudgets() async{
    final budgets = await Hive.openBox<BudgetModel>(BUDGET_DB);
    return budgets.values.toList();
  }
  
  @override
  Future<void> refreshUi() async{
    final allBudgets = await getAllBudgets();
    BudgetListNotifier.value.clear();
    await Future.forEach(allBudgets, (BudgetModel element){
      BudgetListNotifier.value.add(element);
    });
    BudgetListNotifier.notifyListeners();
  }
  
  @override
  Future<void> deleteBudget(String id) async{
    final Budgets = await Hive.openBox<BudgetModel>(BUDGET_DB);
    await Budgets.delete(id);
    refreshUi();
  }
  
  @override
  Future<String> getTotalCurrentAmount(String categoryName) async{
    await TransactionDb().refreshUI();
    int sum = 0;
    String date = DateTime.now().toString();
    int month = int.parse(date.substring(5,7));
    int year = int.parse(date.substring(0,4));
    DateTime monthFirst = DateTime(year, month,1);
    DateTime monthLast = DateTime(year, month+1,0);
    print('dates');
    print(monthFirst);
    print(monthLast);
    await Future.forEach(TransactionDb().expenseTransactionsList.value, (element){
      if(element.categorySubType == categoryName && element.date.isAfter(monthFirst)&&element.date.isBefore(monthLast)||element.date==monthFirst||element.date==monthLast){
        sum=sum+int.parse(element.amount);
      }
    });
    return sum.toString();
  }
  
  @override
  Future<void>  AutoUpdateTotal() async{
    await refreshUi();
    
    await Future.forEach(BudgetListNotifier.value, (element)async{
     String sum = await getTotalCurrentAmount(element.CategoryName);
     double progress = await getTotalProgress(element.CategoryName, element.BudgetAmount);
      final insertValue = BudgetModel(CategoryName: element.CategoryName, BudgetAmount: element.BudgetAmount, id: element.id, currentAmount: sum,progress: progress);
      await addBudget(insertValue);
    });
  }
  
  @override
  Future<double> getTotalProgress(String categoryName,String budgetAmount) async{
    await TransactionDb().refreshUI();
    int sum =  int.parse(await getTotalCurrentAmount(categoryName));
    if(sum>int.parse(budgetAmount)){
      return 1.0;
    }else{
      return sum/int.parse(budgetAmount);
    }
  }
  
  @override
   int CalucuateRemaningDays() {
    int remDays=0;
    String date = DateTime.now().toString();
    int month = int.parse(date.substring(5,7));
    int year = int.parse(date.substring(0,4));
    DateTime monthFirst = DateTime(year, month+1,1);
    remDays = monthFirst.difference(DateTime.now()).inDays;
    return remDays;
  }
  
  @override
  Future<void> AutoDeleteBudget() async{
    String date = DateTime.now().toString();
    print(date.substring(11,16));
    if(date.substring(5,7)=='01' && date.substring(11,16)=='00:00'){
      final budgets = await getAllBudgets();
      await Future.forEach(budgets, (element)async{
        await deleteBudget(element.id);
      });
    }
    refreshUi();
  }
  
  @override
  Future<bool> CheckBudgetOverFlow(String CategoryName, String amount) async{
    final budgets = await getAllBudgets();
    bool res = false;
    await Future.forEach(budgets, (element){
      if(element.CategoryName == CategoryName){
       print('${int.parse(element.currentAmount)+int.parse(amount)}');
       print('${int.parse(element.BudgetAmount)}');
        if((int.parse(element.currentAmount)+int.parse(amount))>int.parse(element.BudgetAmount)){
          res = true;
        }
      }
    });
    return res;
  }
  
  @override
  Future<bool> CheckExisitingBudget(String CategoryName) async{
    bool val= false;
    final budgets = await getAllBudgets();
    await Future.forEach(budgets, (element){
      if(element.CategoryName == CategoryName){
        val = true;
      }
    });
    return val;

  }
  
  @override
  Future<bool> CheckExisitingBudget2(String CategoryName, String oldCategoryName) async{
    bool val = false;
    int count=0;
    final budgets = await getAllBudgets();
    await Future.forEach(budgets, (element){
      if(element.CategoryName == CategoryName && element.CategoryName!=oldCategoryName){
        val = true;
      }
    });
   
    return val;
  }

  

}