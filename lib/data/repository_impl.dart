import 'dart:convert';

import 'package:facility_maintenance/data/preferences.dart';
import 'package:facility_maintenance/data/repository.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryImpl implements Repository {
  final SharedPreferences sharedPreference;

  RepositoryImpl({
    @required this.sharedPreference,
  });

  @override
  User get getUserData {
    Map<dynamic, dynamic> valueMap =
        json.decode(sharedPreference.getString(Preferences.UserData));
    print("user values from pref =${valueMap}");
    User user = User.fromMap(valueMap);
    print("test values from pref =${user.name}");

    return user;
  }

  @override
  void saveUserData(Map<dynamic, dynamic> value) {
    print("==================saveUserData=====================\n $value");

    String valueJson = json.encode(value);
    print(
        "==================saveUserData valueJson=====================\n $value");
    sharedPreference.setString(Preferences.UserData, valueJson);
  }

  @override
  bool get isLogedIn {
    return sharedPreference.getString(Preferences.isLoggedIn) ?? false;
  }

  @override
  void setLogedIn(bool value) {
    print("==================setLogedIn=====================\n $value");
    sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  @override
  int get getUserType {
    return sharedPreference.getInt(Preferences.userType) ?? false;
  }

  @override
  void setUserType(int value) {
    print("==================UserType=====================\n $value");
    sharedPreference.setInt(Preferences.userType, value);
  }
}
