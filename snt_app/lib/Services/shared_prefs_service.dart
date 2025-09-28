
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _isLoggedInKey = 'isUserLoggedIn';

  static Future<void> setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}