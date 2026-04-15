import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/market_item.dart';
import '../data/market_data.dart';

class RecommendationService {
  static final RecommendationService _instance = RecommendationService._internal();
  factory RecommendationService() => _instance;
  RecommendationService._internal();

  // سجل تصفح المستخدم
  List<String> _viewHistory = [];
  List<String> _searchHistory = [];
  List<String> _favorites = [];
  List<String> _cartItems = [];
  Map<String, int> _categoryViews = {};
  Map<String, int> _storeViews = {};
  List<String> _purchaseHistory = [];

  // تحميل البيانات المحفوظة
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _viewHistory = prefs.getStringList('view_history') ?? [];
    _searchHistory = prefs.getStringList('search_history') ?? [];
    _favorites = prefs.getStringList('favorites') ?? [];
    _cartItems = prefs.getStringList('cart_items') ?? [];
    _purchaseHistory = prefs.getStringList('purchase_history') ?? [];
  }

  // حفظ بيانات المستخدم
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('view_history', _viewHistory);
    await prefs.setStringList('search_history', _searchHistory);
    await prefs.setStringList('favorites', _favorites);
    await prefs.setStringList('cart_items', _cartItems);
    await prefs.setStringList('purchase_history', _purchaseHistory);
  }

  // تسجيل مشاهدة منتج
  Future<void> trackProductView(String productId, String category, String store) async {
    _viewHistory.insert(0, productId);
    if (_viewHistory.length > 100) _viewHistory.removeLast();
    _categoryViews[category] = (_categoryViews[category] ?? 0) + 1;
    _storeViews[store] = (_storeViews[store] ?? 0) + 1;
    await saveUserData();
  }

  // تسجيل بحث
  Future<void> trackSearch(String query) async {
    _searchHistory.insert(0, query);
    if (_searchHistory.length > 50) _searchHistory.removeLast();
    await saveUserData();
  }

  // 1. المنتجات الموصى بها
  List<MarketItem> getRecommendedFromHistory({int limit = 10}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      if (_viewHistory.isEmpty) return allProducts.take(limit).toList();
      
      final recommended = <MarketItem>[];
      for (var product in allProducts) {
        if (!_viewHistory.contains(product.name)) {
          recommended.add(product);
        }
        if (recommended.length >= limit) break;
      }
      return recommended;
    } catch (e) {
      return [];
    }
  }

  // 2. المنتجات المشابهة
  List<MarketItem> getSimilarProducts(String productId, {int limit = 8}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      final targetProduct = allProducts.firstWhere(
        (p) => p.name == productId,
        orElse: () => allProducts.first,
      );
      return allProducts
          .where((p) => p.category == targetProduct.category && p.name != productId)
          .take(limit)
          .toList();
    } catch (e) {
      return [];
    }
  }

  // 3. المنتجات الرائجة
  List<MarketItem> getTrendingProducts({int limit = 12}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      final sorted = List<MarketItem>.from(allProducts)
        ..sort((a, b) => b.change24h.compareTo(a.change24h));
      return sorted.take(limit).toList();
    } catch (e) {
      return [];
    }
  }

  // 4. منتجات قد تعجبك
  List<MarketItem> getRecommendedForYou({int limit = 15}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      final recommended = <MarketItem>[];
      
      for (var product in allProducts) {
        if (_categoryViews.containsKey(product.category)) {
          recommended.add(product);
        }
        if (recommended.length >= limit) break;
      }
      
      if (recommended.length < limit) {
        recommended.addAll(allProducts.take(limit - recommended.length));
      }
      
      return recommended;
    } catch (e) {
      return [];
    }
  }

  // 5. منتجات حسب الوقت
  List<MarketItem> getTimeBasedRecommendations({int limit = 6}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      return allProducts.take(limit).toList();
    } catch (e) {
      return [];
    }
  }

  // 6. منتجات حسب الموقع
  List<MarketItem> getLocationBasedRecommendations(String city, {int limit = 8}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      return allProducts.take(limit).toList();
    } catch (e) {
      return [];
    }
  }

  // 7. منتجات الموسم
  List<MarketItem> getSeasonalRecommendations({int limit = 8}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      return allProducts.take(limit).toList();
    } catch (e) {
      return [];
    }
  }

  // 8. منتجات تشترى معاً
  List<MarketItem> getFrequentlyBoughtTogether(String productId, {int limit = 4}) {
    try {
      final allProducts = MarketData.getAllItemsComplete();
      final targetProduct = allProducts.firstWhere(
        (p) => p.name == productId,
        orElse: () => allProducts.first,
      );
      return allProducts
          .where((p) => p.category == targetProduct.category && p.name != productId)
          .take(limit)
          .toList();
    } catch (e) {
      return [];
    }
  }

  // اقتراحات البحث
  List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) {
      return ['آيفون', 'تويوتا', 'مندي', 'فيلا', 'لابتوب', 'عطور', 'ذهب', 'سيارة'];
    }
    
    try {
      final allProducts = MarketData.getAllItemsComplete();
      final suggestions = <String>[];
      for (var product in allProducts) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          suggestions.add(product.name);
        }
        if (suggestions.length >= 8) break;
      }
      return suggestions;
    } catch (e) {
      return ['آيفون', 'تويوتا', 'مندي'];
    }
  }
}

// نموذج توصية مخصص
class PersonalizedRecommendation {
  final String title;
  final String subtitle;
  final List<MarketItem> items;
  final RecommendationType type;

  PersonalizedRecommendation({
    required this.title,
    required this.subtitle,
    required this.items,
    required this.type,
  });
}

enum RecommendationType {
  history,
  trending,
  forYou,
  similar,
  timeBased,
  seasonal,
  location,
  boughtTogether
}

// محرك التوصيات الذكية
class SmartRecommendationEngine {
  final RecommendationService _service = RecommendationService();
  
  Future<List<PersonalizedRecommendation>> getHomePageRecommendations() async {
    await _service.loadUserData();
    
    return [
      PersonalizedRecommendation(
        title: 'منتجات قد تعجبك',
        subtitle: 'بناءً على اهتماماتك',
        items: _service.getRecommendedForYou(limit: 12),
        type: RecommendationType.forYou,
      ),
      PersonalizedRecommendation(
        title: 'رائج الآن',
        subtitle: 'الأكثر مبيعاً هذا الأسبوع',
        items: _service.getTrendingProducts(limit: 10),
        type: RecommendationType.trending,
      ),
      PersonalizedRecommendation(
        title: 'شاهدته مؤخراً',
        subtitle: 'تابع من حيث توقفت',
        items: _service.getRecommendedFromHistory(limit: 8),
        type: RecommendationType.history,
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
