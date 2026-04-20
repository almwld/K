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
    
    // تحميل .env من المسار الصحيح
    await dotenv.load(fileName: ".env");
    
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
    
    if (supabaseUrl == null || supabaseAnonKey == null) {
      debugPrint('⚠️ Warning: Supabase credentials not found in .env file');
      debugPrint('Using fallback values for development');
      // قيم افتراضية للتطوير (لن تعمل لكن تمنع الخطأ)
      await Supabase.initialize(
        url: 'https://placeholder.supabase.co',
        anonKey: 'placeholder-key',
      );
      _initialized = true;
      return;
    }
    
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    
    _initialized = true;
    debugPrint('✅ Supabase initialized successfully');
  }

  // طريقة مساعدة للتهيئة
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
  
  String get requireUserId {
    final id = userId;
    if (id == null) {
      throw Exception('User not logged in');
    }
    return id;
  }
  
  // =======