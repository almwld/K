import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  static bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    
    await dotenv.load(fileName: ".env");
    
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
    
    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception('Supabase credentials not found in .env file');
    }
    
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    
    _initialized = true;
    debugPrint('✅ Supabase initialized successfully');
  }

  // طريقة مساعدة للتهيئة (للتوافق مع main.dart)
  static Future<void> initialize() async {
    final service = SupabaseService();
    await service.init();
  }

  SupabaseClient get client => Supabase.instance.client;
  
  User? get currentUser => client.auth.currentUser;
  bool get isLoggedIn => currentUser != null;
  
  String? get userId {
    final user = currentUser;
    return user?.id;
  }
  
  // تأمين userId - يرمي خطأ إذا كان null
  String get requireUserId {
    final id = userId;
    if (id == null) {
      throw Exception('User not logged in');
    }
    return id;
  }
  
  // ========== Auth Methods ==========
  Future<AuthResponse> signUp(String email, String password, Map<String, dynamic> userData) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
  }

  Future<Session?> signIn(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.session;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
  
  // ========== Products ==========
  Future<List<Map<String, dynamic>>> getProducts() async {
    return await client
        .from('products')
        .select('*, profiles(name, avatar_url)')
        .order('created_at', ascending: false);
  }
  
  Future<Map<String, dynamic>?> getProduct(int productId) async {
    return await client
        .from('products')
        .select('*, profiles(name, avatar_url)')
        .eq('id', productId)
        .single();
  }
  
  // ========== Orders ==========
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await client.from('orders').insert(orderData);
  }
  
  Future<List<Map<String, dynamic>>> getUserOrders() async {
    final uid = requireUserId;
    return await client
        .from('orders')
        .select('*, products(*)')
        .eq('user_id', uid)
        .order('created_at', ascending: false);
  }
  
  // ========== Wallet ==========
  Future<Map<String, dynamic>?> getWallet() async {
    final uid = requireUserId;
    return await client
        .from('wallets')
        .select()
        .eq('user_id', uid)
        .maybeSingle();
  }
  
  Future<void> updateWalletBalance(double newBalance) async {
    final uid = requireUserId;
    await client
        .from('wallets')
        .upsert({'user_id': uid, 'balance': newBalance});
  }
  
  // ========== Cart ==========
  Future<List<Map<String, dynamic>>> getCart() async {
    final uid = requireUserId;
    return await client
        .from('cart')
        .select('*, products(*)')
        .eq('user_id', uid);
  }
  
  Future<void> addToCart(int productId, int quantity) async {
    final uid = requireUserId;
    await client.from('cart').upsert({
      'user_id': uid,
      'product_id': productId,
      'quantity': quantity,
    });
  }
  
  Future<void> removeFromCart(int productId) async {
    final uid = requireUserId;
    await client
        .from('cart')
        .delete()
        .eq('user_id', uid)
        .eq('product_id', productId);
  }
  
  // ========== Banners ==========
  Future<List<Map<String, dynamic>>> getActiveBanners() async {
    return await client
        .from('banners')
        .select()
        .eq('is_active', true)
        .order('order', ascending: true);
  }
  
  // ========== Ratings ==========
  Future<void> addRating(int productId, int stars, String comment) async {
    final uid = requireUserId;
    await client.from('ratings').insert({
      'user_id': uid,
      'product_id': productId,
      'stars': stars,
      'comment': comment,
    });
  }
  
  Future<List<Map<String, dynamic>>> getProductRatings(int productId) async {
    return await client
        .from('ratings')
        .select('*, profiles(name)')
        .eq('product_id', productId)
        .order('created_at', ascending: false);
  }
}
