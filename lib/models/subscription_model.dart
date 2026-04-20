import 'package:flutter/material.dart';

enum SubscriptionTier { none, pro, vip }

class SubscriptionPlan {
  final String id;
  final String name;
  final String nameAr;
  final double price;
  final String period;
  final List<String> benefits;
  final List<String> benefitsAr;
  final Color color;
  final bool isPopular;
  final IconData icon;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    this.period = 'monthly',
    required this.benefits,
    required this.benefitsAr,
    required this.color,
    this.isPopular = false,
    required this.icon,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get periodAr => period == 'monthly' ? 'شهرياً' : 'سنوياً';

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      period: json['period'] ?? 'monthly',
      benefits: List<String>.from(json['benefits'] ?? []),
      benefitsAr: List<String>.from(json['benefitsAr'] ?? []),
      color: Color(json['color'] ?? 0xFFF0B90B),
      isPopular: json['isPopular'] ?? false,
      icon: Icons.star,
    );
  }
}

class UserSubscription {
  final String userId;
  final SubscriptionTier tier;
  final DateTime? startedAt;
  final DateTime? expiresAt;
  final bool isActive;
  final bool autoRenew;

  UserSubscription({
    required this.userId,
    this.tier = SubscriptionTier.none,
    this.startedAt,
    this.expiresAt,
    this.isActive = false,
    this.autoRenew = false,
  });

  bool get isPro => tier == SubscriptionTier.pro || tier == SubscriptionTier.vip;
  bool get isVip => tier == SubscriptionTier.vip;
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  String get tierNameAr {
    switch (tier) {
      case SubscriptionTier.pro: return 'Pro';
      case SubscriptionTier.vip: return 'VIP';
      default: return 'عادي';
    }
  }

  int get daysRemaining {
    if (expiresAt == null) return 0;
    return expiresAt!.difference(DateTime.now()).inDays;
  }
}

// خطط الاشتراك الوهمية
final List<SubscriptionPlan> subscriptionPlans = [
  SubscriptionPlan(
    id: 'pro',
    name: 'Pro',
    nameAr: 'برو',
    price: 9.99,
    benefits: [
      'Free shipping on all orders',
      '10% discount on every purchase',
      'Priority customer support',
      'Early access to flash sales',
      'Exclusive Pro badges',
    ],
    benefitsAr: [
      'شحن مجاني على جميع الطلبات',
      'خصم 10% على كل عملية شراء',
      'أولوية في دعم العملاء',
      'وصول مبكر للعروض المحدودة',
      'شارات Pro حصرية',
    ],
    color: const Color(0xFF2196F3),
    icon: Icons.workspace_premium,
  ),
  SubscriptionPlan(
    id: 'vip',
    name: 'VIP',
    nameAr: 'في أي بي',
    price: 49.99,
    benefits: [
      'All Pro features included',
      '25% discount on every purchase',
      'Monthly exclusive gifts',
      'VIP-only events & sales',
      'Personal account manager',
      'Free returns & exchanges',
      'Priority processing',
    ],
    benefitsAr: [
      'جميع مميزات Pro متضمنة',
      'خصم 25% على كل عملية شراء',
      'هدايا حصرية شهرية',
      'فعاليات ومبيعات حصرية للـ VIP',
      'مدير حساب شخصي',
      'إرجاع واستبدال مجاني',
      'معالجة أولوية',
    ],
    color: const Color(0xFFF0B90B),
    isPopular: true,
    icon: Icons.diamond,
  ),
];
