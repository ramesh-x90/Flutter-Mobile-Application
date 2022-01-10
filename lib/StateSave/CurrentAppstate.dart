// ignore_for_file: avoid_init_to_null

import 'package:hello_world/Classes/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentAppState {
  static User _currentUser = User('Loading', 'Loading', 'null', 'Loading');
  static Function? setNavDrawerHeader;
  static late SharedPreferences prefs;
  static int onlineUserCount = 0;

  static void setCurrentUser(User user) {
    _currentUser = user;
    if (setNavDrawerHeader != null) setNavDrawerHeader!(user);
  }

  static User getCurrentUser() {
    return _currentUser;
  }

  static void setNavDrawerCallBack(Function fn) {
    setNavDrawerHeader = fn;
  }

  static void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void sharedPreferencesStringSave(String key, String value) async {
    var res = await getPreferencesStringvalue(key);
    if (res == null) {
      prefs.setString(key, value);
      print(key + " " + value);
    }
  }

  static dynamic getPreferencesStringvalue(String key) async {
    var value = prefs.getString(key);
    return value;
  }

  static void removeSP(String key) async {
    prefs.remove(key);
  }
}
