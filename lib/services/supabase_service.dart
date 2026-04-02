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
    try {
      await dotenv.load();
      final url = dotenv.env['SUPABASE_URL'];
      final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
      
      if (url == null || anonKey == null) {
        debugPrint('⚠️ Supabase credentials not found in .env file');
        return;
      }
      
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
      );
      debugPrint('✅ Supabase initialized successfully');
      debugPrint('📡 URL: $url');
    } catch (e) {
      debugPrint('❌ Supabase initialization error: $e');
    }
  }

  // التحقق من الاتصال
  static Future<bool> checkConnection() async {
    try {
      await client.from('products').select().limit(1);
      return true;
    } catch (e) {
      debugPrint('Connection error: $e');
      return false;
    }
  }

  // ==================== المنتجات ====================
  static Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await client.from('products').select('*').order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('Error getting products: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getProduct(String id) async {
    try {
      final response = await client.from('products').select('*').eq('id', id).maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error getting product: $e');
      return null;
    }
  }

  static Future<void> addProduct(Map<String, dynamic> product) async {
    try {
      await client.from('products').insert(product);
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  // ==================== الطلبات ====================
  static Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    try {
      final response = await client.from('orders').select('*').eq('user_id', userId).order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('Error getting orders: $e');
      return [];
    }
  }

  static Future<void> createOrder(Map<String, dynamic> order) async {
    try {
      await client.from('orders').insert(order);
    } catch (e) {
      debugPrint('Error creating order: $e');
    }
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await client.from('orders').update({'status': status}).eq('id', orderId);
    } catch (e) {
      debugPrint('Error updating order status: $e');
    }
  }

  // ==================== المزادات ====================
  static Future<List<Map<String, dynamic>>> getActiveAuctions() async {
    try {
      final response = await client.from('auctions').select('*').eq('status', 'active').order('end_time', ascending: true);
      return response;
    } catch (e) {
      debugPrint('Error getting auctions: $e');
      return [];
    }
  }

  static Future<void> placeBid(String auctionId, double amount, String userId) async {
    try {
      await client.rpc('place_bid', params: {
        'auction_id': auctionId,
        'bid_amount': amount,
        'user_id': userId,
      });
    } catch (e) {
      debugPrint('Error placing bid: $e');
    }
  }

  // ==================== المحفظة ====================
  static Future<Map<String, dynamic>?> getWallet(String userId) async {
    try {
      final response = await client.from('wallets').select('*').eq('user_id', userId).maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error getting wallet: $e');
      return null;
    }
  }

  static Future<void> updateWalletBalance(String userId, double amount) async {
    try {
      await client.from('wallets').update({'balance': amount}).eq('user_id', userId);
    } catch (e) {
      debugPrint('Error updating wallet: $e');
    }
  }

  // ==================== الإشعارات ====================
  static Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    try {
      final response = await client.from('notifications').select('*').eq('user_id', userId).order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('Error getting notifications: $e');
      return [];
    }
  }

  static Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await client.from('notifications').update({'is_read': true}).eq('id', notificationId);
    } catch (e) {
      debugPrint('Error marking notification: $e');
    }
  }

  // ==================== الرسائل ====================
  static Future<List<Map<String, dynamic>>> getMessages(String userId, String otherUserId) async {
    try {
      final response = await client
          .from('internal_messages')
          .select('*')
          .or('sender_id.eq.$userId,receiver_id.eq.$userId')
          .order('created_at', ascending: true);
      return response;
    } catch (e) {
      debugPrint('Error getting messages: $e');
      return [];
    }
  }

  static Future<void> sendMessage(Map<String, dynamic> message) async {
    try {
      await client.from('internal_messages').insert(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  // ==================== الكوبونات ====================
  static Future<Map<String, dynamic>?> validateCoupon(String code) async {
    try {
      final response = await client.from('coupons').select('*').eq('code', code).eq('is_active', true).maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error validating coupon: $e');
      return null;
    }
  }

  // ==================== البانرات ====================
  static Future<List<Map<String, dynamic>>> getActiveBanners() async {
    try {
      final response = await client.from('banners').select('*').eq('is_active', true).order('order_index', ascending: true);
      return response;
    } catch (e) {
      debugPrint('Error getting banners: $e');
      return [];
    }
  }

  // ==================== المتاجر ====================
  static Future<List<Map<String, dynamic>>> getStores() async {
    try {
      final response = await client.from('stores').select('*');
      return response;
    } catch (e) {
      debugPrint('Error getting stores: $e');
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getStore(String storeId) async {
    try {
      final response = await client.from('stores').select('*').eq('id', storeId).maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error getting store: $e');
      return null;
    }
  }

  // ==================== الملفات الشخصية ====================
  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await client.from('profiles').select('*').eq('id', userId).maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error getting profile: $e');
      return null;
    }
  }

  static Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    try {
      await client.from('profiles').update(data).eq('id', userId);
    } catch (e) {
      debugPrint('Error updating profile: $e');
    }
  }

  // ==================== التقييمات ====================
  static Future<void> addRating(Map<String, dynamic> rating) async {
    try {
      await client.from('ratings').insert(rating);
    } catch (e) {
      debugPrint('Error adding rating: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> getProductRatings(String productId) async {
    try {
      final response = await client.from('ratings').select('*, profiles(*)').eq('product_id', productId).order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('Error getting ratings: $e');
      return [];
    }
  }
}
