enum LoyaltyTier { bronze, silver, gold, platinum, diamond }
enum PointSource { purchase, review, referral, dailyLogin, socialShare, firstPurchase }

class LoyaltyTierInfo {
  final LoyaltyTier tier;
  final String name;
  final String nameAr;
  final int minPoints;
  final double cashbackPercentage;
  final double pointsMultiplier;
  final String icon;
  final Color color;
  final List<String> benefits;

  LoyaltyTierInfo({
    required this.tier,
    required this.name,
    required this.nameAr,
    required this.minPoints,
    required this.cashbackPercentage,
    required this.pointsMultiplier,
    required this.icon,
    required this.color,
    required this.benefits,
  });

  static List<LoyaltyTierInfo> getAllTiers() {
    return [
      LoyaltyTierInfo(
        tier: LoyaltyTier.bronze,
        name: 'Bronze',
        nameAr: 'برونزي',
        minPoints: 0,
        cashbackPercentage: 1,
        pointsMultiplier: 1.0,
        icon: '🥉',
        color: Color(0xFFCD7F32),
        benefits: ['استبدال النقاط', 'عروض حصرية'],
      ),
      LoyaltyTierInfo(
        tier: LoyaltyTier.silver,
        name: 'Silver',
        nameAr: 'فضي',
        minPoints: 1000,
        cashbackPercentage: 2,
        pointsMultiplier: 1.2,
        icon: '🥈',
        color: Color(0xFFC0C0C0),
        benefits: ['استبدال النقاط', 'عروض حصرية', 'شحن مجاني للطلبات فوق 200 ريال', 'دعم أولوي'],
      ),
      LoyaltyTierInfo(
        tier: LoyaltyTier.gold,
        name: 'Gold',
        nameAr: 'ذهبي',
        minPoints: 5000,
        cashbackPercentage: 3,
        pointsMultiplier: 1.5,
        icon: '🥇',
        color: Color(0xFFFFD700),
        benefits: ['استبدال النقاط', 'عروض حصرية', 'شحن مجاني لجميع الطلبات', 'دعم أولوي', 'هدية عيد الميلاد', 'وصول مبكر للعروض'],
      ),
      LoyaltyTierInfo(
        tier: LoyaltyTier.platinum,
        name: 'Platinum',
        nameAr: 'بلاتيني',
        minPoints: 15000,
        cashbackPercentage: 5,
        pointsMultiplier: 2.0,
        icon: '💎',
        color: Color(0xFFE5E4E2),
        benefits: ['استبدال النقاط', 'عروض حصرية', 'شحن مجاني سريع', 'دعم VIP', 'هدية عيد الميلاد', 'وصول مبكر للعروض', 'مدير حساب شخصي', 'استرجاع مجاني'],
      ),
      LoyaltyTierInfo(
        tier: LoyaltyTier.diamond,
        name: 'Diamond',
        nameAr: 'ألماسي',
        minPoints: 50000,
        cashbackPercentage: 10,
        pointsMultiplier: 3.0,
        icon: '👑',
        color: Color(0xFFB9F2FF),
        benefits: ['جميع مزايا البلاتيني', 'ضعف نقاط المشتريات', 'توصيل خلال 24 ساعة', 'دعوات حصرية للمناسبات', 'منتجات مجانية شهرية'],
      ),
    ];
  }

  static LoyaltyTierInfo getTierByPoints(int points) {
    final tiers = getAllTiers();
    for (int i = tiers.length - 1; i >= 0; i--) {
      if (points >= tiers[i].minPoints) {
        return tiers[i];
      }
    }
    return tiers.first;
  }

  static LoyaltyTierInfo getNextTier(int points) {
    final tiers = getAllTiers();
    for (var tier in tiers) {
      if (points < tier.minPoints) {
        return tier;
      }
    }
    return tiers.last;
  }
}

class UserLoyaltyModel {
  final String userId;
  final int totalPoints;
  final int lifetimePoints;
  final LoyaltyTier currentTier;
  final DateTime memberSince;
  final int streak;
  final DateTime lastLogin;
  final Map<String, dynamic> preferences;

  UserLoyaltyModel({
    required this.userId,
    this.totalPoints = 0,
    this.lifetimePoints = 0,
    required this.currentTier,
    required this.memberSince,
    this.streak = 0,
    required this.lastLogin,
    this.preferences = const {},
  });

  LoyaltyTierInfo get tierInfo => LoyaltyTierInfo.getTierByPoints(totalPoints);
  LoyaltyTierInfo get nextTierInfo => LoyaltyTierInfo.getNextTier(totalPoints);
  
  int get pointsToNextTier {
    if (currentTier == LoyaltyTier.diamond) return 0;
    return nextTierInfo.minPoints - totalPoints;
  }

  double get progressToNextTier {
    if (currentTier == LoyaltyTier.diamond) return 1.0;
    final currentTierInfo = LoyaltyTierInfo.getTierByPoints(totalPoints);
    final nextTierInfo = LoyaltyTierInfo.getNextTier(totalPoints);
    final totalNeeded = nextTierInfo.minPoints - currentTierInfo.minPoints;
    final progress = totalPoints - currentTierInfo.minPoints;
    return progress / totalNeeded;
  }

  factory UserLoyaltyModel.fromJson(Map<String, dynamic> json) {
    return UserLoyaltyModel(
      userId: json['user_id'] ?? '',
      totalPoints: json['total_points'] ?? 0,
      lifetimePoints: json['lifetime_points'] ?? 0,
      currentTier: LoyaltyTier.values.firstWhere((e) => e.name == json['current_tier'], orElse: () => LoyaltyTier.bronze),
      memberSince: DateTime.parse(json['member_since'] ?? DateTime.now().toIso8601String()),
      streak: json['streak'] ?? 0,
      lastLogin: DateTime.parse(json['last_login'] ?? DateTime.now().toIso8601String()),
      preferences: json['preferences'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_points': totalPoints,
      'lifetime_points': lifetimePoints,
      'current_tier': currentTier.name,
      'member_since': memberSince.toIso8601String(),
      'streak': streak,
      'last_login': lastLogin.toIso8601String(),
      'preferences': preferences,
    };
  }
}

class PointTransactionModel {
  final String id;
  final String userId;
  final int points;
  final PointSource source;
  final String description;
  final DateTime createdAt;
  final String? orderId;
  final DateTime? expiresAt;

  PointTransactionModel({
    required this.id,
    required this.userId,
    required this.points,
    required this.source,
    required this.description,
    required this.createdAt,
    this.orderId,
    this.expiresAt,
  });

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  String get formattedPoints => points > 0 ? '+$points' : '$points';

  factory PointTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointTransactionModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      points: json['points'] ?? 0,
      source: PointSource.values.firstWhere((e) => e.name == json['source'], orElse: () => PointSource.purchase),
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      orderId: json['order_id'],
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'points': points,
      'source': source.name,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'order_id': orderId,
      'expires_at': expiresAt?.toIso8601String(),
    };
  }
}

class RewardModel {
  final String id;
  final String title;
  final String description;
  final int pointsCost;
  final RewardType type;
  final dynamic value;
  final String imageUrl;
  final bool isActive;
  final int stock;
  final int redeemedCount;
  final DateTime validFrom;
  final DateTime validUntil;
  final int? minTier;

  RewardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsCost,
    required this.type,
    required this.value,
    required this.imageUrl,
    this.isActive = true,
    this.stock = -1,
    this.redeemedCount = 0,
    required this.validFrom,
    required this.validUntil,
    this.minTier,
  });

  bool get isAvailable {
    final now = DateTime.now();
    if (!isActive) return false;
    if (now.isBefore(validFrom) || now.isAfter(validUntil)) return false;
    if (stock != -1 && redeemedCount >= stock) return false;
    return true;
  }

  String get valueText {
    switch (type) {
      case RewardType.coupon:
        final coupon = value as Map<String, dynamic>;
        return 'كوبون ${coupon['value']}${coupon['type'] == 'percentage' ? '%' : ' ريال'}';
      case RewardType.freeShipping:
        return 'شحن مجاني';
      case RewardType.gift:
        return 'هدية: ${value['name']}';
      case RewardType.cashback:
        return 'كاش باك ${value}%';
      case RewardType.voucher:
        return 'قسيمة ${value} ريال';
    }
  }

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      pointsCost: json['points_cost'] ?? 0,
      type: RewardType.values.firstWhere((e) => e.name == json['type'], orElse: () => RewardType.coupon),
      value: json['value'],
      imageUrl: json['image_url'] ?? '',
      isActive: json['is_active'] ?? true,
      stock: json['stock'] ?? -1,
      redeemedCount: json['redeemed_count'] ?? 0,
      validFrom: DateTime.parse(json['valid_from'] ?? DateTime.now().toIso8601String()),
      validUntil: DateTime.parse(json['valid_until'] ?? DateTime.now().add(const Duration(days: 30)).toIso8601String()),
      minTier: json['min_tier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'points_cost': pointsCost,
      'type': type.name,
      'value': value,
      'image_url': imageUrl,
      'is_active': isActive,
      'stock': stock,
      'redeemed_count': redeemedCount,
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
      'min_tier': minTier,
    };
  }
}

enum RewardType { coupon, freeShipping, gift, cashback, voucher }

