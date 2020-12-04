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
}
