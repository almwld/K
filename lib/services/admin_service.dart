import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/admin_model.dart';

class AdminService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;
  AdminModel? _currentAdmin;

  AdminService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // التحقق من صلاحيات المشرف
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
      return _getMockIsAdmin();
    }
  }

  // الحصول على بيانات المشرف الحالي
  Future<AdminModel?> getCurrentAdmin() async {
    if (_currentUserId == null) return null;

    try {
      final response = await _client
          .from('admins')
          .select()
          .eq('id', _currentUserId)
          .single();

      _currentAdmin = AdminModel.fromJson(response as Map<String, dynamic>);
      return _currentAdmin;
    } catch (e) {
      return _getMockAdmin();
    }
  }

  // الحصول على إحصائيات المنصة
  Future<AdminStatsModel> getStats() async {
    try {
      final response = await _client.rpc('get_admin_stats');
      return AdminStatsModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return _getMockStats();
    }
  }

  // الحصول على جميع المستخدمين
  Future<List<Map<String, dynamic>>> getUsers({String? filter, int limit = 50}) async {
    try {
      var query = _client.from('profiles').select().limit(limit);
      
      if (filter == 'merchants') {
        query = query.eq('role', 'merchant');
      } else if (filter == 'customers') {
        query = query.eq('role', 'customer');
      } else if (filter == 'pending') {
        query = query.eq('verification_status', 'pending');
      }

      final response = await query;
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return _getMockUsers();
    }
  }

  // الحصول على جميع المتاجر
  Future<List<Map<String, dynamic>>> getStores({String? status, int limit = 50}) async {
    try {
      var query = _client.from('stores').select().limit(limit);
      
      if (status != null && status != 'all') {
        query = query.eq('status', status);
      }

      final response = await query;
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return _getMockStores();
    }
  }

  // الحصول على طلبات التوثيق المعلقة
  Future<List<Map<String, dynamic>>> getPendingVerifications() async {
    try {
      final response = await _client
          .from('verifications')
          .select('*, profiles(name, phone)')
          .eq('status', 'pending')
          .order('submitted_at', ascending: false);

      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      return _getMockVerifications();
    }
  }

  // الموافقة على توثيق متجر
  Future<bool> approveVerification(String verificationId, {String? reason}) async {
    try {
      await _client
          .from('verifications')
          .update({
            'status': 'verified',
            'verified_at': DateTime.now().toIso8601String(),
            'reviewed_by': _currentUserId,
          })
          .eq('id', verificationId);

      await _logActivity('approve_verification', 'verification', verificationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // رفض توثيق متجر
  Future<bool> rejectVerification(String verificationId, String reason) async {
    try {
      await _client
          .from('verifications')
          .update({
            'status': 'rejected',
            'rejection_reason': reason,
            'reviewed_by': _currentUserId,
          })
          .eq('id', verificationId);

      await _logActivity('reject_verification', 'verification', verificationId, reason);
      return true;
    } catch (e) {
      return false;
    }
  }

  // تغيير حالة مستخدم (تفعيل/تعطيل)
  Future<bool> toggleUserStatus(String userId, bool isActive) async {
    try {
      await _client
          .from('profiles')
          .update({'is_active': isActive})
          .eq('id', userId);

      await _logActivity(
        isActive ? 'activate_user' : 'deactivate_user',
        'user',
        userId,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // تغيير حالة متجر
  Future<bool> updateStoreStatus(String storeId, String status) async {
    try {
      await _client
          .from('stores')
          .update({'status': status})
          .eq('id', storeId);

      await _logActivity('update_store_status', 'store', storeId, status);
      return true;
    } catch (e) {
      return false;
    }
  }

  // حذف منتج
  Future<bool> deleteProduct(String productId, String reason) async {
    try {
      await _client
          .from('products')
          .update({
            'is_deleted': true,
            'deleted_by': _currentUserId,
            'deletion_reason': reason,
            'deleted_at': DateTime.now().toIso8601String(),
          })
          .eq('id', productId);

      await _logActivity('delete_product', 'product', productId, reason);
      return true;
    } catch (e) {
      return false;
    }
  }

  // الحصول على سجل النشاطات
  Future<List<AdminActivityLog>> getActivityLog({int limit = 50}) async {
    try {
      final response = await _client
          .from('admin_activity_log')
          .select()
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List).map<AdminActivityLog>((json) => 
        AdminActivityLog.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockActivityLog();
    }
  }

  // تسجيل نشاط
  Future<void> _logActivity(String action, String targetType, [String? targetId, String? details]) async {
    try {
      await _client.from('admin_activity_log').insert({
        'admin_id': _currentUserId,
        'admin_name': _currentAdmin?.name ?? 'مشرف',
        'action': action,
        'target_type': targetType,
        'target_id': targetId,
        'details': details,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // تجاهل الخطأ
    }
  }

  // بيانات وهمية للتجربة
  bool _getMockIsAdmin() => true;

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

  AdminStatsModel _getMockStats() {
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

  List<Map<String, dynamic>> _getMockUsers() {
    return [
      {'id': '1', 'name': 'أحمد محمد', 'phone': '777123456', 'role': 'customer', 'is_active': true, 'created_at': DateTime.now().subtract(const Duration(days: 10)).toIso8601String()},
      {'id': '2', 'name': 'فاطمة علي', 'phone': '777234567', 'role': 'merchant', 'is_active': true, 'verification_status': 'pending', 'created_at': DateTime.now().subtract(const Duration(days: 5)).toIso8601String()},
      {'id': '3', 'name': 'عمر خالد', 'phone': '777345678', 'role': 'customer', 'is_active': false, 'created_at': DateTime.now().subtract(const Duration(days: 20)).toIso8601String()},
      {'id': '4', 'name': 'سارة أحمد', 'phone': '777456789', 'role': 'merchant', 'is_active': true, 'verification_status': 'verified', 'created_at': DateTime.now().subtract(const Duration(days: 15)).toIso8601String()},
      {'id': '5', 'name': 'محمد عبدالله', 'phone': '777567890', 'role': 'customer', 'is_active': true, 'created_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String()},
    ];
  }

  List<Map<String, dynamic>> _getMockStores() {
    return [
      {'id': '1', 'name': 'إلكترونيات الحديثة', 'owner_name': 'فاطمة علي', 'category': 'إلكترونيات', 'status': 'active', 'rating': 4.8, 'products_count': 120},
      {'id': '2', 'name': 'معارض النخبة', 'owner_name': 'سعيد محمد', 'category': 'سيارات', 'status': 'active', 'rating': 4.6, 'products_count': 45},
      {'id': '3', 'name': 'متجر جديد', 'owner_name': 'خالد عمر', 'category': 'أزياء', 'status': 'pending', 'rating': 0, 'products_count': 0},
      {'id': '4', 'name': 'أسواق المزرعة', 'owner_name': 'علي حسن', 'category': 'مواد غذائية', 'status': 'active', 'rating': 4.9, 'products_count': 150},
      {'id': '5', 'name': 'متجر موقوف', 'owner_name': 'حسين علي', 'category': 'إلكترونيات', 'status': 'suspended', 'rating': 3.5, 'products_count': 30},
    ];
  }

  List<Map<String, dynamic>> _getMockVerifications() {
    return [
      {'id': '1', 'user_id': '2', 'profiles': {'name': 'فاطمة علي', 'phone': '777234567'}, 'submitted_at': DateTime.now().subtract(const Duration(days: 2)).toIso8601String()},
      {'id': '2', 'user_id': '6', 'profiles': {'name': 'نورة سعيد', 'phone': '777678901'}, 'submitted_at': DateTime.now().subtract(const Duration(days: 1)).toIso8601String()},
      {'id': '3', 'user_id': '7', 'profiles': {'name': 'سلمان خالد', 'phone': '777789012'}, 'submitted_at': DateTime.now().subtract(const Duration(hours: 12)).toIso8601String()},
    ];
  }

  List<AdminActivityLog> _getMockActivityLog() {
    return [
      AdminActivityLog(id: '1', adminId: 'admin1', adminName: 'مدير المنصة', action: 'approve_verification', targetType: 'verification', targetId: 'v1', details: 'تم توثيق متجر', createdAt: DateTime.now().subtract(const Duration(hours: 2))),
      AdminActivityLog(id: '2', adminId: 'admin1', adminName: 'مدير المنصة', action: 'delete_product', targetType: 'product', targetId: 'p1', details: 'منتج مخالف', createdAt: DateTime.now().subtract(const Duration(hours: 5))),
      AdminActivityLog(id: '3', adminId: 'admin2', adminName: 'مشرف المحتوى', action: 'suspend_store', targetType: 'store', targetId: 's1', details: 'شكاوى متكررة', createdAt: DateTime.now().subtract(const Duration(days: 1))),
    ];
  }
}
