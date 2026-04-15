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

  // 1. المنتجات الموصى بها بناءً على سجل التصفح
  List<MarketItem> getRecommendedFromHistory({int limit = 10}) {
    if (_viewHistory.isEmpty) return _getPopularProducts(limit);
    
    final allProducts = MarketData.getAllItemsComplete();
    final recommended = <MarketItem>[];
    
    final topCategories = _getTopCategories();
    
    for (var product in allProducts) {
      if (topCategories.contains(product.category) && 
          !_viewHistory.contains(product.name)) {
        recommended.add(product);
      }
      if (recommended.length >= limit) break;
    }
    
    if (recommended.length < limit) {
      recommended.addAll(_getPopularProducts(limit - recommended.length));
    }
    
    return recommended.take(limit).toList();
  }

  // 2. المنتجات المشابهة لمنتج معين
  List<MarketItem> getSimilarProducts(String productId, {int limit = 8}) {
    final allProducts = MarketData.getAllItemsComplete();
    final targetProduct = allProducts.firstWhere(
      (p) => p.name == productId,
      orElse: () => allProducts.first,
    );
    
    return allProducts
        .where((p) => p.category == targetProduct.category && p.name != productId)
        .take(limit)
        .toList();
  }

  // 3. المنتجات الرائجة حالياً
  List<MarketItem> getTrendingProducts({int limit = 12}) {
    final allProducts = MarketData.getAllItemsComplete();
    
    final sorted = List<MarketItem>.from(allProducts)
      ..sort((a, b) {
        final scoreA = _calculateTrendingScore(a);
        final scoreB = _calculateTrendingScore(b);
        return scoreB.compareTo(scoreA);
      });
    
    return sorted.take(limit).toList();
  }

  // 4. منتجات قد تعجبك
  List<MarketItem> getRecommendedForYou({int limit = 15}) {
    final allProducts = MarketData.getAllItemsComplete();
    final scores = <MarketItem, double>{};
    
    for (var product in allProducts) {
      double score = 0;
      
      if (_categoryViews.containsKey(product.category)) {
        score += _categoryViews[product.category]! * 2;
      }
      
      if (_storeViews.containsKey(product.store)) {
        score += _storeViews[product.store]! * 1.5;
      }
      
      if (product.change24h > 2.0) score += 3;
      
      if (product.price >= 100 && product.price <= 5000) score += 2;
      
      if (_viewHistory.contains(product.name)) score *= 0.5;
      
      scores[product] = score;
    }
    
    final sorted = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sorted.map((e) => e.key).take(limit).toList();
  }

  // 5. منتجات بناءً على وقت اليوم
  List<MarketItem> getTimeBasedRecommendations({int limit = 6}) {
    final hour = DateTime.now().hour;
    final allProducts = MarketData.getAllItemsComplete();
    
    String targetCategory;
    if (hour >= 6 && hour < 11) {
      targetCategory = 'مطاعم';
    } else if (hour >= 11 && hour < 15) {
      targetCategory = 'مطاعم';
    } else if (hour >= 15 && hour < 19) {
      targetCategory = 'مقاهي';
    } else if (hour >= 19 && hour < 23) {
      targetCategory = 'مطاعم';
    } else {
      targetCategory = 'مطاعم';
    }
    
    return allProducts
        .where((p) => p.category == targetCategory)
        .take(limit)
        .toList();
  }

  // 6. منتجات بناءً على الموقع
  List<MarketItem> getLocationBasedRecommendations(String city, {int limit = 8}) {
    final allProducts = MarketData.getAllItemsComplete();
    return allProducts.take(limit).toList();
  }

  // 7. منتجات الموسم
  List<MarketItem> getSeasonalRecommendations({int limit = 8}) {
    final allProducts = MarketData.getAllItemsComplete();
    return allProducts.take(limit).toList();
  }

  // 8. منتجات يشتريها معاً
  List<MarketItem> getFrequentlyBoughtTogether(String productId, {int limit = 4}) {
    final allProducts = MarketData.getAllItemsComplete();
    final targetProduct = allProducts.firstWhere(
      (p) => p.name == productId,
      orElse: () => allProducts.first,
    );
    
    final relatedCategories = _getRelatedCategories(targetProduct.category);
    
    return allProducts
        .where((p) => relatedCategories.contains(p.category) && p.name != productId)
        .take(limit)
        .toList();
  }

  // دوال مساعدة
  List<String> _getTopCategories() {
    final sorted = _categoryViews.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(3).map((e) => e.key).toList();
  }

  List<MarketItem> _getPopularProducts(int limit) {
    final allProducts = MarketData.getAllItemsComplete();
    return allProducts
        .where((p) => p.change24h > 0)
        .take(limit)
        .toList();
  }

  double _calculateTrendingScore(MarketItem product) {
    double score = product.change24h.abs();
    if (product.price > 1000) score *= 1.5;
    if (product.isFavorite) score *= 2;
    return score;
  }

  List<String> _getRelatedCategories(String category) {
    const relations = {
      'سيارات': ['قطع غيار', 'غسيل سيارات', 'خدمة سيارات'],
      'إلكترونيات': ['إكسسوارات تصوير', 'سماعات', 'أجهزة منزلية'],
      'أزياء': ['أحذية', 'شنط وإكسسوارات', 'عطور'],
      'مواد غذائية': ['معلبات', 'مشروبات', 'مخبوزات'],
      'مطاعم': ['مشروبات', 'حلويات', 'عصائر'],
    };
    return relations[category] ?? ['إلكترونيات', 'أزياء'];
  }

  // اقتراحات البحث
  List<String> getSearchSuggestions(String query) {
    if (query.isEmpty) return _getPopularSearches();
    
    final allProducts = MarketData.getAllItemsComplete();
    final suggestions = <String>[];
    
    for (var product in allProducts) {
      if (product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(product.name);
      }
      if (suggestions.length >= 8) break;
    }
    
    return suggestions;
  }

  List<String> _getPopularSearches() {
    return ['آيفون', 'تويوتا', 'مندي', 'فيلا', 'لابتوب', 'عطور', 'ذهب', 'سيارة'];
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
        title: '✨ منتجات قد تعجبك',
        subtitle: 'بناءً على اهتماماتك',
        items: _service.getRecommendedForYou(limit: 12),
        type: RecommendationType.forYou,
      ),
      PersonalizedRecommendation(
        title: '🔥 رائج الآن',
        subtitle: 'الأكثر مبيعاً هذا الأسبوع',
        items: _service.getTrendingProducts(limit: 10),
        type: RecommendationType.trending,
      ),
      PersonalizedRecommendation(
        title: '👀 شاهدته مؤخراً',
        subtitle: 'تابع من حيث توقفت',
        items: _service.getRecommendedFromHistory(limit: 8),
        type: RecommendationType.history,
      ),
      PersonalizedRecommendation(
        title: '🕐 مناسب لهذا الوقت',
        subtitle: 'اقتراحات حسب وقت اليوم',
        items: _service.getTimeBasedRecommendations(limit: 6),
        type: RecommendationType.timeBased,
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
