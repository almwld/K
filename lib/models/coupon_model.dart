enum CouponType { percentage, fixed, freeShipping }
enum CouponScope { all, category, product, store, firstOrder, minPurchase }

class CouponModel {
  final String id;
  final String code;
  final String title;
  final String description;
  final CouponType type;
  final double value;
  final CouponScope scope;
  final String? scopeId;
  final double? minPurchaseAmount;
  final int? maxUses;
  final int usedCount;
  final DateTime validFrom;
  final DateTime validUntil;
  final bool isActive;
  final bool isPublic;
  final String? storeId;
  final String? storeName;
  final double? maxDiscountAmount;

  CouponModel({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.type,
    required this.value,
    required this.scope,
    this.scopeId,
    this.minPurchaseAmount,
    this.maxUses,
    this.usedCount = 0,
    required this.validFrom,
    required this.validUntil,
    this.isActive = true,
    this.isPublic = true,
    this.storeId,
    this.storeName,
    this.maxDiscountAmount,
  });

  bool get isValid {
    final now = DateTime.now();
    if (!isActive) return false;
    if (now.isBefore(validFrom) || now.isAfter(validUntil)) return false;
    if (maxUses != null && usedCount >= maxUses!) return false;
    return true;
  }

  String get discountText {
    switch (type) {
      case CouponType.percentage:
        return '${value.toInt()}% خصم';
      case CouponType.fixed:
        return '${value.toInt()} ريال خصم';
      case CouponType.freeShipping:
        return 'شحن مجاني';
    }
  }

  String get scopeText {
    switch (scope) {
      case CouponScope.all: return 'جميع المنتجات';
      case CouponScope.category: return 'فئة محددة';
      case CouponScope.product: return 'منتج محدد';
      case CouponScope.store: return 'متجر محدد';
      case CouponScope.firstOrder: return 'أول طلب';
      case CouponScope.minPurchase: return 'الحد الأدنى ${minPurchaseAmount} ريال';
    }
  }

  String get validityText {
    final daysLeft = validUntil.difference(DateTime.now()).inDays;
    if (daysLeft <= 0) return 'منتهي';
    if (daysLeft == 1) return 'ينتهي غداً';
    if (daysLeft <= 3) return 'ينتهي خلال $daysLeft أيام';
    return 'صالح حتى ${validUntil.day}/${validUntil.month}/${validUntil.year}';
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: CouponType.values.firstWhere((e) => e.name == json['type'], orElse: () => CouponType.percentage),
      value: (json['value'] ?? 0).toDouble(),
      scope: CouponScope.values.firstWhere((e) => e.name == json['scope'], orElse: () => CouponScope.all),
      scopeId: json['scope_id'],
      minPurchaseAmount: json['min_purchase']?.toDouble(),
      maxUses: json['max_uses'],
      usedCount: json['used_count'] ?? 0,
      validFrom: DateTime.parse(json['valid_from'] ?? DateTime.now().toIso8601String()),
      validUntil: DateTime.parse(json['valid_until'] ?? DateTime.now().add(const Duration(days: 30)).toIso8601String()),
      isActive: json['is_active'] ?? true,
      isPublic: json['is_public'] ?? true,
      storeId: json['store_id'],
      storeName: json['store_name'],
      maxDiscountAmount: json['max_discount']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'type': type.name,
      'value': value,
      'scope': scope.name,
      'scope_id': scopeId,
      'min_purchase': minPurchaseAmount,
      'max_uses': maxUses,
      'used_count': usedCount,
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
      'is_active': isActive,
      'is_public': isPublic,
      'store_id': storeId,
      'store_name': storeName,
      'max_discount': maxDiscountAmount,
    };
  }
}

class UserCouponModel {
  final String id;
  final String userId;
  final String couponId;
  final String couponCode;
  final String couponTitle;
  final String couponDescription;
  final CouponType couponType;
  final double couponValue;
  final DateTime claimedAt;
  final DateTime? usedAt;
  final bool isUsed;
  final String? orderId;

  UserCouponModel({
    required this.id,
    required this.userId,
    required this.couponId,
    required this.couponCode,
    required this.couponTitle,
    required this.couponDescription,
    required this.couponType,
    required this.couponValue,
    required this.claimedAt,
    this.usedAt,
    this.isUsed = false,
    this.orderId,
  });

  String get discountText {
    switch (couponType) {
      case CouponType.percentage: return '${couponValue.toInt()}%';
      case CouponType.fixed: return '${couponValue.toInt()} ريال';
      case CouponType.freeShipping: return 'شحن مجاني';
    }
  }

  factory UserCouponModel.fromJson(Map<String, dynamic> json) {
    return UserCouponModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      couponId: json['coupon_id'] ?? '',
      couponCode: json['coupon_code'] ?? '',
      couponTitle: json['coupon_title'] ?? '',
      couponDescription: json['coupon_description'] ?? '',
      couponType: CouponType.values.firstWhere((e) => e.name == json['coupon_type'], orElse: () => CouponType.percentage),
      couponValue: (json['coupon_value'] ?? 0).toDouble(),
      claimedAt: DateTime.parse(json['claimed_at'] ?? DateTime.now().toIso8601String()),
      usedAt: json['used_at'] != null ? DateTime.parse(json['used_at']) : null,
      isUsed: json['is_used'] ?? false,
      orderId: json['order_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'coupon_id': couponId,
      'coupon_code': couponCode,
      'coupon_title': couponTitle,
      'coupon_description': couponDescription,
      'coupon_type': couponType.name,
      'coupon_value': couponValue,
      'claimed_at': claimedAt.toIso8601String(),
      'used_at': usedAt?.toIso8601String(),
      'is_used': isUsed,
      'order_id': orderId,
    };
  }
}

