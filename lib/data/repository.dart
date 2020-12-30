import 'dart:async';
import 'dart:convert';

import 'package:facility_maintenance/model/user.dart';


abstract class Repository {
  // data source object
   // shared pref object
  // constructor
  Future<void> setLogedIn(bool value);
  Future<bool> get isLogedIn;
  Future<void> setUserType(int value);
  Future<int> get getUserType;

  Future<void> saveUserData(Map<dynamic, dynamic>  userMap);
  Future<User> get getUserData;
}
