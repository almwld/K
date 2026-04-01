import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // Auth methods
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
    return response;
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static User? get currentUser => _client.auth.currentUser;
  static Session? get currentSession => _client.auth.currentSession;
  static bool get isAuthenticated => currentUser != null;

  // Database methods
  static Future<List<Map<String, dynamic>>> getData(String table, {Map<String, dynamic>? filters}) async {
    var query = _client.from(table).select();
    
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
    
    final response = await query;
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<Map<String, dynamic>?> getById(String table, String id) async {
    final response = await _client.from(table).select().eq('id', id).single();
    return response;
  }

  static Future<void> insertData(String table, Map<String, dynamic> data) async {
    await _client.from(table).insert(data);
  }

  static Future<void> updateData(String table, String id, Map<String, dynamic> data) async {
    await _client.from(table).update(data).eq('id', id);
  }

  static Future<void> deleteData(String table, String id) async {
    await _client.from(table).delete().eq('id', id);
  }

  // User profile methods
  static Future<UserModel?> getUserProfile(String userId) async {
    try {
      final response = await _client.from('users').select().eq('id', userId).single();
      return UserModel.fromJson(response);
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return null;
    }
  }

  static Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _client.from('users').update(data).eq('id', userId);
  }

  // Products methods
  static Future<List<Map<String, dynamic>>> getProducts({String? category, String? city, int? limit}) async {
    var query = _client.from('products').select();
    
    if (category != null) {
      query = query.eq('category', category);
    }
    if (city != null) {
      query = query.eq('city', city);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    
    final response = await query.order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  static Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final response = await _client
        .from('products')
        .select()
        .ilike('title', '%$query%')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  // Real-time subscriptions
  static Stream<List<Map<String, dynamic>>> subscribeToTable(String table) {
    return _client.from(table).stream(primaryKey: ['id']);
  }

  // Storage methods
  static Future<String> uploadFile(String bucket, String path, List<int> file) async {
    final response = await _client.storage.from(bucket).uploadBinary(path, file);
    return response;
  }

  static String getFileUrl(String bucket, String path) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
