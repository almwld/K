import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/admin_model.dart';

class AdminService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;
  AdminModel? _currentAdmin;
  
  static const String _adminCodeKey = 'admin_secret_code';
  static const String _isAdminModeKey = 'is_admin_mode';

  AdminService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // التحقق من صلاحيات المشرف (من قاعدة البيانات)
  Future<bool> isAdmin() async {
    if (_currentUserId == null) return false;
    
    try {
      final response = await _client
          .from('admins')
          .select('role')
          .eq('id', _currentUserId)
          .eq('is_active', true)
          .single();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  // التحقق من وضع المشرف (الكود السري)
  Future<bool> isAdminMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isAdminModeKey) ?? false;
  }

  // تفعيل وضع المشرف بالكود السري
  Future<bool> activateAdminMode(String code) async {
    // الكود السري الصحيح (يمكن تغييره)
    const secretCode = 'ADMIN2024';
    
    if (code.toUpperCase() == secretCode) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isAdminModeKey, true);
      return true;
    }
    return false;
  }

  // إلغاء وضع المشرف
  Future<void> deactivateAdminMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAdminModeKey, false);
  }

  // التحقق من صلاحية الوصول للوحة التحكم (بأي طريقة)
  Future<bool> canAccessAdminPanel() async {
    return await isAdmin() || await isAdminMode();
  }

  // الحصول على بيانات المشرف الحالي
  Future<AdminModel?> getCurrentAdmin() async {
    if (_currentUserId == null) return _getMockAdmin();

    try {
      final response = await _client
          .from('admins')
          .select()
          .eq('id', _currentUserId)
          .single();

      _currentAdmin = AdminModel.fromJson(response as Map<String, dynamic>);
      return _currentAdmin;
    } catch (e) {
      // إذا كان في وضع المشرف بالكود السري
      if (await isAdminMode()) {
        return _getMockAdmin();
      }
      return null;
    }
  }

  // بقية الدوال كما هي...
  AdminModel _getMockAdmin() {
    return AdminModel(
      id: 'admin1',
      name: 'مدير المنصة',
      email: 'admin@flexyemen.com',
      role: AdminRole.superAdmin,
      permissions: ['manage_users', 'manage_stores', 'manage_products', 'manage_orders', 'manage_finance', 'manage_settings'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLogin: DateTime.now(),
    );
  }

  Future<AdminStatsModel> getStats() async {
    final random = Random();
    return AdminStatsModel(
      totalUsers: 1250 + random.nextInt(100),
      totalMerchants: 85 + random.nextInt(10),
      totalStores: 95 + random.nextInt(10),
      totalProducts: 640 + random.nextInt(50),
      totalOrders: 2340 + random.nextInt(100),
      totalSales: 456000 + random.nextInt(50000).toDouble(),
      pendingVerifications: 8 + random.nextInt(5),
      pendingOrders: 23 + random.nextInt(10),
      todaySales: 12500 + random.nextInt(3000).toDouble(),
      todayOrders: 45 + random.nextInt(15),
      newUsersToday: 12 + random.nextInt(8),
    );
  }

  Future<List<Map<String, dynamic>>> getUsers({String? filter, int limit = 50}) async {
    return [
      {'id': '1', 'name': 'أحمد محمد', 'phone': '777123456', 'role': 'customer', 'is_active': true, 'created_at': DateTime.now().subtract(const Duration(days: 10)).toIso8601String()},
      {'id': '2', 'name': 'فاطمة علي', 'phone': '777234567', 'role': 'merchant', 'is_active': true, 'verification_status': 'pending', 'created_at': DateTime.now().subtract(const Duration(days: 5)).toIso8601String()},
      {'id': '3', 'name': 'عمر خالد', 'phone': '777345678', 'role': 'customer', 'is_active': false, 'created_at': DateTime.now().subtract(const Duration(days: 20)).toIso8601String()},
    ];
  }

  Future<List<Map<String, dynamic>>> getStores({String? status, int limit = 50}) async {
    return [
      {'id': '1', 'name': 'إلكترونيات الحديثة', 'owner_name': 'فاطمة علي', 'category': 'إلكترونيات', 'status': 'active', 'rating': 4.8, 'products_count': 120, 'verification_id': 'v1'},
      {'id': '2', 'name': 'متجر جديد', 'owner_name': 'خالد عمر', 'category': 'أزياء', 'status': 'pending', 'rating': 0, 'products_count': 0, 'verification_id': 'v2'},
    ];
  }

  Future<List<Map<String, dynamic>>> getPendingVerifications() async {
    return [
      {'id': 'v1', 'profiles': {'name': 'فاطمة علي', 'phone': '777234567'}},
      {'id': 'v2', 'profiles': {'name': 'خالد عمر', 'phone': '777345678'}},
    ];
  }

  Future<bool> approveVerification(String verificationId, {String? reason}) async => true;
  Future<bool> rejectVerification(String verificationId, String reason) async => true;
  Future<bool> toggleUserStatus(String userId, bool isActive) async => true;
  Future<bool> updateStoreStatus(String storeId, String status) async => true;
  Future<bool> deleteProduct(String productId, String reason) async => true;
  
  Future<List<AdminActivityLog>> getActivityLog({int limit = 50}) async {
    return [
      AdminActivityLog(id: '1', adminId: 'admin1', adminName: 'مدير المنصة', action: 'approve_verification', targetType: 'verification', targetId: 'v1', createdAt: DateTime.now().subtract(const Duration(hours: 2))),
      AdminActivityLog(id: '2', adminId: 'admin1', adminName: 'مدير المنصة', action: 'delete_product', targetType: 'product', targetId: 'p1', createdAt: DateTime.now().subtract(const Duration(hours: 5))),
    ];
  }
}
