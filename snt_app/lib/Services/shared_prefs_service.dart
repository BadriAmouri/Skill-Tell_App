import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snt_app/Models/user_model.dart';

class SharedPrefsService {
  static const String _isLoggedInKey = 'isUserLoggedIn';
  static const String _userKey = 'userData';

  // Existing login methods
  static Future<void> setIsLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> getIsLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // New user data methods
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(user.toJson());
    await prefs.setString(_userKey, userData);
    await setIsLoggedIn(true); // Set logged in when saving user
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      final Map<String, dynamic> jsonData = json.decode(userData);
      return UserModel.fromJson(jsonData, jsonData['email']);
    }
    return null;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await setIsLoggedIn(false);
  }
}