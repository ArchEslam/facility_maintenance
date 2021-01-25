import 'package:facility_maintenance/model/user.dart';

abstract class MySharedPreferences {
  void setLogedIn(bool value);

  bool get isLogedIn;

  void setUserType(int value);

  int get getUserType;

  void saveUserData(Map<dynamic, dynamic> userMap);

  User get getUserData;

  void setToke(String value);

  String get getToken;
}
