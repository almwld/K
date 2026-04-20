import 'package:flutter/material.dart';
import '../models/user_stats_model.dart';

class UserStatsProvider extends ChangeNotifier {
  UserStatsModel? _stats;
  bool _isLoading = false;

  UserStatsModel? get stats => _stats;
  bool get isLoading => _isLoading;
  bool get hasStats => _stats != null;

  UserStatsProvider() {
    loadStats();
  }

  void loadStats() {
    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      _stats = mockUserStats;
      _isLoading = false;
      notifyListeners();
    });
  }

  void addLoyaltyPoints(int points) {
    if (_stats == null) return;
    _stats = UserStatsModel(
      userId: _stats!.userId,
      totalSpent: _stats!.totalSpent,
      ordersCount: _stats!.ordersCount,
      completedOrders: _stats!.completedOrders,
      cancelledOrders: _stats!.cancelledOrders,
      loyaltyPoints: _stats!.loyaltyPoints + points,
      level: _stats!.level,
      monthlySpent: _stats!.monthlySpent,
      yearlySpent: _stats!.yearlySpent,
      reviewsGiven: _stats!.reviewsGiven,
      avgRating: _stats!.avgRating,
      favoritesCount: _stats!.favoritesCount,
      couponsUsed: _stats!.couponsUsed,
      memberSince: _stats!.memberSince,
      achievements: _stats!.achievements,
    );
    notifyListeners();
  }

  void addAchievement(String achievementId) {
    if (_stats == null || _stats!.achievements.contains(achievementId)) return;
    final newAchievements = [..._stats!.achievements, achievementId];
    _stats = UserStatsModel(
      userId: _stats!.userId,
      totalSpent: _stats!.totalSpent,
      ordersCount: _stats!.ordersCount,
      completedOrders: _stats!.completedOrders,
      cancelledOrders: _stats!.cancelledOrders,
      loyaltyPoints: _stats!.loyaltyPoints,
      level: _stats!.level,
      monthlySpent: _stats!.monthlySpent,
      yearlySpent: _stats!.yearlySpent,
      reviewsGiven: _stats!.reviewsGiven,
      avgRating: _stats!.avgRating,
      favoritesCount: _stats!.favoritesCount,
      couponsUsed: _stats!.couponsUsed,
      memberSince: _stats!.memberSince,
      achievements: newAchievements,
    );
    notifyListeners();
  }

  void refreshStats() {
    loadStats();
  }
}
