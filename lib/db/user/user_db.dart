import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/userModel/user_model.dart';

const USER_DB = "user_database";

ValueNotifier<String> userProfileNotifier = ValueNotifier('');
ValueNotifier<String> userNameNotifier = ValueNotifier('');

Future<void>addUser(UserModel values)async{
  final userDb = await Hive.openBox<UserModel>(USER_DB);
  await userDb.put(values.id, values);
  getUser();
}

Future<void>getUser()async{
  final userDb = await Hive.openBox<UserModel>(USER_DB);
 if(userDb.isNotEmpty){
   userProfileNotifier.value = userDb.values.toList()[0].profilePicture;
   userNameNotifier.value = userDb.values.toList()[0].userName;
 }
}

