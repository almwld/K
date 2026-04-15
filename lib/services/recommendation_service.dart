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
    
    // تحميل إحصائيات الفئات
    final categoryJson = prefs.getString('category_views');
    if (categoryJson != null) {
      _categoryViews = Map<String, int>.from(Uri.parse(categoryJson).queryParameters.map((k, v) => MapEntry(k, int.parse(v))));
    }
    
    final storeJson = prefs.getString('store_views');
    if (storeJson != null) {
      _storeViews = Map<String, int>.from(Uri.parse(storeJson).queryParameters.map((k, v) => MapEntry(k, int.parse(v))));
    }
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

  // تسجيل إضافة للمفضلة
  Future<void> trackFavorite(String productId, bool isFavorite) async {
    if (isFavorite) {
      if (!_favorites.contains(productId)) _favorites.add(productId);
    } else {
      _favorites.remove(productId);
    }
    await saveUserData();
  }

  // تسجيل إضافة للسلة
  Future<void> trackAddToCart(String productId) async {
    if (!_cartItems.contains(productId)) _cartItems.add(productId);
    await saveUserData();
  }

  // تسجيل شراء
  Future<void> trackPurchase(String productId, String category) async {
    _purchaseHistory.add(productId);
    _categoryViews[category] = (_categoryViews[category] ?? 0) + 5; // زيادة وزن الفئة
    await saveUserData();
  }

  // ============ خوارزميات التوصية ============

  // 1. المنتجات الموصى بها بناءً على سجل التصفح
  List<MarketItem> getRecommendedFromHistory({int limit = 10}) {
    if (_viewHistory.isEmpty) return _getPopularProducts(limit);
    
    final allProducts = MarketData.getAllItemsComplete();
    final recommended = <MarketItem>[];
    
    // الحصول على الفئات الأكثر مشاهدة
    final topCategories = _getTopCategories();
    
    // منتجات من نفس الفئات
    for (var product in allProducts) {
      if (topCategories.contains(product.category) && 
          !_viewHistory.contains(product.name)) {
        recommended.add(product);
      }
      if (recommended.length >= limit) break;
    }
    
    // إكمال بالمنتجات المشهورة إذا لزم الأمر
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
    
    // ترتيب حسب نسبة التغير والحداثة
    final sorted = List<MarketItem>.from(allProducts)
      ..sort((a, b) {
        final scoreA = _calculateTrendingScore(a);
        final scoreB = _calculateTrendingScore(b);
        return scoreB.compareTo(scoreA);
      });
    
    return sorted.take(limit).toList();
  }

  // 4. منتجات قد تعجبك (خوارزمية هجينة)
  List<MarketItem> getRecommendedForYou({int limit = 15}) {
    final allProducts = MarketData.getAllItemsComplete();
    final scores = <MarketItem, double>{};
    
    for (var product in allProducts) {
      double score = 0;
      
      // تطابق مع الفئات المفضلة
      if (_categoryViews.containsKey(product.category)) {
        score += _categoryViews[product.category]! * 2;
      }
      
      // تطابق مع المتاجر المفضلة
      if (_storeViews.containsKey(product.store)) {
        score += _storeViews[product.store]! * 1.5;
      }
      
      // منتجات في السلة
      if (_cartItems.any((id) => _isSimilarCategory(id, product.category))) {
        score += 5;
      }
      
      // منتجات تم شراؤها سابقاً
      if (_purchaseHistory.any((id) => _isSimilarCategory(id, product.category))) {
        score += 8;
      }
      
      // نضارة المنتج (جديد)
      if (product.change24h > 2.0) score += 3;
      
      // السعر المناسب (متوسط المدى)
      if (product.price >= 100 && product.price <= 5000) score += 2;
      
      // عقوبة المنتجات التي تم تجاهلها
      if (_viewHistory.contains(product.name)) score *= 0.5;
      
      scores[product] = score;
    }
    
    // ترتيب حسب النتيجة
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
      targetCategory = 'مطاعم'; // فطور
    } else if (hour >= 11 && hour < 15) {
      targetCategory = 'مطاعم'; // غداء
    } else if (hour >= 15 && hour < 19) {
      targetCategory = 'مقاهي'; // عصر
    } else if (hour >= 19 && hour < 23) {
      targetCategory = 'مطاعم'; // عشاء
    } else {
      targetCategory = 'مطاعم'; // وجبات متأخرة
    }
    
    return allProducts
        .where((p) => p.category == targetCategory)
        .take(limit)
        .toList();
  }

  // 6. منتجات بناءً على الموقع (محاكاة)
  List<MarketItem> getLocationBasedRecommendations(String city, {int limit = 8}) {
    final allProducts = MarketData.getAllItemsComplete();
    final cityStores = _getStoresInCity(city);
    
    return allProducts
        .where((p) => cityStores.contains(p.store))
        .take(limit)
        .toList();
  }

  // 7. منتجات الموسم
  List<MarketItem> getSeasonalRecommendations({int limit = 8}) {
    final month = DateTime.now().month;
    final allProducts = MarketData.getAllItemsComplete();
    
    String seasonalCategory;
    if (month >= 3 && month <= 5) {
      seasonalCategory = 'أزياء'; // ربيع
    } else if (month >= 6 && month <= 8) {
      seasonalCategory = 'أجهزة منزلية'; // صيف - مكيفات
    } else if (month >= 9 && month <= 11) {
      seasonalCategory = 'أزياء'; // خريف
    } else {
      seasonalCategory = 'ملابس شتوية'; // شتاء
    }
    
    return allProducts
        .where((p) => p.category == seasonalCategory)
        .take(limit)
        .toList();
  }

  // 8. منتجات يشتريها معاً (Frequently Bought Together)
  List<MarketItem> getFrequentlyBoughtTogether(String productId, {int limit = 4}) {
    final allProducts = MarketData.getAllItemsComplete();
    final targetProduct = allProducts.firstWhere(
      (p) => p.name == productId,
      orElse: () => allProducts.first,
    );
    
    // قواعد الارتباط البسيطة
    final relatedCategories = _getRelatedCategories(targetProduct.category);
    
    return allProducts
        .where((p) => relatedCategories.contains(p.category) && p.name != productId)
        .take(limit)
        .toList();
  }

  // ============ دوال مساعدة ============
  
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

  bool _isSimilarCategory(String productId, String category) {
    final allProducts = MarketData.getAllItemsComplete();
    final product = allProducts.firstWhere(
      (p) => p.name == productId,
      orElse: () => allProducts.first,
    );
    return product.category == category;
  }

  List<String> _getStoresInCity(String city) {
    // محاكاة - في الواقع ستكون من API
    const storeCities = {
      'صنعاء': ['معارض النخبة للسيارات', 'إلكترونيات الحديثة', 'مطعم اليمن للمندي'],
      'عدن': ['الوكيل المعتمد للسيارات', 'عقارات الماسة'],
    };
    return storeCities[city] ?? storeCities['صنعاء']!;
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

  // الحصول على اقتراحات البحث
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

// ============ نموذج توصية مخصص ============
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
  history,      // بناءً على تصفحك
  trending,     // رائج حالياً
  forYou,       // قد تعجبك
  similar,      // مشابه لما شاهدت
  timeBased,    // مناسب لهذا الوقت
  seasonal,     // موسمي
  location,     // قريب منك
  boughtTogether // يشتري معاً
}

// ============ خدمة التوصيات الكاملة ============
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
      PersonalizedRecommendation(
        title: '📍 الأكثر طلباً في منطقتك',
        subtitle: 'منتجات مشهورة حولك',
        items: _service.getLocationBasedRecommendations('صنعاء', limit: 8),
        type: RecommendationType.location,
      ),
      PersonalizedRecommendation(
        title: '🍂 منتجات الموسم',
        subtitle: 'مناسبة لهذا الفصل',
        items: _service.getSeasonalRecommendations(limit: 8),
        type: RecommendationType.seasonal,
      ),
    ];
  }
  
  List<MarketItem> getProductPageRecommendations(String productId) {
    return _service.getSimilarProducts(productId, limit: 8);
  }
  
  List<MarketItem> getCartRecommendations() {
    // منتجات قد تحتاجها مع مشترياتك
    final allProducts = MarketData.getAllItemsComplete();
    return allProducts.where((p) => p.price < 100).take(6).toList();
  }
  
  List<String> getSmartSuggestions(String query) {
    return _service.getSearchSuggestions(query);
  }
}
