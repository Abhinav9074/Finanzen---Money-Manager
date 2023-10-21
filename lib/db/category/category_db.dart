import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/categoryModel/category_model.dart';


const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String value);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> allCategoriesList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
    });
    allCategoriesList.value = [...incomeCategoryList.value,...expenseCategoryList.value];
    allCategoriesList.notifyListeners();
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.delete(value);
    refreshUI();
  }
}
