class ChatMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final String message;
  final String type; // text, image, product
  final String? mediaUrl;
  final bool isRead;
  final bool isDelivered;
  final DateTime createdAt;
  final String? reaction;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    required this.message,
    this.type = 'text',
    this.mediaUrl,
    this.isRead = false,
    this.isDelivered = false,
    required this.createdAt,
    this.reaction,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      senderName: json['sender_name'] ?? '',
      senderAvatar: json['sender_avatar'],
      message: json['message'],
      type: json['type'] ?? 'text',
      mediaUrl: json['media_url'],
      isRead: json['is_read'] ?? false,
      isDelivered: json['is_delivered'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      reaction: json['reaction'],
    );
  }

  bool get isMine => senderId == currentUserId;
  static String currentUserId = '';
}
