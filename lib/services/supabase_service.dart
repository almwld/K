import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static SupabaseClient? _client;

  static SupabaseClient get client {
    if (_client == null) {
      _client = Supabase.instance.client;
    }
    return _client!;
  }

  static Future<void> initialize() async {
    await dotenv.load();
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }

  // المنتجات
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await client.from('products').select('*').order('created_at', ascending: false);
    return response;
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    final response = await client.from('products').select('*').eq('id', id).maybeSingle();
    return response;
  }

  // الطلبات
  static Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final response = await client.from('orders').select('*').eq('user_id', userId).order('created_at', ascending: false);
    return response;
  }

  static Future<void> createOrder(Map<String, dynamic> order) async {
    await client.from('orders').insert(order);
  }

  // المزادات
  static Future<List<Map<String, dynamic>>> getActiveAuctions() async {
    final response = await client.from('auctions').select('*').eq('status', 'active').order('end_time', ascending: true);
    return response;
  }

  // المحفظة
  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    final response = await client.from('wallets').select('*').eq('user_id', userId).maybeSingle();
    return response;
  }

  // الإشعارات
  static Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    final response = await client.from('notifications').select('*').eq('user_id', userId).order('created_at', ascending: false);
    return response;
  }

  // الرسائل
  static Future<List<Map<String, dynamic>>> getMessages(String userId, String otherUserId) async {
    final response = await client
        .from('internal_messages')
        .select('*')
        .or('sender_id.eq.$userId,receiver_id.eq.$userId')
        .order('created_at', ascending: true);
    return response;
  }

  static Future<void> sendMessage(Map<String, dynamic> message) async {
    await client.from('internal_messages').insert(message);
  }

  // البانرات
  static Future<List<Map<String, dynamic>>> getActiveBanners() async {
    final response = await client.from('banners').select('*').eq('is_active', true).order('order_index', ascending: true);
    return response;
  }
}
