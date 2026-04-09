import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ad_model.dart';

class AdService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> createAd({
    required String title,
    required String description,
    required double price,
    double? oldPrice,
    required String category,
    String? condition,
    String? location,
    required String phone,
    String? whatsapp,
    List<String> images = const [],
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('يجب تسجيل الدخول أولاً');

    final response = await _supabase.from('ads').insert({
      'user_id': userId,
      'title': title,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'category': category,
      'condition': condition ?? 'جديد',
      'location': location,
      'phone': phone,
      'whatsapp': whatsapp,
      'images': images,
    }).select();

    return response[0];
  }

  Future<List<AdModel>> getAds({
    String? category,
    String? search,
    String? sortBy = 'newest',
    int limit = 20,
  }) async {
    // استخدام dynamic لتجنب مشاكل الأنواع
    dynamic query = _supabase.from('ads').select('*, user:user_id(name, avatar_url)');

    if (category != null && category != 'الكل') {
      query = query.eq('category', category);
    }

    if (search != null && search.isNotEmpty) {
      query = query.ilike('title', '%$search%');
    }

    // إعادة تعيين query بعد كل عملية order
    switch (sortBy) {
      case 'newest':
        query = query.order('created_at', ascending: false);
        break;
      case 'oldest':
        query = query.order('created_at', ascending: true);
        break;
      case 'price_low':
        query = query.order('price', ascending: true);
        break;
      case 'price_high':
        query = query.order('price', ascending: false);
        break;
      case 'popular':
        query = query.order('views', ascending: false);
        break;
    }

    final response = await query.limit(limit);
    return (response as List).map((ad) => AdModel.fromJson(ad)).toList();
  }

  Future<AdModel?> getAd(String adId) async {
    try {
      final response = await _supabase
          .from('ads')
          .select('*, user:user_id(name, avatar_url)')
          .eq('id', adId)
          .single();

      return AdModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<List<AdModel>> getUserAds() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase
        .from('ads')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((ad) => AdModel.fromJson(ad)).toList();
  }

  Future<void> deleteAd(String adId) async {
    await _supabase.from('ads').delete().eq('id', adId);
  }

  Future<bool> isAdLiked(String adId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final response = await _supabase
        .from('ad_likes')
        .select()
        .eq('ad_id', adId)
        .eq('user_id', userId);

    return response.isNotEmpty;
  }

  Future<void> likeAd(String adId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('ad_likes').upsert({
      'ad_id': adId,
      'user_id': userId,
    });
  }

  Future<void> unlikeAd(String adId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase
        .from('ad_likes')
        .delete()
        .eq('ad_id', adId)
        .eq('user_id', userId);
  }
}
