import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/referral_model.dart';

class ReferralService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;
  ReferralProgramConfig _config = ReferralProgramConfig.getDefault();

  ReferralService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // الحصول على كود الإحالة الخاص بالمستخدم
  Future<ReferralCodeModel?> getUserReferralCode() async {
    if (_currentUserId == null) return null;

    try {
      final response = await _client
          .from('referral_codes')
          .select()
          .eq('user_id', _currentUserId)
          .single();

      return ReferralCodeModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return await _createReferralCode();
    }
  }

  // إنشاء كود إحالة جديد
  Future<ReferralCodeModel> _createReferralCode() async {
    final code = _generateReferralCode();
    final newCode = ReferralCodeModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUserId!,
      code: code,
      createdAt: DateTime.now(),
      maxUses: _config.maxInvitesPerUser,
    );

    try {
      await _client.from('referral_codes').insert(newCode.toJson());
      return newCode;
    } catch (e) {
      return newCode;
    }
  }

  // توليد كود إحالة فريد
  String _generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final userPart = _currentUserId!.substring(0, 4).toUpperCase();
    final randomPart = List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();
    return '$userPart$randomPart';
  }

  // الحصول على سجل الدعوات
  Future<List<ReferralInviteModel>> getInviteHistory() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('referral_invites')
          .select()
          .eq('referrer_id', _currentUserId)
          .order('invited_at', ascending: false);

      return (response as List).map<ReferralInviteModel>((json) => 
        ReferralInviteModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockInvites();
    }
  }

  // الحصول على المكافآت المستحقة
  Future<List<ReferralRewardModel>> getEarnedRewards() async {
    if (_currentUserId == null) return [];

    try {
      final response = await _client
          .from('referral_rewards')
          .select()
          .eq('user_id', _currentUserId)
          .order('earned_at', ascending: false);

      return (response as List).map<ReferralRewardModel>((json) => 
        ReferralRewardModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockRewards();
    }
  }

  // إرسال دعوة
  Future<bool> sendInvite(String phoneNumber) async {
    if (_currentUserId == null) return false;

    final code = await getUserReferralCode();
    if (code == null || !code.canBeUsed) return false;

    try {
      // التحقق من عدم وجود دعوة سابقة لنفس الرقم
      final existing = await _client
          .from('referral_invites')
          .select()
          .eq('referrer_id', _currentUserId)
          .eq('invited_phone', phoneNumber);

      if ((existing as List).isNotEmpty) return false;

      final invite = ReferralInviteModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        referrerId: _currentUserId!,
        referrerCode: code.code,
        invitedPhone: phoneNumber,
        status: ReferralStatus.pending,
        invitedAt: DateTime.now(),
      );

      await _client.from('referral_invites').insert(invite.toJson());

      // تحديث عدد الدعوات
      await _client
          .from('referral_codes')
          .update({'total_invites': code.totalInvites + 1, 'used_count': code.usedCount + 1})
          .eq('id', code.id);

      // إرسال رسالة دعوة (محاكاة)
      await _sendInviteSMS(phoneNumber, code.code);

      return true;
    } catch (e) {
      return false;
    }
  }

  // محاكاة إرسال SMS
  Future<void> _sendInviteSMS(String phone, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    print('تم إرسال دعوة إلى $phone مع الكود $code');
  }

  // تطبيق كود إحالة (للمستخدم الجديد)
  Future<bool> applyReferralCode(String code) async {
    if (_currentUserId == null) return false;

    try {
      // التحقق من صحة الكود
      final codeResponse = await _client
          .from('referral_codes')
          .select()
          .eq('code', code.toUpperCase())
          .eq('is_active', true)
          .single();

      final referrerCode = ReferralCodeModel.fromJson(codeResponse as Map<String, dynamic>);
      
      if (!referrerCode.canBeUsed) return false;
      if (referrerCode.userId == _currentUserId) return false;

      // البحث عن الدعوة
      final inviteResponse = await _client
          .from('referral_invites')
          .select()
          .eq('referrer_code', code)
          .eq('status', 'pending')
          .maybeSingle();

      // تحديث حالة الدعوة إذا وجدت
      if (inviteResponse != null) {
        await _client
            .from('referral_invites')
            .update({
              'invited_user_id': _currentUserId,
              'status': 'completed',
              'joined_at': DateTime.now().toIso8601String(),
              'reward_amount': _config.referrerReward,
            })
            .eq('id', inviteResponse['id']);
      }

      // إضافة مكافأة للداعي
      await _client.from('referral_rewards').insert({
        'user_id': referrerCode.userId,
        'invite_id': inviteResponse?['id'] ?? '',
        'amount': _config.referrerReward,
        'type': _config.rewardType,
        'earned_at': DateTime.now().toIso8601String(),
      });

      // تحديث أرباح الداعي
      await _client
          .from('referral_codes')
          .update({
            'successful_invites': referrerCode.successfulInvites + 1,
            'total_earnings': referrerCode.totalEarnings + _config.referrerReward,
          })
          .eq('id', referrerCode.id);

      // إضافة مكافأة للمستخدم الجديد
      await _client.from('referral_rewards').insert({
        'user_id': _currentUserId,
        'amount': _config.invitedReward,
        'type': _config.rewardType,
        'earned_at': DateTime.now().toIso8601String(),
        'is_claimed': true,
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  // المطالبة بالمكافأة
  Future<bool> claimReward(String rewardId) async {
    try {
      await _client
          .from('referral_rewards')
          .update({'is_claimed': true, 'claimed_at': DateTime.now().toIso8601String()})
          .eq('id', rewardId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // الحصول على رابط الإحالة
  String getReferralLink(String code) {
    return 'https://flexyemen.com/ref/$code';
  }

  // بيانات وهمية
  List<ReferralInviteModel> _getMockInvites() {
    return [
      ReferralInviteModel(id: '1', referrerId: _currentUserId!, referrerCode: 'USER123', invitedUserId: 'user2', invitedPhone: '777123456', status: ReferralStatus.completed, invitedAt: DateTime.now().subtract(const Duration(days: 5)), joinedAt: DateTime.now().subtract(const Duration(days: 4)), rewardAmount: 50),
      ReferralInviteModel(id: '2', referrerId: _currentUserId!, referrerCode: 'USER123', invitedUserId: 'user3', invitedPhone: '777234567', status: ReferralStatus.completed, invitedAt: DateTime.now().subtract(const Duration(days: 3)), joinedAt: DateTime.now().subtract(const Duration(days: 2)), rewardAmount: 50),
      ReferralInviteModel(id: '3', referrerId: _currentUserId!, referrerCode: 'USER123', invitedPhone: '777345678', status: ReferralStatus.pending, invitedAt: DateTime.now().subtract(const Duration(days: 1))),
      ReferralInviteModel(id: '4', referrerId: _currentUserId!, referrerCode: 'USER123', invitedPhone: '777456789', status: ReferralStatus.pending, invitedAt: DateTime.now().subtract(const Duration(hours: 12))),
      ReferralInviteModel(id: '5', referrerId: _currentUserId!, referrerCode: 'USER123', invitedPhone: '777567890', status: ReferralStatus.expired, invitedAt: DateTime.now().subtract(const Duration(days: 35))),
    ];
  }

  List<ReferralRewardModel> _getMockRewards() {
    return [
      ReferralRewardModel(id: '1', userId: _currentUserId!, inviteId: '1', amount: 50, type: 'cash', earnedAt: DateTime.now().subtract(const Duration(days: 4)), isClaimed: true, claimedAt: DateTime.now().subtract(const Duration(days: 3))),
      ReferralRewardModel(id: '2', userId: _currentUserId!, inviteId: '2', amount: 50, type: 'cash', earnedAt: DateTime.now().subtract(const Duration(days: 2)), isClaimed: false),
    ];
  }
}

