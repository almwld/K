import 'package:flutter/material.dart';
enum ReportPeriod { today, week, month, quarter, year, custom }

class SalesSummaryModel {
  final double totalSales;
  final int totalOrders;
  final double averageOrderValue;
  final double totalProfit;
  final int totalProducts;
  final int totalCustomers;
  final double growthPercentage;
  final double profitMargin;

  SalesSummaryModel({
    required this.totalSales,
    required this.totalOrders,
    required this.averageOrderValue,
    required this.totalProfit,
    required this.totalProducts,
    required this.totalCustomers,
    required this.growthPercentage,
    required this.profitMargin,
  });

  factory SalesSummaryModel.fromJson(Map<String, dynamic> json) {
    return SalesSummaryModel(
      totalSales: (json['total_sales'] ?? 0).toDouble(),
      totalOrders: json['total_orders'] ?? 0,
      averageOrderValue: (json['average_order_value'] ?? 0).toDouble(),
      totalProfit: (json['total_profit'] ?? 0).toDouble(),
      totalProducts: json['total_products'] ?? 0,
      totalCustomers: json['total_customers'] ?? 0,
      growthPercentage: (json['growth_percentage'] ?? 0).toDouble(),
      profitMargin: (json['profit_margin'] ?? 0).toDouble(),
    );
  }
}

class DailySalesModel {
  final String day;
  final double sales;
  final int orders;
  final double profit;

  DailySalesModel({
    required this.day,
    required this.sales,
    required this.orders,
    required this.profit,
  });

  factory DailySalesModel.fromJson(Map<String, dynamic> json) {
    return DailySalesModel(
      day: json['day'] ?? '',
      sales: (json['sales'] ?? 0).toDouble(),
      orders: json['orders'] ?? 0,
      profit: (json['profit'] ?? 0).toDouble(),
    );
  }
}

class TopProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final int quantitySold;
  final double revenue;
  final double profit;
  final int stock;
  final double growth;

  TopProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantitySold,
    required this.revenue,
    required this.profit,
    required this.stock,
    required this.growth,
  });

  factory TopProductModel.fromJson(Map<String, dynamic> json) {
    return TopProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      quantitySold: json['quantity_sold'] ?? 0,
      revenue: (json['revenue'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      growth: (json['growth'] ?? 0).toDouble(),
    );
  }
}

class CategorySalesModel {
  final String category;
  final double sales;
  final double percentage;
  final Color color;

  CategorySalesModel({
    required this.category,
    required this.sales,
    required this.percentage,
    required this.color,
  });

  factory CategorySalesModel.fromJson(Map<String, dynamic> json) {
    return CategorySalesModel(
      category: json['category'] ?? '',
      sales: (json['sales'] ?? 0).toDouble(),
      percentage: (json['percentage'] ?? 0).toDouble(),
      color: Color(json['color'] ?? 0xFFD4AF37),
    );
  }
}

class RecentOrderModel {
  final String id;
  final String customerName;
  final String customerAvatar;
  final double amount;
  final String status;
  final DateTime createdAt;
  final int items;

  RecentOrderModel({
    required this.id,
    required this.customerName,
    required this.customerAvatar,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays} يوم';
    if (diff.inHours > 0) return '${diff.inHours} ساعة';
    if (diff.inMinutes > 0) return '${diff.inMinutes} دقيقة';
    return 'الآن';
  }

  Color get statusColor {
    switch (status) {
      case 'completed': return Colors.green;
      case 'processing': return Colors.orange;
      case 'pending': return Colors.blue;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  String get statusText {
    switch (status) {
      case 'completed': return 'مكتمل';
      case 'processing': return 'قيد التجهيز';
      case 'pending': return 'قيد الانتظار';
      case 'cancelled': return 'ملغي';
      default: return status;
    }
  }

  factory RecentOrderModel.fromJson(Map<String, dynamic> json) {
    return RecentOrderModel(
      id: json['id'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerAvatar: json['customer_avatar'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      items: json['items'] ?? 0,
    );
  }
}

class CustomerInsightModel {
  final int totalCustomers;
  final int newCustomers;
  final int returningCustomers;
  final double retentionRate;
  final List<String> topLocations;

  CustomerInsightModel({
    required this.totalCustomers,
    required this.newCustomers,
    required this.returningCustomers,
    required this.retentionRate,
    required this.topLocations,
  });

  factory CustomerInsightModel.fromJson(Map<String, dynamic> json) {
    return CustomerInsightModel(
      totalCustomers: json['total_customers'] ?? 0,
      newCustomers: json['new_customers'] ?? 0,
      returningCustomers: json['returning_customers'] ?? 0,
      retentionRate: (json['retention_rate'] ?? 0).toDouble(),
      topLocations: List<String>.from(json['top_locations'] ?? []),
    );
  }
}

