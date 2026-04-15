import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  late SharedPreferences _prefs;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // ============ Theme Methods ============
  bool get isDarkMode {
    final mode = _prefs.getString('theme_mode') ?? 'light';
    return mode == 'dark';
  }

  Future<void> setDarkMode(bool value) async {
    await init();
    await _prefs.setString('theme_mode', value ? 'dark' : 'light');
  }

  Future<bool> saveThemeMode(String mode) async {
    await init();
    return await _prefs.setString('theme_mode', mode);
  }

  String getThemeMode() {
    return _prefs.getString('theme_mode') ?? 'system';
  }

  // ============ Garden Methods ============
  int getGardenPoints() {
    return _prefs.getInt('garden_points') ?? 0;
  }

  Future<void> setGardenPoints(int points) async {
    await init();
    await _prefs.setInt('garden_points', points);
  }

  int getStreakDays() {
    return _prefs.getInt('streak_days') ?? 0;
  }

  Future<void> setStreakDays(int days) async {
    await init();
    await _prefs.setInt('streak_days', days);
  }

  // ============ Generic Methods ============
  Future<bool> saveData(String key, dynamic data) async {
    await init();
    final jsonString = json.encode(data);
    return await _prefs.setString(key, jsonString);
  }

  dynamic getData(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }

  Future<bool> cacheProducts(String category, List<dynamic> products) async {
    return await saveData('products_$category', products);
  }

  List<dynamic>? getCachedProducts(String category) {
    return getData('products_$category') as List<dynamic>?;
  }

  Future<bool> saveCart(List<Map<String, dynamic>> cart) async {
    return await saveData('cart', cart);
  }

  List<Map<String, dynamic>> getCart() {
    final data = getData('cart');
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
    return [];
  }

  Future<bool> clearAll() async {
    await init();
    return await _prefs.clear();
  }

  bool hasData(String key) {
    return _prefs.containsKey(key);
  }
}
