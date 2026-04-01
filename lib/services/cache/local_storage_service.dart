import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  static late Box _hiveBox;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    // Initialize Hive
    await Hive.initFlutter();
    _hiveBox = await Hive.openBox('flex_yemen_cache');

    // Initialize SharedPreferences
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

  // Hive Methods (for complex data)
  static Future<void> put(String key, dynamic value) async {
    await _hiveBox.put(key, value);
  }

  static dynamic get(String key, {dynamic defaultValue}) {
    return _hiveBox.get(key, defaultValue: defaultValue);
  }

  static Future<void> delete(String key) async {
    await _hiveBox.delete(key);
  }

  static Future<void> putAll(Map<String, dynamic> entries) async {
    await _hiveBox.putAll(entries);
  }

  static Future<void> clearHive() async {
    await _hiveBox.clear();
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
    await remove('user_type');
  }

  // Theme Related
  static Future<void> setDarkMode(bool isDark) async {
    await setBool('is_dark_mode', isDark);
  }

  static bool isDarkMode() {
    return getBool('is_dark_mode', defaultValue: false);
  }

  // Language Related
  static Future<void> setLanguage(String languageCode) async {
    await setString('language_code', languageCode);
  }

  static String getLanguage() {
    return getString('language_code') ?? 'ar';
  }

  // Cache Related
  static Future<void> cacheData(String key, dynamic data, {Duration? expiry}) async {
    final cacheEntry = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await put('cache_$key', cacheEntry);
  }

  static dynamic getCachedData(String key) {
    final cacheEntry = get('cache_$key');
    if (cacheEntry == null) return null;

    final expiry = cacheEntry['expiry'];
    if (expiry != null) {
      final timestamp = cacheEntry['timestamp'];
      final now = DateTime.now().millisecondsSinceEpoch;
      if (now - timestamp > expiry) {
        delete('cache_$key');
        return null;
      }
    }

    return cacheEntry['data'];
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

  static Future<void> setLastLoginDate(String date) async {
    await setString('last_login_date', date);
  }

  static String? getLastLoginDate() {
    return getString('last_login_date');
  }

  // User Type
  static Future<void> setUserType(String userType) async {
    await setString('user_type', userType);
  }

  static String? getUserType() {
    return getString('user_type');
  }

  // Theme Color
  static Future<void> setThemeColor(int colorValue) async {
    await setInt('theme_color', colorValue);
  }

  static int getThemeColor() {
    return getInt('theme_color', defaultValue: 0xFFD4AF37);
  }
}
