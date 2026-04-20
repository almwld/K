import 'package:flutter/material.dart';
import '../models/subscription_model.dart';

class SubscriptionProvider extends ChangeNotifier {
  UserSubscription _currentSubscription = UserSubscription(userId: '');
  List<SubscriptionPlan> _plans = [];
  bool _isLoading = false;

  UserSubscription get currentSubscription => _currentSubscription;
  List<SubscriptionPlan> get plans => _plans;
  bool get isLoading => _isLoading;
  bool get isPro => _currentSubscription.isPro;
  bool get isVip => _currentSubscription.isVip;

  SubscriptionProvider() {
    _plans = subscriptionPlans;
    _loadSubscription();
  }

  void _loadSubscription() {
    // محاكاة تحميل الاشتراك
    _currentSubscription = UserSubscription(
      userId: 'user_001',
      tier: SubscriptionTier.none,
      isActive: false,
    );
    notifyListeners();
  }

  Future<void> subscribe(String planId) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    final tier = planId == 'vip' ? SubscriptionTier.vip : SubscriptionTier.pro;
    _currentSubscription = UserSubscription(
      userId: 'user_001',
      tier: tier,
      startedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
      isActive: true,
      autoRenew: true,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> cancelSubscription() async {
    _currentSubscription = UserSubscription(
      userId: _currentSubscription.userId,
      tier: SubscriptionTier.none,
      isActive: false,
    );
    notifyListeners();
  }

  SubscriptionPlan? getPlanById(String id) {
    try {
      return _plans.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
