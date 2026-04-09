class ConversationModel {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  ConversationModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    this.isOnline = false,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    final otherUserId = json['user1_id'] == currentUserId ? json['user2_id'] : json['user1_id'];
    return ConversationModel(
      id: json['id'],
      userId: otherUserId,
      userName: json['other_user_name'] ?? 'مستخدم',
      userAvatar: json['other_user_avatar'],
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: DateTime.parse(json['last_message_time'] ?? json['created_at']),
      unreadCount: json['${currentUserId == json['user1_id'] ? 'user1_unread_count' : 'user2_unread_count'}'] ?? 0,
    );
  }
}
