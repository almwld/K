import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  // SharedPreferences Methods
  static Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  static Future<bool> clear() async {
    return await _prefs.clear();
  }

  // Auth Related
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await setString('user_data', jsonEncode(userData));
    await setBool('is_logged_in', true);
  }

  static Map<String, dynamic>? getUserData() {
    final data = getString('user_data');
    if (data != null) {
      try {
        return jsonDecode(data) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static bool isLoggedIn() {
    return getBool('is_logged_in', defaultValue: false);
  }

  static Future<void> clearUserData() async {
    await remove('user_data');
    await setBool('is_logged_in', false);
  }

  // Theme Related
  static Future<void> setDarkMode(bool isDark) async {
    await setBool('is_dark_mode', isDark);
  }

  static bool isDarkMode() {
    return getBool('is_dark_mode', defaultValue: false);
  }

  // Garden Points
  static Future<void> setGardenPoints(int points) async {
    await setInt('garden_points', points);
  }

  static int getGardenPoints() {
    return getInt('garden_points', defaultValue: 0);
  }

  static Future<void> setStreakDays(int days) async {
    await setInt('streak_days', days);
  }

  static int getStreakDays() {
    return getInt('streak_days', defaultValue: 0);
  }
}
