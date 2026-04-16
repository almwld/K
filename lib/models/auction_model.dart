enum AuctionStatus { pending, active, ended, sold, cancelled }
enum AuctionType { standard, reserve, buyNow }

class AuctionModel {
  final String id;
  final String title;
  final String description;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final List<String> images;
  final String category;
  final double startingPrice;
  final double? reservePrice;
  final double? buyNowPrice;
  final double currentPrice;
  final double minBidIncrement;
  final String currentBidderId;
  final String currentBidderName;
  final int totalBids;
  final DateTime startTime;
  final DateTime endTime;
  final AuctionStatus status;
  final AuctionType type;
  final bool isFeatured;
  final String location;
  final bool canShip;
  final double shippingFee;

  AuctionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.sellerId,
    required this.sellerName,
    required this.sellerAvatar,
    required this.images,
    required this.category,
    required this.startingPrice,
    this.reservePrice,
    this.buyNowPrice,
    required this.currentPrice,
    required this.minBidIncrement,
    this.currentBidderId = '',
    this.currentBidderName = '',
    this.totalBids = 0,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.type,
    this.isFeatured = false,
    required this.location,
    this.canShip = true,
    this.shippingFee = 0,
  });

  String get timeLeft {
    final now = DateTime.now();
    if (now.isAfter(endTime)) return 'انتهى';
    final diff = endTime.difference(now);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return '${diff.inSeconds} ثانية';
  }

  String get nextBidAmount {
    return (currentPrice + minBidIncrement).toStringAsFixed(0);
  }

  bool get isActive => status == AuctionStatus.active && DateTime.now().isBefore(endTime);
  bool get isEnded => status == AuctionStatus.ended || DateTime.now().isAfter(endTime);
  bool get hasReserveMet => reservePrice == null || currentPrice >= reservePrice!;

  factory AuctionModel.fromJson(Map<String, dynamic> json) {
    return AuctionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      sellerId: json['seller_id'] ?? '',
      sellerName: json['seller_name'] ?? '',
      sellerAvatar: json['seller_avatar'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      startingPrice: (json['starting_price'] ?? 0).toDouble(),
      reservePrice: json['reserve_price']?.toDouble(),
      buyNowPrice: json['buy_now_price']?.toDouble(),
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      minBidIncrement: (json['min_bid_increment'] ?? 1).toDouble(),
      currentBidderId: json['current_bidder_id'] ?? '',
      currentBidderName: json['current_bidder_name'] ?? '',
      totalBids: json['total_bids'] ?? 0,
      startTime: DateTime.parse(json['start_time'] ?? DateTime.now().toIso8601String()),
      endTime: DateTime.parse(json['end_time'] ?? DateTime.now().add(const Duration(days: 7)).toIso8601String()),
      status: AuctionStatus.values.firstWhere((e) => e.name == json['status'], orElse: () => AuctionStatus.active),
      type: AuctionType.values.firstWhere((e) => e.name == json['type'], orElse: () => AuctionType.standard),
      isFeatured: json['is_featured'] ?? false,
      location: json['location'] ?? '',
      canShip: json['can_ship'] ?? true,
      shippingFee: (json['shipping_fee'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_avatar': sellerAvatar,
      'images': images,
      'category': category,
      'starting_price': startingPrice,
      'reserve_price': reservePrice,
      'buy_now_price': buyNowPrice,
      'current_price': currentPrice,
      'min_bid_increment': minBidIncrement,
      'current_bidder_id': currentBidderId,
      'current_bidder_name': currentBidderName,
      'total_bids': totalBids,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'status': status.name,
      'type': type.name,
      'is_featured': isFeatured,
      'location': location,
      'can_ship': canShip,
      'shipping_fee': shippingFee,
    };
  }
}

class BidModel {
  final String id;
  final String auctionId;
  final String bidderId;
  final String bidderName;
  final String bidderAvatar;
  final double amount;
  final DateTime timestamp;
  final bool isAutoBid;
  final bool isWinning;

  BidModel({
    required this.id,
    required this.auctionId,
    required this.bidderId,
    required this.bidderName,
    required this.bidderAvatar,
    required this.amount,
    required this.timestamp,
    this.isAutoBid = false,
    this.isWinning = false,
  });

  String get formattedAmount => '${amount.toStringAsFixed(0)} ريال';
  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: json['id'] ?? '',
      auctionId: json['auction_id'] ?? '',
      bidderId: json['bidder_id'] ?? '',
      bidderName: json['bidder_name'] ?? '',
      bidderAvatar: json['bidder_avatar'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      timestamp: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      isAutoBid: json['is_auto_bid'] ?? false,
      isWinning: json['is_winning'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'auction_id': auctionId,
      'bidder_id': bidderId,
      'bidder_name': bidderName,
      'bidder_avatar': bidderAvatar,
      'amount': amount,
      'created_at': timestamp.toIso8601String(),
      'is_auto_bid': isAutoBid,
      'is_winning': isWinning,
    };
  }
}
