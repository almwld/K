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

  // ==================== المنتجات ====================
  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await client.from('products').select('*').order('created_at', ascending: false);
    return response;
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    final response = await client.from('products').select('*').eq('id', id).maybeSingle();
    return response;
  }

  static Future<void> addProduct(Map<String, dynamic> product) async {
    await client.from('products').insert(product);
  }

  // ==================== الطلبات ====================
  static Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final response = await client.from('orders').select('*').eq('user_id', userId).order('created_at', ascending: false);
    return response;
  }

  static Future<void> createOrder(Map<String, dynamic> order) async {
    await client.from('orders').insert(order);
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    await client.from('orders').update({'status': status}).eq('id', orderId);
  }

  // ==================== المزادات ====================
  static Future<List<Map<String, dynamic>>> getActiveAuctions() async {
    final response = await client.from('auctions').select('*').eq('status', 'active').order('end_time', ascending: true);
    return response;
  }

  static Future<void> placeBid(String auctionId, double amount, String userId) async {
    await client.rpc('place_bid', params: {
      'auction_id': auctionId,
      'bid_amount': amount,
      'user_id': userId,
    });
  }

  // ==================== المحفظة ====================
  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    final response = await client.from('wallets').select('*').eq('user_id', userId).maybeSingle();
    return response;
  }

  static Future<void> updateWalletBalance(String userId, double amount) async {
    await client.from('wallets').update({'balance': amount}).eq('user_id', userId);
  }

  static Future<void> createTransaction(Map<String, dynamic> transaction) async {
    await client.from('transactions').insert(transaction);
  }

  static Future<List<Map<String, dynamic>>> getTransactions(String userId) async {
    final response = await client.from('transactions').select('*').eq('user_id', userId).order('created_at', ascending: false);
    return response;
  }

  // ==================== التقييمات ====================
  static Future<void> addRating(Map<String, dynamic> rating) async {
    await client.from('ratings').insert(rating);
  }

  static Future<List<Map<String, dynamic>>> getProductRatings(String productId) async {
    final response = await client.from('ratings').select('*, profiles(*)').eq('product_id', productId).order('created_at', ascending: false);
    return response;
  }

  // ==================== الإشعارات ====================
  static Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    final response = await client.from('notifications').select('*').eq('user_id', userId).order('created_at', ascending: false);
    return response;
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    await client.from('notifications').update({'is_read': true}).eq('id', notificationId);
  }

  // ==================== الرسائل الداخلية ====================
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

  // ==================== الكوبونات ====================
  static Future<Map<String, dynamic>?> validateCoupon(String code) async {
    final response = await client.from('coupons').select('*').eq('code', code).eq('is_active', true).maybeSingle();
    return response;
  }

  // ==================== طلبات السحب ====================
  static Future<void> requestWithdrawal(Map<String, dynamic> withdrawal) async {
    await client.from('withdrawal_requests').insert(withdrawal);
  }

  // ==================== Realtime ====================
  static Stream<List<Map<String, dynamic>>> subscribeToTable(String table, {String? filterColumn, String? filterValue}) {
    var query = client.from(table).stream(primaryKey: ['id']);
    if (filterColumn != null && filterValue != null) {
      query = query.eq(filterColumn, filterValue);
    }
    return query;
  }

  // ==================== البانرات ====================
  static Future<List<Map<String, dynamic>>> getActiveBanners() async {
    final response = await client.from('banners').select('*').eq('is_active', true).order('order_index', ascending: true);
    return response;
  }

  // ==================== المتاجر ====================
  static Future<List<Map<String, dynamic>>> getStores() async {
    final response = await client.from('stores').select('*');
    return response;
  }

  static Future<Map<String, dynamic>?> getStore(String storeId) async {
    final response = await client.from('stores').select('*').eq('id', storeId).maybeSingle();
    return response;
  }

  // ==================== الملفات الشخصية ====================
  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    final response = await client.from('profiles').select('*').eq('id', userId).maybeSingle();
    return response;
  }

  static Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await client.from('profiles').update(data).eq('id', userId);
  }
}
