import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreferences? prefs;
  static String isLoginKey ='isLogin';
  static sharedInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void set(String key, dynamic value) async {
    if (value is int) {
      await prefs?.setInt(key, value);
    } else if (value is double) {
      await prefs?.setDouble(key, value);
    } else if (value is bool) {
      await prefs?.setBool(key, value);
    } else if (value is String) {
      await prefs?.setString(key, value);
    } else if (value is List<String>) {
      await prefs?.setStringList(key, value);
    }
  }

  static dynamic read(String key) {
    return prefs?.get(key);
  }

  static void remove(String key) async {
    await prefs?.remove(key);
  }

  static void clear() async {
    prefs?.clear();
  }
}