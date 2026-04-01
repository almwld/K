import 'package:flutter/material.dart';

class AuctionModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final double startingPrice;
  final double currentPrice;
  final double? minBidIncrement;
  final String sellerId;
  final String sellerName;
  final String? sellerAvatar;
  final DateTime startTime;
  final DateTime endTime;
  final String status; // active, upcoming, ended
  final int bidCount;
  final String? winnerId;
  final double? finalPrice;
  final DateTime createdAt;
  final String category;
  final String? city;

  AuctionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.startingPrice,
    required this.currentPrice,
    this.minBidIncrement,
    required this.sellerId,
    required this.sellerName,
    this.sellerAvatar,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.bidCount,
    this.winnerId,
    this.finalPrice,
    required this.createdAt,
    required this.category,
    this.city,
  });

  bool get isActive => status == 'active' && endTime.isAfter(DateTime.now());
  bool get isUpcoming => status == 'upcoming' && startTime.isAfter(DateTime.now());
  bool get isEnded => status == 'ended' || endTime.isBefore(DateTime.now());

  String get timeLeft {
    if (isEnded) return 'انتهى';
    final diff = endTime.difference(DateTime.now());
    if (diff.inDays > 0) return '${diff.inDays} أيام';
    if (diff.inHours > 0) return '${diff.inHours} ساعات';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقائق';
    return '${diff.inSeconds} ثواني';
  }

  double get nextBidAmount => currentPrice + (minBidIncrement ?? (currentPrice * 0.05));
}
