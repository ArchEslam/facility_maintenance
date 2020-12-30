import 'dart:convert';

import 'package:facility_maintenance/data/preferences.dart';
import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryImpl implements Repository {
  final SharedPreferences sharedPreference;

  RepositoryImpl(
      {@required this.sharedPreference,});
  @override
  Future<User> get getUserData async {
    Map valueMap = json.decode(json.encode(await sharedPreference.getString(Preferences.UserData)));
    User user =User.fromMap(valueMap);
    return  user ?? null;
  }

  @override
  Future<void> saveUserData(Map<dynamic, dynamic> value) async {
    print("==================saveUserData=====================\n $value");

    String valueJson = json.encode(value);
    print("==================saveUserData valueJson=====================\n $value");
    await sharedPreference..setString(Preferences.UserData, valueJson);
  }

  @override
  Future<bool> get isLogedIn async {
   return await sharedPreference.getString(Preferences.isLoggedIn) ?? false;
  }
  @override
  Future<void> setLogedIn(bool value) async{
    print("==================setLogedIn=====================\n $value");
    await sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  @override
  Future<int> get getUserType async{
    return await  sharedPreference.getInt(Preferences.userType) ?? false;
}
  @override
  Future<void> setUserType(int value) async {
    print("==================UserType=====================\n $value");
    await sharedPreference.setInt(Preferences.userType, value);
  }
}
