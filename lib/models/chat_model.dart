class ConversationModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerAvatar;
  final String merchantId;
  final String merchantName;
  final String merchantAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final String? productId;
  final String? productName;
  final String? productImage;

  ConversationModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerAvatar,
    required this.merchantId,
    required this.merchantName,
    required this.merchantAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.productId,
    this.productName,
    this.productImage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      customerId: json['customer_id'] ?? '',
      customerName: json['customer_name'] ?? 'عميل',
      customerAvatar: json['customer_avatar'] ?? 'https://ui-avatars.com/api/?name=Customer&background=D4AF37&color=fff',
      merchantId: json['merchant_id'] ?? '',
      merchantName: json['merchant_name'] ?? 'تاجر',
      merchantAvatar: json['merchant_avatar'] ?? 'https://ui-avatars.com/api/?name=Merchant&background=2196F3&color=fff',
      lastMessage: json['last_message'] ?? '',
      lastMessageTime: json['last_message_time'] != null 
          ? DateTime.parse(json['last_message_time']) 
          : DateTime.now(),
      unreadCount: json['unread_count'] ?? 0,
      productId: json['product_id'],
      productName: json['product_name'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_avatar': customerAvatar,
      'merchant_id': merchantId,
      'merchant_name': merchantName,
      'merchant_avatar': merchantAvatar,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime.toIso8601String(),
      'unread_count': unreadCount,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
    };
  }
}

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String senderAvatar;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final MessageType type;
  final String? imageUrl;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.senderAvatar,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.type = MessageType.text,
    this.imageUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      senderName: json['sender_name'] ?? '',
      senderAvatar: json['sender_avatar'] ?? '',
      content: json['content'] ?? '',
      timestamp: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      isRead: json['is_read'] ?? false,
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_avatar': senderAvatar,
      'content': content,
      'created_at': timestamp.toIso8601String(),
      'is_read': isRead,
      'type': type.name,
      'image_url': imageUrl,
    };
  }
}

enum MessageType { text, image, product, order }
