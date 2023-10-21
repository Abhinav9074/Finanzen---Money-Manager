// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/Screens/stats/models/stat_models.dart';
import 'package:money_manager/db/budget/budget_db.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/deleted/deleted_db_functions.dart';
import 'package:money_manager/db/user/user_db.dart';
import 'package:money_manager/models/budgetModel/budget_model.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';
import 'package:money_manager/models/deletedModel/deleted_model.dart';
import 'package:money_manager/models/transactionModel/transactions_model.dart';
import 'package:money_manager/models/userModel/user_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDetails {
  Future<void> addTransactions(TransactionModel values);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(value);
  Future<void> findSpeciificTransaction(value, String id);
  Future<void> FilterByDate(DateTime start, DateTime end);
  Future<void> FilterByCategory(String subCategory);
  Future<void> Sorting(int criteria);
  Future<int> CheckCategoryBeforeDelete(String subCategory);
  Future<void> CalculateTotal();
  Future<void> UpdateCategory(String oldCategoryName, String newCategoryName ,CategoryType oldType , CategoryType newType);
  Future<void> DeleteAllRelatedTransactions(String categoryName);
  Future<void> DeleteAllDb();
 
}

class TransactionDb implements TransactionDetails {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> incomeTransactionsList =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseTransactionsList =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> allTransactionsList = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> specificTransactionsList =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> recentTransactionsList =
      ValueNotifier([]);

  ValueNotifier<double> expense = ValueNotifier(0);
  ValueNotifier<double> income= ValueNotifier(0);
  ValueNotifier<double> total = ValueNotifier(0);
  int CallCount = 0;
  dynamic indexValue;

  @override
  Future<void> addTransactions(TransactionModel values) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDb.put(values.id, values);
    refreshUI();
    BudgetDb().AutoUpdateTotal();
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return transactionDb.values.toList();
  }

  Future<void> refreshUI() async {
    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();
    final allTransactions = await getTransactions();
    expenseTransactionsList.value.clear();
    incomeTransactionsList.value.clear();
    allTransactionsList.value.clear();
    recentTransactionsList.value.clear();
    await Future.forEach(allTransactions, (TransactionModel transactions) {
      if (transactions.type == CategoryType.income) {
        incomeTransactionsList.value.add(transactions);
      } else {
        expenseTransactionsList.value.add(transactions);
      }
      allTransactionsList.value.add(transactions);
      recentTransactionsList.value.add(transactions);
    });

    expenseTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    allTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    if (allTransactionsList.value.isNotEmpty) {
      indexValue = TransactionDb()
          .allTransactionsList
          .value[TransactionDb().allTransactionsList.value.length - 1];
    }
    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();
    recentTransactionsList.notifyListeners();

    await CalculateTotal();
    await getUser();
    BudgetDb().refreshUi();
  }

  Future<void> searchTransactions(String text) async {
    List<TransactionModel> allTransactions = [];
    allTransactions.addAll(allTransactionsList.value);
    expenseTransactionsList.value.clear();
    incomeTransactionsList.value.clear();
    allTransactionsList.value.clear();
    await Future.forEach(allTransactions, (TransactionModel transactions) {
      String searchText = transactions.purpose;
      searchText.toLowerCase();
      text.toLowerCase();
      if (transactions.type == CategoryType.income &&
          transactions.purpose.toLowerCase().contains(text)) {
        incomeTransactionsList.value.add(transactions);
        allTransactionsList.value.add(transactions);
      } else if ((transactions.type == CategoryType.expense &&
          transactions.purpose.toLowerCase().contains(text))) {
        expenseTransactionsList.value.add(transactions);
        allTransactionsList.value.add(transactions);
      }
    });
    expenseTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    allTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();
  }

  @override
  Future<void> findSpeciificTransaction(value, String id) async {
    final specificTransactions = await getTransactions();
    specificTransactionsList.value.clear();

    await Future.forEach(specificTransactions, (TransactionModel transactions) {
      if (transactions.categorySubType == value && transactions.id != id) {
        specificTransactionsList.value.add(transactions);
      }
    });
    specificTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    specificTransactionsList.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(value) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactionDb.delete(value);
    await refreshUI();
    await BudgetDb().AutoUpdateTotal();
  }

  @override
  Future<void> FilterByDate(DateTime start, DateTime end) async {
    List<TransactionModel> allTransactions = [];
    allTransactions.addAll(allTransactionsList.value);
    expenseTransactionsList.value.clear();
    incomeTransactionsList.value.clear();
    allTransactionsList.value.clear();

    await Future.forEach(allTransactions, (TransactionModel transactions) {
      if (transactions.type == CategoryType.income &&
          transactions.date.isAfter(start) &&
          transactions.date.isBefore(end)) {
        incomeTransactionsList.value.add(transactions);
      } else if (transactions.type == CategoryType.expense &&
          transactions.date.isAfter(start) &&
          transactions.date.isBefore(end)) {
        expenseTransactionsList.value.add(transactions);
      }

      if (transactions.date.isAfter(start) && transactions.date.isBefore(end)) {
        allTransactionsList.value.add(transactions);
      }

      if (transactions.type == CategoryType.expense &&
              transactions.date == start ||
          transactions.date == end) {
        expenseTransactionsList.value.add(transactions);
      }
      if (transactions.type == CategoryType.income &&
              transactions.date == start ||
          transactions.date == end) {
        incomeTransactionsList.value.add(transactions);
      }
      if (transactions.date == start || transactions.date == end) {
        allTransactionsList.value.add(transactions);
      }
    });

    if (allTransactionsList.value.isEmpty && CallCount == 0) {
      CallCount = 1;
      await FilterByDate(start, end);
    }

    expenseTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    allTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));

        getAllChartData();

    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();
    CallCount = 0;
  }

  @override
  Future<void> FilterByCategory(String subCategory) async {
    List<TransactionModel> allTransactions = [];
    if (allTransactionsList.value.isEmpty) {
      allTransactions.addAll(await getTransactions());
    } else {
      allTransactions.addAll(allTransactionsList.value);
    }
    expenseTransactionsList.value.clear();
    incomeTransactionsList.value.clear();
    allTransactionsList.value.clear();

    await Future.forEach(allTransactions, (TransactionModel transactions) {
      if (transactions.type == CategoryType.income &&
          transactions.categorySubType == subCategory) {
        incomeTransactionsList.value.add(transactions);
      } else if (transactions.type == CategoryType.expense &&
          transactions.categorySubType == subCategory) {
        expenseTransactionsList.value.add(transactions);
      }

      if (transactions.categorySubType == subCategory) {
        allTransactionsList.value.add(transactions);
      }
    });

    if (allTransactionsList.value.isEmpty && CallCount == 0) {
      CallCount = 1;
      await FilterByCategory(subCategory);
    }

    expenseTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    incomeTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));
    allTransactionsList.value
        .sort((first, second) => second.date.compareTo(first.date));

    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();

    CallCount = 0;
  }

  // ignore: non_constant_identifier_names
  @override
  Future<void> Sorting(int criteria) async {
    if (criteria == 0) {
      //price low to high

      expenseTransactionsList.value.sort((first, second) =>
          int.parse(first.amount).compareTo(int.parse(second.amount)));
      incomeTransactionsList.value.sort((first, second) =>
          int.parse(first.amount).compareTo(int.parse(second.amount)));
      allTransactionsList.value.sort((first, second) =>
          int.parse(first.amount).compareTo(int.parse(second.amount)));
    } else if (criteria == 1) {
      //price high to low

      expenseTransactionsList.value.sort((first, second) =>
          int.parse(second.amount).compareTo(int.parse(first.amount)));
      incomeTransactionsList.value.sort((first, second) =>
          int.parse(second.amount).compareTo(int.parse(first.amount)));
      allTransactionsList.value.sort((first, second) =>
          int.parse(second.amount).compareTo(int.parse(first.amount)));
    } else if (criteria == 2) {
      //Date ascending

      expenseTransactionsList.value
          .sort((first, second) => second.date.compareTo(first.date));
      incomeTransactionsList.value
          .sort((first, second) => second.date.compareTo(first.date));
      allTransactionsList.value
          .sort((first, second) => second.date.compareTo(first.date));
    } else if (criteria == 3) {
      //Date descending

      expenseTransactionsList.value
          .sort((first, second) => first.date.compareTo(second.date));
      incomeTransactionsList.value
          .sort((first, second) => first.date.compareTo(second.date));
      allTransactionsList.value
          .sort((first, second) => first.date.compareTo(second.date));
    }

    expenseTransactionsList.notifyListeners();
    incomeTransactionsList.notifyListeners();
    allTransactionsList.notifyListeners();
  }

  @override
  Future<int> CheckCategoryBeforeDelete(String subCategory) async {
    await refreshUI();
    int count = 0;
    await Future.forEach(allTransactionsList.value, (element) {
      if (element.categorySubType == subCategory) {
        count++;
      }
    });
    return count;
  }

  @override
  Future<void> CalculateTotal() async {

    total.value=0.0;
    income.value=0;
    expense.value=0;
    
    int year = int.parse(DateTime.now().toString().substring(0, 4));
    int month = int.parse(DateTime.now().toString().substring(5, 7));

    DateTime MonthFirst = DateTime(year,month,01).subtract(Duration(days: 1));
    DateTime MonthNow = DateTime.now();

    await Future.forEach(allTransactionsList.value, (element){
      if(element.type==CategoryType.expense && element.date.isAfter(MonthFirst) && element.date.isBefore(MonthNow)){
        expense.value = expense.value + double.parse(element.amount);
      }else if(element.type==CategoryType.income && element.date.isAfter(MonthFirst) && element.date.isBefore(MonthNow)){
        income.value = income.value + double.parse(element.amount);
      }
    });

    total.value = income.value - expense.value;

    total.notifyListeners();
    income.notifyListeners();
    expense.notifyListeners();
  }
  
  @override
  Future<void> UpdateCategory(String oldCategoryName, String newCategoryName ,CategoryType oldType , CategoryType newType) async{
    await refreshUI();
    final allTransactions = await getTransactions();
    await Future.forEach(allTransactions, (element)async{
      if(element.categorySubType == oldCategoryName && element.type == oldType){
        final insertValue = TransactionModel(id: element.id, purpose: element.purpose, amount: element.amount, date: element.date, dateSum: element.dateSum, type: newType, categorySubType: newCategoryName);
        await addTransactions(insertValue);
      }
    });

    final allDeletedTransactions = await DeletedTransactionDb().getDeletedTransactions();
    await Future.forEach(allDeletedTransactions, (element)async{
      if(element.categorySubType == oldCategoryName && element.type == oldType){
        final insertValue = DeletedModel(id: element.id, purpose: element.purpose, amount: element.amount, date: element.date, dateSum: element.dateSum, type: newType, categorySubType: newCategoryName,recieptImage: element.recieptImage,deleteDate: element.deleteDate,);
        await DeletedTransactionDb().deleteTransactions(insertValue);
      }
    });

    final budgtes = await BudgetDb().getAllBudgets();
    await Future.forEach(budgtes, (element)async{
      if(element.CategoryName == oldCategoryName){
        final insertValue = BudgetModel(CategoryName: newCategoryName, BudgetAmount: element.BudgetAmount, id: element.id, currentAmount: element.currentAmount, progress: element.progress);
        await BudgetDb().addBudget(insertValue);
      }
    });


    refreshUI();
  }
  
  @override
  Future<void> DeleteAllRelatedTransactions(String categoryName) async{
    await refreshUI();
    final allTransactions = await getTransactions();
    await Future.forEach(allTransactions, (element)async{
      if(element.categorySubType == categoryName){
        await deleteTransaction(element.id);
      }
    });

    final allBudgets = await BudgetDb().getAllBudgets();
    await Future.forEach(allBudgets, (element)async{
      if(element.CategoryName == categoryName){
        await BudgetDb().deleteBudget(element.id);
      }
    });
    BudgetDb().refreshUi();
    refreshUI();
  }
  
  @override
  Future<void> DeleteAllDb() async{
    final transactDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await transactDb.clear();

    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.clear();

    final deletedDb = await Hive.openBox<DeletedModel>(DELETE_TRANSACTION);
    await deletedDb.clear();

    final budgetDb = await Hive.openBox<BudgetModel>(BUDGET_DB);
    await budgetDb.clear();

    final userDb = await Hive.openBox<UserModel>(USER_DB);
    await userDb.clear();
  }
}
