import 'package:supabase_flutter/supabase_flutter.dart';

class AdminService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<bool> isAdmin() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return false;

    final response = await _supabase
        .from('admin_users')
        .select()
        .eq('id', userId)
        .maybeSingle();

    return response != null;
  }

  Future<Map<String, dynamic>> getDashboardStats() async {
    // عدد المستخدمين
    final usersCount = await _supabase.from('profiles').select('id', count: CountOption.exact);

    // عدد المنتجات
    final productsCount = await _supabase.from('products').select('id', count: CountOption.exact);

    // عدد الإعلانات
    final adsCount = await _supabase.from('ads').select('id', count: CountOption.exact);

    // عدد الطلبات
    final ordersCount = await _supabase.from('orders').select('id', count: CountOption.exact);

    // إجمالي الإيرادات
    final revenue = await _supabase
        .from('orders')
        .select('total')
        .eq('payment_status', 'completed');

    double totalRevenue = 0;
    for (var order in revenue) {
      totalRevenue += (order['total'] as num).toDouble();
    }

    // عدد المستخدمين الجدد (آخر 7 أيام)
    final weekAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String();
    final newUsers = await _supabase
        .from('profiles')
        .select('id', count: CountOption.exact)
        .gte('created_at', weekAgo);

    return {
      'users': usersCount.count ?? 0,
      'products': productsCount.count ?? 0,
      'ads': adsCount.count ?? 0,
      'orders': ordersCount.count ?? 0,
      'revenue': totalRevenue,
      'newUsers': newUsers.count ?? 0,
    };
  }

  Future<List<Map<String, dynamic>>> getPendingProducts() async {
    final response = await _supabase
        .from('products')
        .select('*, seller:profiles!seller_id(name, email, phone)')
        .eq('is_approved', false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getPendingAds() async {
    final response = await _supabase
        .from('ads')
        .select('*, user:profiles!user_id(name, email, phone)')
        .eq('is_approved', false)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getPendingSellerRequests() async {
    final response = await _supabase
        .from('seller_requests')
        .select('*, user:profiles!user_id(name, email, phone)')
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final response = await _supabase
        .from('reports')
        .select('*, reporter:profiles!reporter_id(name), reported:profiles!reported_id(name)')
        .eq('status', 'pending')
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final response = await _supabase
        .from('profiles')
        .select('*')
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> approveProduct(String productId) async {
    await _supabase
        .from('products')
        .update({'is_approved': true, 'status': 'active'})
        .eq('id', productId);

    await _logAdminAction('approve_product', 'product', productId);
  }

  Future<void> rejectProduct(String productId, {String? reason}) async {
    await _supabase
        .from('products')
        .update({'is_approved': false, 'status': 'rejected'})
        .eq('id', productId);

    await _logAdminAction('reject_product', 'product', productId);
  }

  Future<void> approveAd(String adId) async {
    await _supabase
        .from('ads')
        .update({'is_approved': true, 'is_active': true})
        .eq('id', adId);

    await _logAdminAction('approve_ad', 'ad', adId);
  }

  Future<void> rejectAd(String adId, {String? reason}) async {
    await _supabase
        .from('ads')
        .update({'is_approved': false, 'is_active': false})
        .eq('id', adId);

    await _logAdminAction('reject_ad', 'ad', adId);
  }

  Future<void> approveSeller(String userId) async {
    await _supabase
        .from('profiles')
        .update({'user_type': 'merchant', 'is_verified': true})
        .eq('id', userId);

    await _supabase
        .from('seller_requests')
        .update({'status': 'approved', 'reviewed_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId);

    await _logAdminAction('approve_seller', 'user', userId);
  }

  Future<void> rejectSeller(String userId, {String? reason}) async {
    await _supabase
        .from('seller_requests')
        .update({'status': 'rejected', 'reviewed_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId);

    await _logAdminAction('reject_seller', 'user', userId);
  }

  Future<void> resolveReport(String reportId) async {
    await _supabase
        .from('reports')
        .update({'status': 'resolved', 'resolved_at': DateTime.now().toIso8601String()})
        .eq('id', reportId);

    await _logAdminAction('resolve_report', 'report', reportId);
  }

  Future<void> banUser(String userId, {String? reason}) async {
    await _supabase
        .from('profiles')
        .update({'is_active': false, 'status': 'banned'})
        .eq('id', userId);

    await _logAdminAction('ban_user', 'user', userId);
  }

  Future<void> unbanUser(String userId) async {
    await _supabase
        .from('profiles')
        .update({'is_active': true, 'status': 'active'})
        .eq('id', userId);

    await _logAdminAction('unban_user', 'user', userId);
  }

  Future<void> deleteProduct(String productId) async {
    await _supabase.from('products').delete().eq('id', productId);
    await _logAdminAction('delete_product', 'product', productId);
  }

  Future<void> deleteAd(String adId) async {
    await _supabase.from('ads').delete().eq('id', adId);
    await _logAdminAction('delete_ad', 'ad', adId);
  }

  Future<void> deleteUser(String userId) async {
    // حذف المستخدم من Auth
    await _supabase.auth.admin.deleteUser(userId);
    await _logAdminAction('delete_user', 'user', userId);
  }

  Future<void> _logAdminAction(String action, String targetType, String targetId) async {
    final adminId = _supabase.auth.currentUser?.id;
    if (adminId == null) return;

    await _supabase.from('admin_logs').insert({
      'admin_id': adminId,
      'action': action,
      'target_type': targetType,
      'target_id': targetId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getAdminLogs({int limit = 50}) async {
    final response = await _supabase
        .from('admin_logs')
        .select('*, admin:profiles!admin_id(name)')
        .order('created_at', ascending: false)
        .limit(limit);

    return List<Map<String, dynamic>>.from(response);
  }
}
