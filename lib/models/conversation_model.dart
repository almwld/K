class ConversationModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatar;
  final bool isOnline;

  ConversationModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.avatar = '👤',
    this.isOnline = false,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['last_message'] ?? '',
      time: json['time'] ?? '',
      unreadCount: json['unread_count'] ?? 0,
      avatar: json['avatar'] ?? '👤',
      isOnline: json['is_online'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_message': lastMessage,
      'time': time,
      'unread_count': unreadCount,
      'avatar': avatar,
      'is_online': isOnline,
    };
  }
}
