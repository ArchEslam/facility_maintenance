import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kTextColor = Color(0xFF757575);

class Constants {
  Constants._();

  // splash screen assets
  static const int employee = 1;
  static const int user = 2;
}

class PreferencesConstatns {
  PreferencesConstatns._();

  static const String token = "token";
  static const String isLoggedIn = "isLoggedIn";
  static const String authToken = "authToken";
  static const String userType = "userType";
  static const String isDarkMode = "isDarkMode";
  static const String currentLanguage = "currentLanguage";
  static const String currentPageTitle = "currentPageTitle";
  static const String UserData = "UserData";
}

class NotificationConstatns {
  NotificationConstatns._();

  static const String serverToken =
      "AAAAcg-EWTA:APA91bGnzbEOhIZCa6J1_UyD01opAuVAQwNzXitq0cj1MaSc7kBVH6HItGArEYBS1ZK0vMHOMTR_kgz0eKs3QZPEmo4B1gD_kJ5y-1yPKaPcOplZvnGTsZBvVHe7xjbr8z_rt_xGZa6d";
  static const String messageContent = "messageContent";
  static const String messageType = "messageType";
  static const int returnShowItemDialog = 1;
  static const int navigateToItemDetail = 2;
}

class FCMpayload {
  FCMpayload._();

  static const String user = "1";
  static const String employee = "1";
  static const int onMessage = 1;
  static const int onLaunch = 2;
  static const int onResume = 3;
}
