import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();

  static const String _dbName = 'image_cache.db';
  static const String _tableName = 'cached_images';
  
  Database? _database;
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT UNIQUE,
        local_path TEXT,
        created_at INTEGER
      )
    ''');
  }

  // تحميل الصورة وتخزينها محلياً
  Future<File?> downloadAndCacheImage(String url) async {
    try {
      final file = await _cacheManager.getSingleFile(url);
      if (await file.exists()) {
        // حفظ المسار في قاعدة البيانات
        final db = await database;
        await db.insert(
          _tableName,
          {
            'url': url,
            'local_path': file.path,
            'created_at': DateTime.now().millisecondsSinceEpoch,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        return file;
      }
      return null;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  // الحصول على الصورة من التخزين المؤقت
  Future<File?> getCachedImage(String url) async {
    try {
      final db = await database;
      final result = await db.query(
        _tableName,
        where: 'url = ?',
        whereArgs: [url],
      );
      
      if (result.isNotEmpty) {
        final localPath = result.first['local_path'] as String;
        final file = File(localPath);
        if (await file.exists()) {
          return file;
        }
      }
      
      // إذا لم تكن الصورة مخزنة، قم بتحميلها
      return await downloadAndCacheImage(url);
    } catch (e) {
      print('Error getting cached image: $e');
      return null;
    }
  }

  // حذف الصور القديمة (أكثر من 30 يوم)
  Future<void> cleanOldCache() async {
    final db = await database;
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30)).millisecondsSinceEpoch;
    await db.delete(
      _tableName,
      where: 'created_at < ?',
      whereArgs: [thirtyDaysAgo],
    );
  }

  // حذف جميع الصور المخزنة
  Future<void> clearCache() async {
    final db = await database;
    await db.delete(_tableName);
    await _cacheManager.emptyCache();
  }

  // التحقق من وجود الصورة في التخزين المؤقت
  Future<bool> isImageCached(String url) async {
    final db = await database;
    final result = await db.query(
      _tableName,
      where: 'url = ?',
      whereArgs: [url],
    );
    if (result.isNotEmpty) {
      final localPath = result.first['local_path'] as String;
      final file = File(localPath);
      return await file.exists();
    }
    return false;
  }

  // الحصول على حجم التخزين المؤقت
  Future<int> getCacheSize() async {
    final db = await database;
    final result = await db.query(_tableName);
    int totalSize = 0;
    for (var row in result) {
      final localPath = row['local_path'] as String;
      final file = File(localPath);
      if (await file.exists()) {
        totalSize += await file.length();
      }
    }
    return totalSize;
  }
}
