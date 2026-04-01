class ChatModel {
  final String id;
  final String user1Id;
  final String user2Id;
  final String user1Name;
  final String user2Name;
  final String? user1Avatar;
  final String? user2Avatar;
  final String productId;
  final String? productTitle;
  final String? productImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isActive;

  ChatModel({
    required this.id,
    required this.user1Id,
    required this.user2Id,
    required this.user1Name,
    required this.user2Name,
    this.user1Avatar,
    this.user2Avatar,
    required this.productId,
    this.productTitle,
    this.productImage,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isActive = true,
  });

  String getOtherUserId(String currentUserId) {
    return currentUserId == user1Id ? user2Id : user1Id;
  }

  String getOtherUserName(String currentUserId) {
    return currentUserId == user1Id ? user2Name : user1Name;
  }

  String? getOtherUserAvatar(String currentUserId) {
    return currentUserId == user1Id ? user2Avatar : user1Avatar;
  }
}

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String message;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isRead;
  final String? replyToId;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.message,
    this.imageUrl,
    required this.createdAt,
    this.isRead = false,
    this.replyToId,
  });

  bool get isFromMe => false; // سيتم تعيينه في الواجهة

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      chatId: json['chat_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      message: json['message'] ?? '',
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['is_read'] ?? false,
      replyToId: json['reply_to_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'message': message,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'is_read': isRead,
      'reply_to_id': replyToId,
    };
  }
}
