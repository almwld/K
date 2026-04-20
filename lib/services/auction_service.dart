import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/auction_model.dart';

class AuctionService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;
  
  StreamSubscription? _auctionSubscription;
  final _auctionsController = StreamController<List<AuctionModel>>.broadcast();
  final _bidsController = StreamController<List<BidModel>>.broadcast();

  Stream<List<AuctionModel>> get auctionsStream => _auctionsController.stream;
  Stream<List<BidModel>> get bidsStream => _bidsController.stream;

  AuctionService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // الحصول على المزادات النشطة
  Future<List<AuctionModel>> getActiveAuctions({String? category, bool featuredOnly = false}) async {
    try {
      var query = _client
          .from('auctions')
          .select()
          .eq('status', 'active')
          .gte('end_time', DateTime.now().toIso8601String())
          .order('end_time', ascending: true);

      if (category != null && category != 'الكل') {
        query = query.eq('category', category);
      }
      if (featuredOnly) {
        query = query.eq('is_featured', true);
      }

      final response = await query;
      return (response as List).map<AuctionModel>((json) => 
        AuctionModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockAuctions();
    }
  }

  // الحصول على مزاداتي (كمشتري)
  Future<List<AuctionModel>> getMyBids() async {
    if (_currentUserId == null) return [];
    
    try {
      final response = await _client
          .from('auctions')
          .select()
          .eq('current_bidder_id', _currentUserId)
          .order('end_time', ascending: true);

      return (response as List).map<AuctionModel>((json) => 
        AuctionModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // الحصول على مزاداتي (كبائع)
  Future<List<AuctionModel>> getMyAuctions() async {
    if (_currentUserId == null) return [];
    
    try {
      final response = await _client
          .from('auctions')
          .select()
          .eq('seller_id', _currentUserId)
          .order('created_at', ascending: false);

      return (response as List).map<AuctionModel>((json) => 
        AuctionModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return [];
    }
  }

  // الحصول على تفاصيل مزاد
  Future<AuctionModel?> getAuction(String auctionId) async {
    try {
      final response = await _client
          .from('auctions')
          .select()
          .eq('id', auctionId)
          .single();

      return AuctionModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return _getMockAuctionById(auctionId);
    }
  }

  // الحصول على المزايدات لمزاد معين
  Future<List<BidModel>> getBids(String auctionId) async {
    try {
      final response = await _client
          .from('bids')
          .select()
          .eq('auction_id', auctionId)
          .order('amount', ascending: false)
          .order('created_at', ascending: false);

      return (response as List).map<BidModel>((json) => 
        BidModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockBids(auctionId);
    }
  }

  // تقديم مزايدة
  Future<BidResult> placeBid({
    required String auctionId,
    required double amount,
    bool isAutoBid = false,
  }) async {
    if (_currentUserId == null) {
      return BidResult(success: false, message: 'يجب تسجيل الدخول أولاً');
    }

    try {
      // الحصول على المزاد
      final auction = await getAuction(auctionId);
      if (auction == null) {
        return BidResult(success: false, message: 'المزاد غير موجود');
      }

      // التحقق من صلاحية المزاد
      if (!auction.isActive) {
        return BidResult(success: false, message: 'المزاد غير نشط أو انتهى');
      }

      // التحقق من الحد الأدنى للمزايدة
      if (amount < auction.currentPrice + auction.minBidIncrement) {
        return BidResult(
          success: false,
          message: 'الحد الأدنى للمزايدة ${auction.nextBidAmount} ريال',
        );
      }

      // التحقق من أن المستخدم ليس البائع
      if (auction.sellerId == _currentUserId) {
        return BidResult(success: false, message: 'لا يمكنك المزايدة على منتجك');
      }

      // إضافة المزايدة
      final bid = BidModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        auctionId: auctionId,
        bidderId: _currentUserId!,
        bidderName: 'مستخدم فلكس يمن',
        bidderAvatar: 'https://ui-avatars.com/api/?name=User&background=D4AF37&color=fff',
        amount: amount,
        timestamp: DateTime.now(),
        isAutoBid: isAutoBid,
      );

      await _client.from('bids').insert(bid.toJson());

      // تحديث المزاد
      await _client
          .from('auctions')
          .update({
            'current_price': amount,
            'current_bidder_id': _currentUserId,
            'current_bidder_name': bid.bidderName,
            'total_bids': auction.totalBids + 1,
          })
          .eq('id', auctionId);

      return BidResult(
        success: true,
        message: 'تم تقديم مزايدتك بنجاح',
        isHighest: true,
      );
    } catch (e) {
      return BidResult(success: false, message: 'حدث خطأ: $e');
    }
  }

  // شراء فوري
  Future<BidResult> buyNow(String auctionId) async {
    if (_currentUserId == null) {
      return BidResult(success: false, message: 'يجب تسجيل الدخول أولاً');
    }

    try {
      final auction = await getAuction(auctionId);
      if (auction == null || auction.buyNowPrice == null) {
        return BidResult(success: false, message: 'الشراء الفوري غير متاح');
      }

      if (!auction.isActive) {
        return BidResult(success: false, message: 'المزاد غير نشط أو انتهى');
      }

      // إنهاء المزاد
      await _client
          .from('auctions')
          .update({
            'status': 'sold',
            'current_price': auction.buyNowPrice,
            'current_bidder_id': _currentUserId,
            'current_bidder_name': 'مستخدم فلكس يمن',
          })
          .eq('id', auctionId);

      return BidResult(
        success: true,
        message: 'تم الشراء الفوري بنجاح',
        isBuyNow: true,
      );
    } catch (e) {
      return BidResult(success: false, message: 'حدث خطأ: $e');
    }
  }

  // بيانات وهمية للمزادات
  List<AuctionModel> _getMockAuctions() {
    return [
      AuctionModel(
        id: '1',
        title: 'آيفون 15 برو ماكس - جديد',
        description: 'آيفون 15 برو ماكس 256GB لون تيتانيوم طبيعي، جديد بالكرتونة مع ضمان سنة',
        sellerId: 'seller1',
        sellerName: 'إلكترونيات الحديثة',
        sellerAvatar: 'https://ui-avatars.com/api/?name=Electronics&background=2196F3&color=fff',
        images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'],
        category: 'إلكترونيات',
        startingPrice: 3500,
        reservePrice: 4200,
        currentPrice: 4100,
        minBidIncrement: 100,
        currentBidderId: 'bidder1',
        currentBidderName: 'أحمد',
        totalBids: 8,
        startTime: DateTime.now().subtract(const Duration(days: 2)),
        endTime: DateTime.now().add(const Duration(hours: 6)),
        status: AuctionStatus.active,
        type: AuctionType.reserve,
        isFeatured: true,
        location: 'صنعاء',
      ),
      AuctionModel(
        id: '2',
        title: 'تويوتا كامري 2024 - فل كامل',
        description: 'تويوتا كامري 2024 لون أبيض لؤلؤي، فل كامل، ضمان 5 سنوات',
        sellerId: 'seller2',
        sellerName: 'معارض النخبة',
        sellerAvatar: 'https://ui-avatars.com/api/?name=Cars&background=4CAF50&color=fff',
        images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'],
        category: 'سيارات',
        startingPrice: 85000,
        buyNowPrice: 98000,
        currentPrice: 92000,
        minBidIncrement: 1000,
        currentBidderId: 'bidder2',
        currentBidderName: 'محمد',
        totalBids: 12,
        startTime: DateTime.now().subtract(const Duration(days: 5)),
        endTime: DateTime.now().add(const Duration(days: 2)),
        status: AuctionStatus.active,
        type: AuctionType.buyNow,
        location: 'عدن',
        canShip: false,
      ),
      AuctionModel(
        id: '3',
        title: 'فيلا فاخرة - حي الراقي',
        description: 'فيلا دورين مع مسبح وحديقة، مساحة 600م، تشطيب سوبر لوكس',
        sellerId: 'seller3',
        sellerName: 'عقارات الماسة',
        sellerAvatar: 'https://ui-avatars.com/api/?name=RealEstate&background=9C27B0&color=fff',
        images: ['https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400'],
        category: 'عقارات',
        startingPrice: 1800000,
        reservePrice: 2200000,
        currentPrice: 1950000,
        minBidIncrement: 50000,
        totalBids: 5,
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 10)),
        status: AuctionStatus.active,
        type: AuctionType.reserve,
        location: 'صنعاء',
        canShip: false,
      ),
      AuctionModel(
        id: '4',
        title: 'ساعة رولكس ديت جست - أصلية',
        description: 'ساعة رولكس ديت جست 41mm، ذهب وستيل، مع علبة وكرت ضمان',
        sellerId: 'seller4',
        sellerName: 'مجوهرات الفردان',
        sellerAvatar: 'https://ui-avatars.com/api/?name=Jewelry&background=FF9800&color=fff',
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400'],
        category: 'مجوهرات',
        startingPrice: 25000,
        currentPrice: 28000,
        minBidIncrement: 500,
        currentBidderId: 'bidder3',
        currentBidderName: 'خالد',
        totalBids: 15,
        startTime: DateTime.now().subtract(const Duration(hours: 12)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        status: AuctionStatus.active,
        type: AuctionType.standard,
        isFeatured: true,
        location: 'تعز',
      ),
      AuctionModel(
        id: '5',
        title: 'لوحة فنية أصلية - فنان يمني',
        description: 'لوحة زيتية للفنان اليمني هاشم علي، مقاس 100x80 سم',
        sellerId: 'seller5',
        sellerName: 'غاليري الفن',
        sellerAvatar: 'https://ui-avatars.com/api/?name=Art&background=E91E63&color=fff',
        images: ['https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'],
        category: 'فنون',
        startingPrice: 5000,
        currentPrice: 5500,
        minBidIncrement: 200,
        totalBids: 3,
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 5)),
        status: AuctionStatus.active,
        type: AuctionType.standard,
        location: 'صنعاء',
      ),
    ];
  }

AuctionModel? _getMockAuctionById(String id) {
    try {
      return _getMockAuctions().firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  List<BidModel> _getMockBids(String auctionId) {
    if (auctionId == '1') {
      return [
        BidModel(id: '1', auctionId: '1', bidderId: 'u1', bidderName: 'أحمد', bidderAvatar: '', amount: 3600, timestamp: DateTime.now().subtract(const Duration(days: 2))),
        BidModel(id: '2', auctionId: '1', bidderId: 'u2', bidderName: 'سارة', bidderAvatar: '', amount: 3800, timestamp: DateTime.now().subtract(const Duration(days: 1))),
        BidModel(id: '3', auctionId: '1', bidderId: 'u3', bidderName: 'محمد', bidderAvatar: '', amount: 4000, timestamp: DateTime.now().subtract(const Duration(hours: 12))),
        BidModel(id: '4', auctionId: '1', bidderId: 'u1', bidderName: 'أحمد', bidderAvatar: '', amount: 4100, timestamp: DateTime.now().subtract(const Duration(hours: 2)), isWinning: true),
      ];
    }
    return [];
  }

  void dispose() {
    _auctionSubscription?.cancel();
    _auctionsController.close();
    _bidsController.close();
  }
}

class BidResult {
  final bool success;
  final String message;
  final bool isHighest;
  final bool isBuyNow;

  BidResult({
    required this.success,
    required this.message,
    this.isHighest = false,
    this.isBuyNow = false,
  });
}

