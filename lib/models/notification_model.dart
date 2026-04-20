import 'package:flutter/material.dart';

enum NotificationType {
  transaction,
  promo,
  system,
  update,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final NotificationType type;
  bool isRead;
  final IconData icon;
  final int color;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    required this.isRead,
    required this.icon,
    required this.color,
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'الآن';
        }
        return 'منذ ${difference.inMinutes} دقيقة';
      }
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

