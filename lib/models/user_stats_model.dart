import 'package:flutter/material.dart';

enum UserLevel { bronze, silver, gold, platinum, diamond }

class UserStatsModel {
  final String userId;
  final double totalSpent;
  final int ordersCount;
  final int completedOrders;
  final int cancelledOrders;
  final int loyaltyPoints;
  final UserLevel level;
  final double monthlySpent;
  final double yearlySpent;
  final int reviewsGiven;
  final double avgRating;
  final int favoritesCount;
  final int couponsUsed;
  final DateTime memberSince;
  final List<String> achievements;

  UserStatsModel({
    required this.userId,
    this.totalSpent = 0,
    this.ordersCount = 0,
    this.completedOrders = 0,
    this.cancelledOrders = 0,
    this.loyaltyPoints = 0,
    this.level = UserLevel.bronze,
    this.monthlySpent = 0,
    this.yearlySpent = 0,
    this.reviewsGiven = 0,
    this.avgRating = 0,
    this.favoritesCount = 0,
    this.couponsUsed = 0,
    DateTime? memberSince,
    this.achievements = const [],
  }) : memberSince = memberSince ?? DateTime.now();

  String get levelNameAr {
    switch (level) {
      case UserLevel.bronze: return 'برونزي';
      case UserLevel.silver: return 'فضي';
      case UserLevel.gold: return 'ذهبي';
      case UserLevel.platinum: return 'بلاتيني';
      case UserLevel.diamond: return 'ألماسي';
    }
  }

  Color get levelColor {
    switch (level) {
      case UserLevel.bronze: return const Color(0xFFCD7F32);
      case UserLevel.silver: return const Color(0xFFC0C0C0);
      case UserLevel.gold: return const Color(0xFFFFD700);
      case UserLevel.platinum: return const Color(0xFFE5E4E2);
      case UserLevel.diamond: return const Color(0xFFB9F2FF);
    }
  }

  int get pointsToNextLevel {
    switch (level) {
      case UserLevel.bronze: return 1000 - loyaltyPoints;
      case UserLevel.silver: return 5000 - loyaltyPoints;
      case UserLevel.gold: return 15000 - loyaltyPoints;
      case UserLevel.platinum: return 50000 - loyaltyPoints;
      case UserLevel.diamond: return 0;
    }
  }

  double get levelProgress {
    switch (level) {
      case UserLevel.bronze: return loyaltyPoints / 1000;
      case UserLevel.silver: return (loyaltyPoints - 1000) / 4000;
      case UserLevel.gold: return (loyaltyPoints - 5000) / 10000;
      case UserLevel.platinum: return (loyaltyPoints - 15000) / 35000;
      case UserLevel.diamond: return 1.0;
    }
  }

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      userId: json['userId'] ?? '',
      totalSpent: (json['totalSpent'] ?? 0).toDouble(),
      ordersCount: json['ordersCount'] ?? 0,
      completedOrders: json['completedOrders'] ?? 0,
      cancelledOrders: json['cancelledOrders'] ?? 0,
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      level: UserLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => UserLevel.bronze,
      ),
      monthlySpent: (json['monthlySpent'] ?? 0).toDouble(),
      yearlySpent: (json['yearlySpent'] ?? 0).toDouble(),
      reviewsGiven: json['reviewsGiven'] ?? 0,
      avgRating: (json['avgRating'] ?? 0).toDouble(),
      favoritesCount: json['favoritesCount'] ?? 0,
      couponsUsed: json['couponsUsed'] ?? 0,
      memberSince: json['memberSince'] != null
          ? DateTime.parse(json['memberSince'])
          : DateTime.now(),
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }
}

// إنجازات المستخدم
final List<Map<String, dynamic>> userAchievements = [
  {'id': 'first_purchase', 'title': 'أول عملية شراء', 'icon': Icons.shopping_bag, 'color': 0xFF4CAF50},
  {'id': 'big_spender', 'title': '500K+ إنفاق', 'icon': Icons.payments, 'color': 0xFFF0B90B},
  {'id': 'loyal_customer', 'title': 'عميل مخلص', 'icon': Icons.favorite, 'color': 0xFFE91E63},
  {'id': 'reviewer', 'title': '10+ تقييمات', 'icon': Icons.rate_review, 'color': 0xFF2196F3},
  {'id': 'vip_member', 'title': 'عضو VIP', 'icon': Icons.diamond, 'color': 0xFF9C27B0},
];

// إحصائيات وهمية
final UserStatsModel mockUserStats = UserStatsModel(
  userId: 'user_001',
  totalSpent: 1250000,
  ordersCount: 24,
  completedOrders: 22,
  cancelledOrders: 2,
  loyaltyPoints: 3500,
  level: UserLevel.gold,
  monthlySpent: 180000,
  yearlySpent: 1250000,
  reviewsGiven: 15,
  avgRating: 4.2,
  favoritesCount: 42,
  couponsUsed: 8,
  memberSince: DateTime(2024, 1, 15),
  achievements: ['first_purchase', 'big_spender', 'loyal_customer'],
);
