import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyLastSearch = 'last_search';
  static const String _keyFavoriteCategories = 'favorite_categories';
  static const String _keyDefaultSort = 'default_sort';

  static Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  static Future<void> setDarkMode(bool value) async {
    final prefs = await _instance;
    await prefs.setBool(_keyDarkMode, value);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await _instance;
    return prefs.getBool(_keyDarkMode) ?? true;
  }

  static Future<void> setLastSearch(String query) async {
    final prefs = await _instance;
    await prefs.setString(_keyLastSearch, query);
  }

  static Future<String?> getLastSearch() async {
    final prefs = await _instance;
    return prefs.getString(_keyLastSearch);
  }
}
