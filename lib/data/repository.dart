import 'package:facility_maintenance/model/user.dart';

abstract class Repository {
  void setLogedIn(bool value);

  bool get isLogedIn;

  void setUserType(int value);

  int get getUserType;

  void saveUserData(Map<dynamic, dynamic> userMap);

  User get getUserData;
}
