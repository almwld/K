import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();

  Future<List<File>> pickImages({int maxCount = 5}) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isEmpty) return [];
    
    return pickedFiles.take(maxCount).map((file) => File(file.path)).toList();
  }

  Future<File?> pickSingleImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  }

  Future<File?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return null;
    return File(photo.path);
  }

  Future<List<String>> uploadAdImages(List<File> images, String adId) async {
    List<String> imageUrls = [];
    
    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      final fileExt = file.path.split('.').last;
      final fileName = 'ads/$adId/${DateTime.now().millisecondsSinceEpoch}_$i.$fileExt';
      
      await _supabase.storage.from('ads').upload(fileName, file);
      final imageUrl = _supabase.storage.from('ads').getPublicUrl(fileName);
      imageUrls.add(imageUrl);
    }
    
    return imageUrls;
  }

  Future<List<String>> uploadProductImages(List<File> images, String productId) async {
    List<String> imageUrls = [];
    
    for (int i = 0; i < images.length; i++) {
      final file = images[i];
      final fileExt = file.path.split('.').last;
      final fileName = 'products/$productId/${DateTime.now().millisecondsSinceEpoch}_$i.$fileExt';
      
      await _supabase.storage.from('products').upload(fileName, file);
      final imageUrl = _supabase.storage.from('products').getPublicUrl(fileName);
      imageUrls.add(imageUrl);
    }
    
    return imageUrls;
  }

  Future<void> deleteImage(String url) async {
    final fileName = url.split('/').last;
    final bucket = url.contains('/ads/') ? 'ads' : 'products';
    await _supabase.storage.from(bucket).remove([fileName]);
  }

  Future<void> deleteAllImages(String adId) async {
    final files = await _supabase.storage.from('ads').list(path: 'ads/$adId/');
    for (final file in files) {
      await _supabase.storage.from('ads').remove(['ads/$adId/${file.name}']);
    }
  }
}
