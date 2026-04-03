import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCacheService {
  static final ImageCacheService _instance = ImageCacheService._internal();
  factory ImageCacheService() => _instance;
  ImageCacheService._internal();

  static const int _maxCacheSize = 100 * 1024 * 1024; // 100 MB
  static const int _maxCacheAge = 30; // 30 يوم

  // حفظ الصورة في التخزين المحلي
  Future<File?> cacheImage(String url, String fileName) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      
      if (await file.exists()) {
        return file;
      }
      
      return null;
    } catch (e) {
      print('خطأ في تخزين الصورة: $e');
      return null;
    }
  }

  // حذف الصور القديمة
  static Future<void> clearOldCache() async {
    try {
      final directory = await getTemporaryDirectory();
      final now = DateTime.now();
      
      await for (FileSystemEntity entity in directory.list()) {
        if (entity is File) {
          final stat = await entity.stat();
          final ageDays = now.difference(stat.modified).inDays;
          if (ageDays > _maxCacheAge) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      print('خطأ في تنظيف الكاش: $e');
    }
  }

  // الحصول على حجم الكاش
  static Future<int> getCacheSize() async {
    try {
      final directory = await getTemporaryDirectory();
      int totalSize = 0;
      
      await for (FileSystemEntity entity in directory.list()) {
        if (entity is File) {
          totalSize += await entity.length();
        }
      }
      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  // حذف الكاش بالكامل
  static Future<void> clearAllCache() async {
    try {
      final directory = await getTemporaryDirectory();
      await directory.delete(recursive: true);
      await directory.create();
    } catch (e) {
      print('خطأ في حذف الكاش: $e');
    }
  }
}

// ويدجت لعرض الصور مع كاش
class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;

  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        placeholder: (context, url) => Container(
          height: height,
          width: width,
          color: isDark ? Colors.grey[800] : Colors.grey[200],
          child: Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
              ),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported),
        ),
        memCacheHeight: (height?.toInt() ?? 200) * 2,
        memCacheWidth: (width?.toInt() ?? 200) * 2,
      ),
    );
  }
}
