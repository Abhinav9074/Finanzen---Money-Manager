import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';
@HiveType(typeId: 5)
class UserModel{

  @HiveField(0)
  final String profilePicture;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String id;

  UserModel({required this.profilePicture, required this.userName, required this.id});
}