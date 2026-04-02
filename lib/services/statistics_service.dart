import 'package:flutter/foundation.dart';
import '../models/statistics_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import 'supabase_service.dart';
import 'local_database_service.dart';

class StatisticsService {
  static final StatisticsService _instance = StatisticsService._internal();
  factory StatisticsService() => _instance;
  StatisticsService._internal();

  // جلب الإحصائيات العامة
  Future<StatisticsModel> getGeneralStatistics(String userId) async {
    try {
      // جلب البيانات من Supabase
      final products = await SupabaseService.getProducts();
      final orders = await SupabaseService.getOrders(userId);
      final users = await SupabaseService.getUsers();
      final auctions = await SupabaseService.getActiveAuctions();

      // حساب الإحصائيات
      final totalProducts = products.length;
      final totalOrders = orders.length;
      final totalSales = orders.fold(0.0, (sum, order) => sum + (order['total_price'] ?? 0));
      final totalUsers = users.length;
      final totalAuctions = auctions.length;
      final totalViews = _calculateTotalViews(products);
      final totalFavorites = await _getTotalFavorites();

      // الإحصائيات اليومية
      final dailyStats = _calculateDailyStats(orders);

      // إحصائيات الفئات
      final categoryStats = _calculateCategoryStats(products, orders);

      // إحصائيات المدن
      final cityStats = _calculateCityStats(orders);

      return StatisticsModel(
        totalProducts: totalProducts,
        totalOrders: totalOrders,
        totalSales: totalSales,
        totalUsers: totalUsers,
        totalAuctions: totalAuctions,
        averageRating: _calculateAverageRating(products),
        totalViews: totalViews,
        totalFavorites: totalFavorites,
        dailyStats: dailyStats,
        categoryStats: categoryStats,
        cityStats: cityStats,
      );
    } catch (e) {
      debugPrint('Error getting statistics: $e');
      return StatisticsModel.empty();
    }
  }

  // إحصائيات البائع
  Future<Map<String, dynamic>> getSellerStatistics(String sellerId) async {
    try {
      final products = await SupabaseService.getProductsBySeller(sellerId);
      final orders = await SupabaseService.getOrdersBySeller(sellerId);

      final totalProducts = products.length;
      final totalOrders = orders.length;
      final totalRevenue = orders.fold(0.0, (sum, order) => sum + (order['total_price'] ?? 0));
      final averageRating = _calculateAverageRating(products);

      // المنتجات الأكثر مبيعاً
      final topProducts = _getTopProducts(orders, products);

      return {
        'totalProducts': totalProducts,
        'totalOrders': totalOrders,
        'totalRevenue': totalRevenue,
        'averageRating': averageRating,
        'topProducts': topProducts,
        'monthlySales': _getMonthlySales(orders),
      };
    } catch (e) {
      debugPrint('Error getting seller statistics: $e');
      return {};
    }
  }

  // إحصائيات المستخدم
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      final orders = await SupabaseService.getOrders(userId);
      final favorites = await SupabaseService.getFavorites(userId);
      final wallet = await SupabaseService.getWallet(userId);

      final totalOrders = orders.length;
      final totalSpent = orders.fold(0.0, (sum, order) => sum + (order['total_price'] ?? 0));
      final totalFavorites = favorites.length;
      final walletBalance = wallet?['balance'] ?? 0;

      return {
        'totalOrders': totalOrders,
        'totalSpent': totalSpent,
        'totalFavorites': totalFavorites,
        'walletBalance': walletBalance,
        'recentOrders': orders.take(5).toList(),
        'monthlySpending': _getMonthlySpending(orders),
      };
    } catch (e) {
      debugPrint('Error getting user statistics: $e');
      return {};
    }
  }

  int _calculateTotalViews(List<Map<String, dynamic>> products) {
    return products.fold(0, (sum, product) => sum + (product['views'] ?? 0));
  }

  double _calculateAverageRating(List<Map<String, dynamic>> products) {
    if (products.isEmpty) return 0;
    final totalRating = products.fold(0.0, (sum, product) => sum + (product['rating'] ?? 0));
    return totalRating / products.length;
  }

  Future<int> _getTotalFavorites() async {
    final favorites = await SupabaseService.getAllFavorites();
    return favorites.length;
  }

  List<DailyStat> _calculateDailyStats(List<Map<String, dynamic>> orders) {
    final Map<String, DailyStat> stats = {};
    final now = DateTime.now();

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dateKey = '${date.year}-${date.month}-${date.day}';
      stats[dateKey] = DailyStat(
        date: date,
        orders: 0,
        sales: 0,
        views: 0,
      );
    }

    for (var order in orders) {
      final orderDate = DateTime.parse(order['created_at']);
      final dateKey = '${orderDate.year}-${orderDate.month}-${orderDate.day}';
      if (stats.containsKey(dateKey)) {
        stats[dateKey] = DailyStat(
          date: stats[dateKey]!.date,
          orders: stats[dateKey]!.orders + 1,
          sales: stats[dateKey]!.sales + (order['total_price'] ?? 0),
          views: stats[dateKey]!.views,
        );
      }
    }

    return stats.values.toList();
  }

  List<CategoryStat> _calculateCategoryStats(
    List<Map<String, dynamic>> products,
    List<Map<String, dynamic>> orders,
  ) {
    final Map<String, CategoryStat> stats = {};
    double totalRevenue = 0;

    // حساب الإيرادات لكل فئة
    for (var order in orders) {
      final category = order['category'] ?? 'أخرى';
      final amount = order['total_price'] ?? 0;
      totalRevenue += amount;

      if (!stats.containsKey(category)) {
        stats[category] = CategoryStat(
          category: category,
          count: 0,
          revenue: 0,
          percentage: 0,
        );
      }
      stats[category] = CategoryStat(
        category: category,
        count: stats[category]!.count + 1,
        revenue: stats[category]!.revenue + amount,
        percentage: 0,
      );
    }

    // حساب النسب المئوية
    for (var key in stats.keys) {
      stats[key] = CategoryStat(
        category: stats[key]!.category,
        count: stats[key]!.count,
        revenue: stats[key]!.revenue,
        percentage: totalRevenue > 0 ? (stats[key]!.revenue / totalRevenue) * 100 : 0,
      );
    }

    return stats.values.toList();
  }

  List<CityStat> _calculateCityStats(List<Map<String, dynamic>> orders) {
    final Map<String, CityStat> stats = {};

    for (var order in orders) {
      final city = order['city'] ?? 'أخرى';
      final amount = order['total_price'] ?? 0;

      if (!stats.containsKey(city)) {
        stats[city] = CityStat(
          city: city,
          orders: 0,
          revenue: 0,
          users: 0,
        );
      }
      stats[city] = CityStat(
        city: city,
        orders: stats[city]!.orders + 1,
        revenue: stats[city]!.revenue + amount,
        users: stats[city]!.users,
      );
    }

    return stats.values.toList();
  }

  List<Map<String, dynamic>> _getTopProducts(
    List<Map<String, dynamic>> orders,
    List<Map<String, dynamic>> products,
  ) {
    final Map<String, int> productSales = {};

    for (var order in orders) {
      final productId = order['product_id'];
      if (productId != null) {
        productSales[productId] = (productSales[productId] ?? 0) + 1;
      }
    }

    final topProducts = productSales.entries.toList();
    topProducts.sort((a, b) => b.value.compareTo(a.value));

    return topProducts.take(5).map((entry) {
      final product = products.firstWhere(
        (p) => p['id'] == entry.key,
        orElse: () => {'title': 'منتج غير معروف'},
      );
      return {
        'id': entry.key,
        'title': product['title'],
        'sales': entry.value,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _getMonthlySales(List<Map<String, dynamic>> orders) {
    final Map<String, double> monthlySales = {};
    final now = DateTime.now();

    for (int i = 5; i >= 0; i--) {
      final month = now.subtract(Duration(days: 30 * i));
      final monthKey = '${month.year}-${month.month}';
      monthlySales[monthKey] = 0;
    }

    for (var order in orders) {
      final orderDate = DateTime.parse(order['created_at']);
      final monthKey = '${orderDate.year}-${orderDate.month}';
      if (monthlySales.containsKey(monthKey)) {
        monthlySales[monthKey] = monthlySales[monthKey]! + (order['total_price'] ?? 0);
      }
    }

    return monthlySales.entries.map((entry) => {
      'month': entry.key,
      'sales': entry.value,
    }).toList();
  }

  List<Map<String, dynamic>> _getMonthlySpending(List<Map<String, dynamic>> orders) {
    final Map<String, double> monthlySpending = {};
    final now = DateTime.now();

    for (int i = 5; i >= 0; i--) {
      final month = now.subtract(Duration(days: 30 * i));
      final monthKey = '${month.year}-${month.month}';
      monthlySpending[monthKey] = 0;
    }

    for (var order in orders) {
      final orderDate = DateTime.parse(order['created_at']);
      final monthKey = '${orderDate.year}-${orderDate.month}';
      if (monthlySpending.containsKey(monthKey)) {
        monthlySpending[monthKey] = monthlySpending[monthKey]! + (order['total_price'] ?? 0);
      }
    }

    return monthlySpending.entries.map((entry) => ({
      'month': entry.key,
      'spending': entry.value,
    })).toList();
  }
}
