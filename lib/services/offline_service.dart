import 'package:hive/hive.dart';

class OfflineService {
  static const String _boxName = 'flex_cache';

  static Future<void> saveData(String key, dynamic value) async {
    final box = await Hive.openBox(_boxName);
    await box.put(key, value);
  }

  static Future<dynamic> getData(String key) async {
    final box = await Hive.openBox(_boxName);
    return box.get(key);
  }

  static Future<void> clearCache() async {
    final box = await Hive.openBox(_boxName);
    await box.clear();
  }
}
