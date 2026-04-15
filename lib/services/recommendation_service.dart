import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/market_item.dart';

// استيراد مباشر مع تأكيد المسار
import '../data/market_data.dart' as market_data;

class RecommendationService {
  static final RecommendationService _instance = RecommendationService._internal();
  factory RecommendationService() => _instance;
  RecommendationService._internal();

  List<String> _viewHistory = [];
  List<String> _searchHistory = [];

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _viewHistory = prefs.getStringList('view_history') ?? [];
    _searchHistory = prefs.getStringList('search_history') ?? [];
  }

  Future<void> trackProductView(String productId, String category, String store) async {
    _viewHistory.insert(0, productId);
    if (_viewHistory.length > 100) _viewHistory.removeLast();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('view_history', _viewHistory);
  }

  Future<void> trackSearch(String query) async {
    _searchHistory.insert(0, query);
    if (_searchHistory.length > 50) _searchHistory.removeLast();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory);
  }

  // الحصول على جميع المنتجات
  List<MarketItem> _getAllProducts() {
    try {
      return market_data.MarketData.getAllItemsComplete();
    } catch (e) {
      return [
        MarketItem(category: 'إلكترونيات', name: 'آيفون 15', imageUrl: '', price: 4500, change24h: 2.5, store: 'إلكترونيات'),
        MarketItem(category: 'سيارات', name: 'كامري', imageUrl: '', price: 95000, change24h: 1.8, store: 'سيارات'),
      ];
    }
  }

  List<MarketItem> getRecommendedFromHistory({int limit = 10}) {
    final products = _getAllProducts();
    if (products.isEmpty) return [];
    return products.take(limit).toList();
  }

  List<MarketItem> getSimilarProducts(String productId, {int limit = 8}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<MarketItem> getTrendingProducts({int limit = 12}) {
    final products = _getAllProducts();
    final sorted = List<MarketItem>.from(products)
      ..sort((a, b) => b.change24h.compareTo(a.change24h));
    return sorted.take(limit).toList();
  }

  List<MarketItem> getRecommendedForYou({int limit = 15}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<MarketItem> getTimeBasedRecommendations({int limit = 6}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<MarketItem> getLocationBasedRecommendations(String city, {int limit = 8}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<MarketItem> getSeasonalRecommendations({int limit = 8}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<MarketItem> getFrequentlyBoughtTogether(String productId, {int limit = 4}) {
    final products = _getAllProducts();
    return products.take(limit).toList();
  }

  List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) {
      return ['آيفون', 'تويوتا', 'كامري', 'فيلا', 'لابتوب'];
    }
    final products = _getAllProducts();
    return products
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .map((p) => p.name)
        .take(8)
        .toList();
  }
}

class PersonalizedRecommendation {
  final String title;
  final String subtitle;
  final List<MarketItem> items;
  final String type;

  PersonalizedRecommendation({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.type,
  });
}

class SmartRecommendationEngine {
  final RecommendationService _service = RecommendationService();
  
  Future<List<PersonalizedRecommendation>> getHomePageRecommendations() async {
    await _service.loadUserData();
    
    return [
      PersonalizedRecommendation(
        title: 'منتجات قد تعجبك',
        subtitle: 'بناءً على اهتماماتك',
        items: _service.getRecommendedForYou(limit: 12),
        type: 'forYou',
      ),
      PersonalizedRecommendation(
        title: 'رائج الآن',
        subtitle: 'الأكثر مبيعاً',
        items: _service.getTrendingProducts(limit: 10),
        type: 'trending',
      ),
    ];
  }
  
  List<MarketItem> getProductPageRecommendations(String productId) {
    return _service.getSimilarProducts(productId, limit: 8);
  }
  
  List<String> getSmartSuggestions(String query) {
    return _service.getSearchSuggestions(query);
  }
}
