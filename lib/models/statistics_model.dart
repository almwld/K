class StatisticsModel {
  final int totalProducts;
  final int totalOrders;
  final double totalSales;
  final int totalUsers;
  final int totalAuctions;
  final double averageRating;
  final int totalViews;
  final int totalFavorites;
  final List<DailyStat> dailyStats;
  final List<CategoryStat> categoryStats;
  final List<CityStat> cityStats;

  StatisticsModel({
    required this.totalProducts,
    required this.totalOrders,
    required this.totalSales,
    required this.totalUsers,
    required this.totalAuctions,
    required this.averageRating,
    required this.totalViews,
    required this.totalFavorites,
    required this.dailyStats,
    required this.categoryStats,
    required this.cityStats,
  });

  factory StatisticsModel.empty() {
    return StatisticsModel(
      totalProducts: 0,
      totalOrders: 0,
      totalSales: 0,
      totalUsers: 0,
      totalAuctions: 0,
      averageRating: 0,
      totalViews: 0,
      totalFavorites: 0,
      dailyStats: [],
      categoryStats: [],
      cityStats: [],
    );
  }
}

class DailyStat {
  final DateTime date;
  final int orders;
  final double sales;
  final int views;

  DailyStat({
    required this.date,
    required this.orders,
    required this.sales,
    required this.views,
  });
}

class CategoryStat {
  final String category;
  final int count;
  final double revenue;
  final double percentage;

  CategoryStat({
    required this.category,
    required this.count,
    required this.revenue,
    required this.percentage,
  });
}

class CityStat {
  final String city;
  final int orders;
  final double revenue;
  final int users;

  CityStat({
    required this.city,
    required this.orders,
    required this.revenue,
    required this.users,
  });
}
