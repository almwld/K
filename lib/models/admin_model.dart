enum AdminRole { superAdmin, admin, moderator, support, finance }

class AdminModel {
  final String id;
  final String name;
  final String email;
  final AdminRole role;
  final List<String> permissions;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final String? createdBy;

  AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.permissions,
    this.isActive = true,
    required this.createdAt,
    this.lastLogin,
    this.createdBy,
  });

  String get roleName {
    switch (role) {
      case AdminRole.superAdmin: return 'مدير عام';
      case AdminRole.admin: return 'مدير';
      case AdminRole.moderator: return 'مشرف محتوى';
      case AdminRole.support: return 'دعم فني';
      case AdminRole.finance: return 'مدير مالي';
    }
  }

  bool get canManageAdmins => role == AdminRole.superAdmin;
  bool get canManageUsers => permissions.contains('manage_users') || role == AdminRole.superAdmin || role == AdminRole.admin;
  bool get canManageStores => permissions.contains('manage_stores') || role == AdminRole.superAdmin || role == AdminRole.admin;
  bool get canManageProducts => permissions.contains('manage_products') || role == AdminRole.superAdmin || role == AdminRole.admin || role == AdminRole.moderator;
  bool get canManageOrders => permissions.contains('manage_orders') || role == AdminRole.superAdmin || role == AdminRole.admin;
  bool get canManageFinance => permissions.contains('manage_finance') || role == AdminRole.superAdmin || role == AdminRole.finance;
  bool get canManageCoupons => permissions.contains('manage_coupons') || role == AdminRole.superAdmin || role == AdminRole.admin;
  bool get canManageSettings => role == AdminRole.superAdmin;
  bool get canViewReports => true;
  bool get canSendNotifications => role != AdminRole.finance;

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: AdminRole.values.firstWhere((e) => e.name == json['role'], orElse: () => AdminRole.moderator),
      permissions: List<String>.from(json['permissions'] ?? []),
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      lastLogin: json['last_login'] != null ? DateTime.parse(json['last_login']) : null,
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.name,
      'permissions': permissions,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'created_by': createdBy,
    };
  }
}

class AdminStatsModel {
  final int totalUsers;
  final int totalMerchants;
  final int totalStores;
  final int totalProducts;
  final int totalOrders;
  final double totalSales;
  final int pendingVerifications;
  final int pendingOrders;
  final double todaySales;
  final int todayOrders;
  final int newUsersToday;

  AdminStatsModel({
    required this.totalUsers,
    required this.totalMerchants,
    required this.totalStores,
    required this.totalProducts,
    required this.totalOrders,
    required this.totalSales,
    required this.pendingVerifications,
    required this.pendingOrders,
    required this.todaySales,
    required this.todayOrders,
    required this.newUsersToday,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      totalUsers: json['total_users'] ?? 0,
      totalMerchants: json['total_merchants'] ?? 0,
      totalStores: json['total_stores'] ?? 0,
      totalProducts: json['total_products'] ?? 0,
      totalOrders: json['total_orders'] ?? 0,
      totalSales: (json['total_sales'] ?? 0).toDouble(),
      pendingVerifications: json['pending_verifications'] ?? 0,
      pendingOrders: json['pending_orders'] ?? 0,
      todaySales: (json['today_sales'] ?? 0).toDouble(),
      todayOrders: json['today_orders'] ?? 0,
      newUsersToday: json['new_users_today'] ?? 0,
    );
  }
}

class AdminActivityLog {
  final String id;
  final String adminId;
  final String adminName;
  final String action;
  final String targetType;
  final String? targetId;
  final String? details;
  final DateTime createdAt;

  AdminActivityLog({
    required this.id,
    required this.adminId,
    required this.adminName,
    required this.action,
    required this.targetType,
    this.targetId,
    this.details,
    required this.createdAt,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }

  factory AdminActivityLog.fromJson(Map<String, dynamic> json) {
    return AdminActivityLog(
      id: json['id'] ?? '',
      adminId: json['admin_id'] ?? '',
      adminName: json['admin_name'] ?? '',
      action: json['action'] ?? '',
      targetType: json['target_type'] ?? '',
      targetId: json['target_id'],
      details: json['details'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
