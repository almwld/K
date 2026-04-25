import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum ChatType { store, user, group, broadcast, ai }

class ChatModel {
  final String id;
  final String name;
  final ChatType type;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isPinned;
  final bool isOnline;
  final IconData avatar;
  final Color avatarColor;
  final bool lastMessageIsMine;

  ChatModel({
    required this.id,
    required this.name,
    required this.type,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isPinned,
    required this.isOnline,
    required this.avatar,
    required this.avatarColor,
    required this.lastMessageIsMine,
  });

  String get formattedTime {
    final now = DateTime.now();
    final diff = now.difference(lastMessageTime);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inHours < 1) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inDays < 1) return 'منذ ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'منذ ${diff.inDays} يوم';
    return '${lastMessageTime.day}/${lastMessageTime.month}';
  }

  String get statusText {
    if (isOnline && type != ChatType.ai) return 'متصل الآن';
    if (type == ChatType.ai) return 'مساعد ذكي';
    if (type == ChatType.broadcast) return 'قناة إعلانية';
    return '';
  }

  Color get statusColor {
    if (isOnline && type != ChatType.ai) return const Color(0xFF0ECB81);
    if (type == ChatType.ai) return const Color(0xFFF0B90B);
    if (type == ChatType.broadcast) return const Color(0xFFFF9800);
    return const Color(0xFF5E6673);
  }
}

enum MessageStatus { sent, delivered, read }

class MessageModel {
  final String id;
  final String text;
  final bool isMine;
  final DateTime time;
  final MessageStatus status;

  MessageModel({required this.id, required this.text, required this.isMine, required this.time, required this.status});
}
