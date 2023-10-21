import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/deletedModel/deleted_model.dart';


abstract class DeletedTransactions {
  Future<void> deleteTransactions(DeletedModel values);
  Future<List<DeletedModel>> getDeletedTransactions();
  Future<void> DeleteForever(String id);
  Future<void> AutoDeleting(BuildContext ctx);
}

const DELETE_TRANSACTION = 'deleted_database';

class DeletedTransactionDb implements DeletedTransactions {
  DeletedTransactionDb._internal();

  static DeletedTransactionDb instance = DeletedTransactionDb._internal();

  factory DeletedTransactionDb() {
    return instance;
  }

  ValueNotifier<List<DeletedModel>> deletedTransactionNotifier =
      ValueNotifier([]);

  @override
  Future<void> deleteTransactions(DeletedModel values) async {
    final deletedTransactiondb =
        await Hive.openBox<DeletedModel>(DELETE_TRANSACTION);
    await deletedTransactiondb.put(values.id, values);
    refreshUI();
  }

  @override
  Future<List<DeletedModel>> getDeletedTransactions() async {
    final deletedTransactiondb =
        await Hive.openBox<DeletedModel>(DELETE_TRANSACTION);
    return deletedTransactiondb.values.toList();
  }

  @override
  Future<void> refreshUI() async {
    deletedTransactionNotifier.notifyListeners();
    final transactions = await getDeletedTransactions();
    deletedTransactionNotifier.value.clear();
    await Future.forEach(transactions, (DeletedModel deletedTransactions) {
      deletedTransactionNotifier.value.add(deletedTransactions);
    });

    deletedTransactionNotifier.notifyListeners();
  }

  @override
  Future<void> DeleteForever(String id) async {
    final deletedTransactiondb =
        await Hive.openBox<DeletedModel>(DELETE_TRANSACTION);
    await deletedTransactiondb.delete(id);
    refreshUI();
  }

  @override
  Future<void> AutoDeleting(BuildContext ctx) async {
    final transactions = await getDeletedTransactions();

    await Future.forEach(transactions, (DeletedModel element) async {
      if (element.deleteDate.isBefore(DateTime.now())) {
        await DeleteForever(element.id);
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(
          '${element.purpose} Transaction Deleted From Recents',
          style: TextStyle(fontFamily: 'texgyreadventor-regular'),
        ),behavior: SnackBarBehavior.floating,));
      }
    });
  }
}
