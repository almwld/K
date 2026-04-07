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

  SupabaseClient get client => Supabase.instance.client;
  
  User? get currentUser => client.auth.currentUser;
  bool get isLoggedIn => currentUser != null;
  String? get userId => currentUser?.id;
  
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
  
  // ========== Orders ==========
  Future<void> createOrder(Map<String, dynamic> orderData) async {
    await client.from('orders').insert(orderData);
  }
  
  // ========== Wallet ==========
  Future<Map<String, dynamic>?> getWallet() async {
    return await client
        .from('wallets')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
  }
  
  // ========== Cart ==========
  Future<List<Map<String, dynamic>>> getCart() async {
    return await client
        .from('cart')
        .select('*, products(*)')
        .eq('user_id', userId);
  }
  
  // ========== Banners ==========
  Future<List<Map<String, dynamic>>> getActiveBanners() async {
    return await client
        .from('banners')
        .select()
        .eq('is_active', true)
        .order('order', ascending: true);
  }
}
