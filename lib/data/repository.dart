import 'dart:async';

import 'package:facility_maintenance/model/user.dart';

abstract class Repository {
  Future<void> setLogedIn(bool value);

  Future<bool> get isLogedIn;

  Future<void> setUserType(int value);

  Future<int> get getUserType;

  Future<void> saveUserData(Map<dynamic, dynamic> userMap);

  Future<User> get getUserData;
}
