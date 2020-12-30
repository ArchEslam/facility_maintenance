import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  addUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", userId);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("id").toString();
  }

  addUserBldg(String selectedBuilding) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("building", selectedBuilding);
  }

  getUserBldg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString("building").toString();
  }

  addUserName(String _infoName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", _infoName);
  }

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name").toString();
  }

  addUserPhone(String _infoPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", _infoPhone);
  }

  getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phone").toString();
  }

  addUserMail(String _infoMail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mail", _infoMail);
  }

  getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("mail").toString();
  }

  addUserFlat(String _infoFlat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("flat", _infoFlat);
  }

  getUserFlat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("flat").toString();
  }

// End of Saving User Data

// Start of Saving Employee Data

  addEmployeeId(String employeeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("id", employeeId);
  }

  getEmployeeId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id").toString();
  }

// End of Saving Employee Data
}
