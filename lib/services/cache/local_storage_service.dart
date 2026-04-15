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

  Future<bool> saveThemeMode(String mode) async {
    await init();
    return await _prefs.setString('theme_mode', mode);
  }

  String getThemeMode() {
    return _prefs.getString('theme_mode') ?? 'system';
  }

  Future<bool> clearAll() async {
    await init();
    return await _prefs.clear();
  }
}
