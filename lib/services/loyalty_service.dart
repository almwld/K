import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/loyalty_model.dart';

class LoyaltyService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;

  LoyaltyService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // الحصول على بيانات ولاء المستخدم
  Future<UserLoyaltyModel?> getUserLoyalty() async {
    if (_currentUserId == null) return null;

    try {
      final response = await _client
          .from('user_loyalty')
          .select()
          .eq('user_id', _currentUserId)
          .single();

      return UserLoyaltyModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return _getMockUserLoyalty();
    }
  }

  // الحصول على سجل النقاط
  Future<List<PointTransactionModel>> getPointHistory() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('point_transactions')
          .select()
          .eq('user_id', _currentUserId)
          .order('created_at', ascending: false)
          .limit(50);

      return (response as List).map<PointTransactionModel>((json) => 
        PointTransactionModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockTransactions();
    }
  }

  // الحصول على المكافآت المتاحة
  Future<List<RewardModel>> getAvailableRewards() async {
    try {
      final response = await _client
          .from('rewards')
          .select()
          .eq('is_active', true)
          .lte('valid_from', DateTime.now().toIso8601String())
          .gte('valid_until', DateTime.now().toIso8601String())
          .order('points_cost', ascending: true);

      return (response as List).map<RewardModel>((json) => 
        RewardModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockRewards();
    }
  }

  // استبدال النقاط بمكافأة
  Future<bool> redeemReward(String rewardId) async {
    if (_currentUserId == null) return false;

    try {
      // التحقق من توفر المكافأة
      final rewardResponse = await _client
          .from('rewards')
          .select()
          .eq('id', rewardId)
          .single();

      final reward = RewardModel.fromJson(rewardResponse as Map<String, dynamic>);
      
      if (!reward.isAvailable) return false;

      // التحقق من نقاط المستخدم
      final userResponse = await _client
          .from('user_loyalty')
          .select()
          .eq('user_id', _currentUserId)
          .single();

      final user = UserLoyaltyModel.fromJson(userResponse as Map<String, dynamic>);
      
      if (user.totalPoints < reward.pointsCost) return false;
      if (reward.minTier != null && user.currentTier.index < reward.minTier!) return false;

      // خصم النقاط
      await _client
          .from('user_loyalty')
          .update({'total_points': user.totalPoints - reward.pointsCost})
          .eq('user_id', _currentUserId);

      // تسجيل المعاملة
      await _client.from('point_transactions').insert({
        'user_id': _currentUserId,
        'points': -reward.pointsCost,
        'source': 'redemption',
        'description': 'استبدال: ${reward.title}',
        'created_at': DateTime.now().toIso8601String(),
      });

      // تحديث عدد الاستبدالات
      await _client
          .from('rewards')
          .update({'redeemed_count': reward.redeemedCount + 1})
          .eq('id', rewardId);

      // تسجيل استبدال المستخدم
      await _client.from('user_rewards').insert({
        'user_id': _currentUserId,
        'reward_id': rewardId,
        'redeemed_at': DateTime.now().toIso8601String(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // تسجيل الدخول اليومي
  Future<int> dailyLogin() async {
    if (_currentUserId == null) return 0;

    try {
      final user = await getUserLoyalty();
      if (user == null) return 0;

      final now = DateTime.now();
      final lastLogin = user.lastLogin;
      
      // التحقق من مرور 24 ساعة
      if (now.difference(lastLogin).inHours < 20) return 0;

      // حساب نقاط التسجيل اليومي
      int points = 10;
      int newStreak = user.streak + 1;
      
      // مكافأة الاستمرارية
      if (newStreak == 7) points = 100;
      if (newStreak == 30) points = 500;
      
      // إذا انقطع الاستمرار
      if (now.difference(lastLogin).inHours > 48) {
        newStreak = 1;
      }

      // تحديث بيانات المستخدم
      await _client
          .from('user_loyalty')
          .update({
            'total_points': user.totalPoints + points,
            'lifetime_points': user.lifetimePoints + points,
            'streak': newStreak,
            'last_login': now.toIso8601String(),
          })
          .eq('user_id', _currentUserId);

      // تسجيل المعاملة
      await _client.from('point_transactions').insert({
        'user_id': _currentUserId,
        'points': points,
        'source': 'daily_login',
        'description': 'تسجيل دخول يومي (استمرار $newStreak يوم)',
        'created_at': now.toIso8601String(),
      });

      return points;
    } catch (e) {
      return 0;
    }
  }

  // إضافة نقاط من عملية شراء
  Future<int> addPurchasePoints(String orderId, double amount) async {
    if (_currentUserId == null) return 0;

    try {
      final user = await getUserLoyalty();
      if (user == null) return 0;

      final tierInfo = user.tierInfo;
      final points = (amount * tierInfo.pointsMultiplier).round();

      await _client
          .from('user_loyalty')
          .update({
            'total_points': user.totalPoints + points,
            'lifetime_points': user.lifetimePoints + points,
          })
          .eq('user_id', _currentUserId);

      await _client.from('point_transactions').insert({
        'user_id': _currentUserId,
        'points': points,
        'source': 'purchase',
        'description': 'نقاط من عملية شراء',
        'order_id': orderId,
        'created_at': DateTime.now().toIso8601String(),
      });

      // التحقق من ترقية المستوى
      final newTier = LoyaltyTierInfo.getTierByPoints(user.totalPoints + points);
      if (newTier.tier != user.currentTier) {
        await _client
            .from('user_loyalty')
            .update({'current_tier': newTier.tier.name})
            .eq('user_id', _currentUserId);
      }

      return points;
    } catch (e) {
      return 0;
    }
  }

  // بيانات وهمية
  UserLoyaltyModel _getMockUserLoyalty() {
    return UserLoyaltyModel(
      userId: _currentUserId ?? 'user1',
      totalPoints: 2750,
      lifetimePoints: 5200,
      currentTier: LoyaltyTier.silver,
      memberSince: DateTime.now().subtract(const Duration(days: 120)),
      streak: 5,
      lastLogin: DateTime.now().subtract(const Duration(hours: 20)),
    );
  }

  List<PointTransactionModel> _getMockTransactions() {
    return [
      PointTransactionModel(id: '1', userId: _currentUserId ?? 'user1', points: 500, source: PointSource.purchase, description: 'شراء آيفون 15', createdAt: DateTime.now().subtract(const Duration(days: 10)), orderId: 'ORD001'),
      PointTransactionModel(id: '2', userId: _currentUserId ?? 'user1', points: 50, source: PointSource.dailyLogin, description: 'تسجيل دخول يومي', createdAt: DateTime.now().subtract(const Duration(days: 5))),
      PointTransactionModel(id: '3', userId: _currentUserId ?? 'user1', points: 100, source: PointSource.review, description: 'تقييم منتج', createdAt: DateTime.now().subtract(const Duration(days: 3))),
      PointTransactionModel(id: '4', userId: _currentUserId ?? 'user1', points: 200, source: PointSource.referral, description: 'دعوة صديق', createdAt: DateTime.now().subtract(const Duration(days: 1))),
    ];
  }

  List<RewardModel> _getMockRewards() {
    return [
      RewardModel(
        id: '1', title: 'كوبون خصم 50 ريال', description: 'خصم 50 ريال على أي طلب', pointsCost: 500,
        type: RewardType.coupon, value: {'type': 'fixed', 'value': 50},
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331970.png',
        stock: 100, redeemedCount: 35, validFrom: DateTime.now().subtract(const Duration(days: 10)), validUntil: DateTime.now().add(const Duration(days: 20)),
      ),
      RewardModel(
        id: '2', title: 'شحن مجاني', description: 'توصيل مجاني على أي طلب', pointsCost: 300,
        type: RewardType.freeShipping, value: null,
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3082/3082029.png',
        stock: -1, redeemedCount: 120, validFrom: DateTime.now().subtract(const Duration(days: 30)), validUntil: DateTime.now().add(const Duration(days: 60)),
      ),
      RewardModel(
        id: '3', title: 'كوبون خصم 10%', description: 'خصم 10% حتى 100 ريال', pointsCost: 800,
        type: RewardType.coupon, value: {'type': 'percentage', 'value': 10, 'max': 100},
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2331/2331970.png',
        stock: 50, redeemedCount: 20, validFrom: DateTime.now().subtract(const Duration(days: 5)), validUntil: DateTime.now().add(const Duration(days: 25)),
        minTier: 1,
      ),
      RewardModel(
        id: '4', title: 'سماعات بلوتوث', description: 'سماعات بلوتوث لاسلكية', pointsCost: 2000,
        type: RewardType.gift, value: {'name': 'سماعات بلوتوث', 'price': 150},
        imageUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=200',
        stock: 10, redeemedCount: 3, validFrom: DateTime.now().subtract(const Duration(days: 15)), validUntil: DateTime.now().add(const Duration(days: 15)),
        minTier: 2,
      ),
      RewardModel(
        id: '5', title: 'كاش باك 5%', description: 'استرداد 5% من قيمة الطلب', pointsCost: 1500,
        type: RewardType.cashback, value: 5,
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2481/2481123.png',
        stock: -1, redeemedCount: 45, validFrom: DateTime.now().subtract(const Duration(days: 20)), validUntil: DateTime.now().add(const Duration(days: 10)),
      ),
    ];
  }
}

