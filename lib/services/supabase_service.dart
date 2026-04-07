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
    
    final supabaseUrl = dotenv.env['SUPABASE_URL']!;
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
    
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    
    _initialized = true;
    debugPrint('✅ Supabase initialized successfully');
  }

  SupabaseClient get client => Supabase.instance.client;
  
  // Auth helpers
  Future<AuthResponse> signUp(String email, String password, Map<String, dynamic> userData) async {
    final response = await client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
    return response;
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

  User? get currentUser => client.auth.currentUser;
  
  bool get isLoggedIn => currentUser != null;
  
  String? get userId => currentUser?.id;
  
  // Products
  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await client
        .from('products')
        .select('*, profiles(name, avatar_url)')
        .order('created_at', ascending: false);
    return response;
  }

  Future<Map<String, dynamic>?> getProduct(int productId) async {
    final response = await client
        .from('products')
        .select('*, profiles(name, avatar_url)')
        .eq('id', productId)
        .single();
    return response;
  }

  // Orders
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await client.from('orders').insert(orderData);
  }

  Future<List<Map<String, dynamic>>> getUserOrders() async {
    final response = await client
        .from('orders')
        .select('*, products(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return response;
  }

  // Wallet
  Future<Map<String, dynamic>?> getWallet() async {
    final response = await client
        .from('wallets')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    return response;
  }

  Future<void> updateWalletBalance(double newBalance) async {
    await client
        .from('wallets')
        .upsert({'user_id': userId, 'balance': newBalance});
  }

  // Cart
  Future<List<Map<String, dynamic>>> getCart() async {
    final response = await client
        .from('cart')
        .select('*, products(*)')
        .eq('user_id', userId);
    return response;
  }

  Future<void> addToCart(int productId, int quantity) async {
    await client.from('cart').upsert({
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    });
  }

  Future<void> removeFromCart(int productId) async {
    await client
        .from('cart')
        .delete()
        .eq('user_id', userId)
        .eq('product_id', productId);
  }

  // Banners
  Future<List<Map<String, dynamic>>> getActiveBanners() async {
    final response = await client
        .from('banners')
        .select()
        .eq('is_active', true)
        .order('order', ascending: true);
    return response;
  }
}
