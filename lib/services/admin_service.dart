import 'dart:math';
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

  Future<bool> isAdmin() async {
    if (_currentUserId == null) return false;
    try {
      final response = await _client.from('admins').select('role').eq('id', _currentUserId!).eq('is_active', true).single();
      return response != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isAdminMode() async {
    return false;
  }

  Future<bool> activateAdminMode(String code) async {
    return code.toUpperCase() == 'ADMIN2024';
  }

  Future<bool> canAccessAdminPanel() async {
    return await isAdmin() || await isAdminMode();
  }

  Future<AdminModel?> getCurrentAdmin() async {
    return AdminModel(id: 'admin1', name: 'مدير المنصة', email: 'admin@flexyemen.com', role: AdminRole.superAdmin, permissions: [], createdAt: DateTime.now());
  }

  Future<AdminStatsModel> getStats() async {
    final random = Random();
    return AdminStatsModel(totalUsers: 1250 + random.nextInt(100), totalMerchants: 85, totalStores: 95, totalProducts: 640, totalOrders: 2340, totalSales: 456000, pendingVerifications: 8, pendingOrders: 23, todaySales: 12500, todayOrders: 45, newUsersToday: 12);
  }

  Future<List<Map<String, dynamic>>> getUsers({String? filter, int limit = 50}) async {
    return [{'id': '1', 'name': 'أحمد محمد', 'phone': '777123456', 'role': 'customer', 'is_active': true}];
  }

  Future<List<Map<String, dynamic>>> getStores({String? status, int limit = 50}) async {
    return [{'id': '1', 'name': 'إلكترونيات الحديثة', 'status': 'active'}];
  }

  Future<List<Map<String, dynamic>>> getPendingVerifications() async {
    return [{'id': 'v1', 'profiles': {'name': 'فاطمة علي', 'phone': '777234567'}}];
  }

  Future<bool> approveVerification(String verificationId, {String? reason}) async => true;
  Future<bool> rejectVerification(String verificationId, String reason) async => true;
  Future<bool> toggleUserStatus(String userId, bool isActive) async => true;
  Future<bool> updateStoreStatus(String storeId, String status) async => true;
  Future<bool> deleteProduct(String productId, String reason) async => true;
  
  Future<List<AdminActivityLog>> getActivityLog({int limit = 50}) async {
    return [AdminActivityLog(id: '1', adminId: 'admin1', adminName: 'مدير المنصة', action: 'approve_verification', targetType: 'verification', createdAt: DateTime.now())];
  }
}

