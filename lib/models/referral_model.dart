enum ReferralStatus { pending, completed, expired, cancelled }

class ReferralCodeModel {
  final String id;
  final String userId;
  final String code;
  final int totalInvites;
  final int successfulInvites;
  final double totalEarnings;
  final DateTime createdAt;
  final bool isActive;
  final int maxUses;
  final int usedCount;

  ReferralCodeModel({
    required this.id,
    required this.userId,
    required this.code,
    this.totalInvites = 0,
    this.successfulInvites = 0,
    this.totalEarnings = 0,
    required this.createdAt,
    this.isActive = true,
    this.maxUses = 100,
    this.usedCount = 0,
  });

  bool get canBeUsed => isActive && usedCount < maxUses;
  int get remainingUses => maxUses - usedCount;

  factory ReferralCodeModel.fromJson(Map<String, dynamic> json) {
    return ReferralCodeModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      code: json['code'] ?? '',
      totalInvites: json['total_invites'] ?? 0,
      successfulInvites: json['successful_invites'] ?? 0,
      totalEarnings: (json['total_earnings'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isActive: json['is_active'] ?? true,
      maxUses: json['max_uses'] ?? 100,
      usedCount: json['used_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'code': code,
      'total_invites': totalInvites,
      'successful_invites': successfulInvites,
      'total_earnings': totalEarnings,
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive,
      'max_uses': maxUses,
      'used_count': usedCount,
    };
  }
}

class ReferralInviteModel {
  final String id;
  final String referrerId;
  final String referrerCode;
  final String? invitedUserId;
  final String invitedPhone;
  final ReferralStatus status;
  final DateTime invitedAt;
  final DateTime? joinedAt;
  final double rewardAmount;
  final String? rewardType;

  ReferralInviteModel({
    required this.id,
    required this.referrerId,
    required this.referrerCode,
    this.invitedUserId,
    required this.invitedPhone,
    required this.status,
    required this.invitedAt,
    this.joinedAt,
    this.rewardAmount = 0,
    this.rewardType,
  });

  String get statusText {
    switch (status) {
      case ReferralStatus.pending: return 'في الانتظار';
      case ReferralStatus.completed: return 'مكتمل';
      case ReferralStatus.expired: return 'منتهي';
      case ReferralStatus.cancelled: return 'ملغي';
    }
  }

  Color get statusColor {
    switch (status) {
      case ReferralStatus.pending: return Colors.orange;
      case ReferralStatus.completed: return Colors.green;
      case ReferralStatus.expired: return Colors.grey;
      case ReferralStatus.cancelled: return Colors.red;
    }
  }

  factory ReferralInviteModel.fromJson(Map<String, dynamic> json) {
    return ReferralInviteModel(
      id: json['id'] ?? '',
      referrerId: json['referrer_id'] ?? '',
      referrerCode: json['referrer_code'] ?? '',
      invitedUserId: json['invited_user_id'],
      invitedPhone: json['invited_phone'] ?? '',
      status: ReferralStatus.values.firstWhere((e) => e.name == json['status'], orElse: () => ReferralStatus.pending),
      invitedAt: DateTime.parse(json['invited_at'] ?? DateTime.now().toIso8601String()),
      joinedAt: json['joined_at'] != null ? DateTime.parse(json['joined_at']) : null,
      rewardAmount: (json['reward_amount'] ?? 0).toDouble(),
      rewardType: json['reward_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referrer_id': referrerId,
      'referrer_code': referrerCode,
      'invited_user_id': invitedUserId,
      'invited_phone': invitedPhone,
      'status': status.name,
      'invited_at': invitedAt.toIso8601String(),
      'joined_at': joinedAt?.toIso8601String(),
      'reward_amount': rewardAmount,
      'reward_type': rewardType,
    };
  }
}

class ReferralRewardModel {
  final String id;
  final String userId;
  final String inviteId;
  final double amount;
  final String type;
  final DateTime earnedAt;
  final bool isClaimed;
  final DateTime? claimedAt;

  ReferralRewardModel({
    required this.id,
    required this.userId,
    required this.inviteId,
    required this.amount,
    required this.type,
    required this.earnedAt,
    this.isClaimed = false,
    this.claimedAt,
  });

  factory ReferralRewardModel.fromJson(Map<String, dynamic> json) {
    return ReferralRewardModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      inviteId: json['invite_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      type: json['type'] ?? 'cash',
      earnedAt: DateTime.parse(json['earned_at'] ?? DateTime.now().toIso8601String()),
      isClaimed: json['is_claimed'] ?? false,
      claimedAt: json['claimed_at'] != null ? DateTime.parse(json['claimed_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'invite_id': inviteId,
      'amount': amount,
      'type': type,
      'earned_at': earnedAt.toIso8601String(),
      'is_claimed': isClaimed,
      'claimed_at': claimedAt?.toIso8601String(),
    };
  }
}

class ReferralProgramConfig {
  final double referrerReward;
  final double invitedReward;
  final String rewardType;
  final int codeExpiryDays;
  final int maxInvitesPerUser;
  final double minPurchaseForReward;
  final List<Map<String, dynamic>> milestones;

  ReferralProgramConfig({
    this.referrerReward = 50,
    this.invitedReward = 25,
    this.rewardType = 'cash',
    this.codeExpiryDays = 30,
    this.maxInvitesPerUser = 100,
    this.minPurchaseForReward = 100,
    this.milestones = const [
      {'count': 5, 'reward': 100, 'type': 'bonus'},
      {'count': 10, 'reward': 250, 'type': 'bonus'},
      {'count': 25, 'reward': 500, 'type': 'bonus'},
      {'count': 50, 'reward': 1000, 'type': 'bonus'},
      {'count': 100, 'reward': 2500, 'type': 'bonus'},
    ],
  });

  static ReferralProgramConfig getDefault() {
    return ReferralProgramConfig();
  }
}
