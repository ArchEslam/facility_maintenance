import 'dart:convert';

import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class MySharedPreferencesImpl implements MySharedPreferences {
  final SharedPreferences sharedPreference;

  MySharedPreferencesImpl({
    @required this.sharedPreference,
  });

  @override
  User get getUserData {
    Map<dynamic, dynamic> valueMap =
        json.decode(sharedPreference.getString(PreferencesConstatns.UserData));
    // print("user values from pref =${valueMap}");
    User user = User.fromMap(valueMap);
    // print("test values from pref =${user.name}");

    return user;
  }

  @override
  void saveUserData(Map<dynamic, dynamic> value) {
    String valueJson = json.encode(value);
    // print("==================saveUserData valueJson=====================\n ${json.encode(value)}");
    sharedPreference.setString(
        PreferencesConstatns.UserData, json.encode(value));
  }

  @override
  bool get isLogedIn {
    return sharedPreference.getString(PreferencesConstatns.isLoggedIn) ?? false;
  }

  @override
  void setLogedIn(bool value) {
    // print("==================setLogedIn=====================\n $value");
    sharedPreference.setBool(PreferencesConstatns.isLoggedIn, value);
  }

  @override
  int get getUserType {
    return sharedPreference.getInt(PreferencesConstatns.userType) ?? false;
  }

  @override
  void setUserType(int value) {
    //  print("==================UserType=====================\n $value");
    sharedPreference.setInt(PreferencesConstatns.userType, value);
  }

  @override
  dynamic get getToken =>
      sharedPreference.getString(PreferencesConstatns.token) ?? "";

  @override
  void setToke(String value) {
    sharedPreference.setString(PreferencesConstatns.token, value);
  }
}
