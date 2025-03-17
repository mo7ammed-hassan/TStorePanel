import 'package:shared_preferences/shared_preferences.dart';

bool loggedIn = false;

class AuthLocalDataSource {
  static const String _isLoggedInKey = 'IS_LOGGED_IN';

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
  }
}
