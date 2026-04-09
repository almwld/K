class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String message;
  final bool isRead;
  final String type;
  final DateTime createdAt;
  bool isSending;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.message,
    this.isRead = false,
    this.type = 'text',
    required this.createdAt,
    this.isSending = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      senderId: json['sender_id'],
      message: json['message'],
      isRead: json['is_read'] ?? false,
      type: json['type'] ?? 'text',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'message': message,
      'is_read': isRead,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isMine => senderId == currentUserId;
  static String currentUserId = '';
}
