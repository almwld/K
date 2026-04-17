import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/seller_report_model.dart';

class SellerReportService {
  final SupabaseClient _client = Supabase.instance.client;
  String? _currentUserId;

  SellerReportService() {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // الحصول على ملخص المبيعات
  Future<SalesSummaryModel> getSalesSummary({ReportPeriod period = ReportPeriod.month}) async {
    if (_currentUserId == null) return _getMockSalesSummary();

    try {
      final response = await _client
          .from('seller_reports')
          .select()
          .eq('seller_id', _currentUserId!)
          .eq('period', period.name)
          .single();

      return SalesSummaryModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return _getMockSalesSummary();
    }
  }

  // الحصول على المبيعات اليومية
  Future<List<DailySalesModel>> getDailySales({int days = 7}) async {
    if (_currentUserId == null) return _getMockDailySales(days);

    try {
      final response = await _client
          .from('daily_sales')
          .select()
          .eq('seller_id', _currentUserId!)
          .order('date', ascending: false)
          .limit(days);

      return (response as List).map<DailySalesModel>((json) => 
        DailySalesModel.fromJson(json as Map<String, dynamic>)
      ).toList().reversed.toList();
    } catch (e) {
      return _getMockDailySales(days);
    }
  }

  // الحصول على المنتجات الأكثر مبيعاً
  Future<List<TopProductModel>> getTopProducts({int limit = 10}) async {
    if (_currentUserId == null) return _getMockTopProducts(limit);

    try {
      final response = await _client
          .from('top_products')
          .select()
          .eq('seller_id', _currentUserId!)
          .order('revenue', ascending: false)
          .limit(limit);

      return (response as List).map<TopProductModel>((json) => 
        TopProductModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockTopProducts(limit);
    }
  }

  // الحصول على مبيعات الفئات
  Future<List<CategorySalesModel>> getCategorySales() async {
    if (_currentUserId == null) return _getMockCategorySales();

    try {
      final response = await _client
          .from('category_sales')
          .select()
          .eq('seller_id', _currentUserId!)
          .order('sales', ascending: false);

      return (response as List).map<CategorySalesModel>((json) => 
        CategorySalesModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockCategorySales();
    }
  }

  // الحصول على الطلبات الأخيرة
  Future<List<RecentOrderModel>> getRecentOrders({int limit = 10}) async {
    if (_currentUserId == null) return _getMockRecentOrders(limit);

    try {
      final response = await _client
          .from('orders')
          .select()
          .eq('seller_id', _currentUserId!)
          .order('created_at', ascending: false)
          .limit(limit);

      return (response as List).map<RecentOrderModel>((json) => 
        RecentOrderModel.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      return _getMockRecentOrders(limit);
    }
  }

  // الحصول على تحليلات العملاء
  Future<CustomerInsightModel> getCustomerInsights() async {
    if (_currentUserId == null) return _getMockCustomerInsights();

    try {
      final response = await _client
          .from('customer_insights')
          .select()
          .eq('seller_id', _currentUserId!)
          .single();

      return CustomerInsightModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      return _getMockCustomerInsights();
    }
  }

  // تصدير التقرير
  Future<String?> exportReport({required ReportPeriod period, required String format}) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'تقرير_المبيعات_${period.name}.$format';
  }

  // بيانات وهمية
  SalesSummaryModel _getMockSalesSummary() {
    final random = Random();
    final sales = 15000 + random.nextInt(20000).toDouble();
    final orders = 45 + random.nextInt(30);
    final profit = sales * 0.3;
    
    return SalesSummaryModel(
      totalSales: sales,
      totalOrders: orders,
      averageOrderValue: sales / orders,
      totalProfit: profit,
      totalProducts: 25 + random.nextInt(20),
      totalCustomers: 120 + random.nextInt(80),
      growthPercentage: 12.5 + random.nextDouble() * 10,
      profitMargin: 30,
    );
  }

  List<DailySalesModel> _getMockDailySales(int days) {
    final List<String> dayNames = ['السبت', 'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
    final random = Random();
    final List<DailySalesModel> result = [];
    
    for (int i = days - 1; i >= 0; i--) {
      final dayIndex = (DateTime.now().weekday - i - 1) % 7;
      result.add(DailySalesModel(
        day: dayNames[dayIndex >= 0 ? dayIndex : dayIndex + 7],
        sales: 1500 + random.nextInt(3000).toDouble(),
        orders: 5 + random.nextInt(15),
        profit: 500 + random.nextInt(1000).toDouble(),
      ));
    }
    return result;
  }

  List<TopProductModel> _getMockTopProducts(int limit) {
    return [
      TopProductModel(id: '1', name: 'آيفون 15 برو ماكس', imageUrl: 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=200', quantitySold: 45, revenue: 234000, profit: 46800, stock: 12, growth: 15.5),
      TopProductModel(id: '2', name: 'سامسونج S24 الترا', imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=200', quantitySold: 38, revenue: 182400, profit: 36480, stock: 8, growth: 22.3),
      TopProductModel(id: '3', name: 'ماك بوك برو M3', imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=200', quantitySold: 22, revenue: 158400, profit: 31680, stock: 5, growth: 8.7),
      TopProductModel(id: '4', name: 'آيباد برو 12.9', imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=200', quantitySold: 18, revenue: 75600, profit: 15120, stock: 15, growth: -3.2),
      TopProductModel(id: '5', name: 'سماعات AirPods Pro', imageUrl: 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=200', quantitySold: 65, revenue: 61750, profit: 18525, stock: 25, growth: 35.8),
    ].take(limit).toList();
  }

  List<CategorySalesModel> _getMockCategorySales() {
    return [
      CategorySalesModel(category: 'هواتف ذكية', sales: 416400, percentage: 45, color: const Color(0xFF2196F3)),
      CategorySalesModel(category: 'لابتوبات', sales: 235200, percentage: 25, color: const Color(0xFF4CAF50)),
      CategorySalesModel(category: 'أجهزة لوحية', sales: 120800, percentage: 13, color: const Color(0xFFFF9800)),
      CategorySalesModel(category: 'سماعات', sales: 98500, percentage: 10, color: const Color(0xFF9C27B0)),
      CategorySalesModel(category: 'إكسسوارات', sales: 65400, percentage: 7, color: const Color(0xFFE91E63)),
    ];
  }

  List<RecentOrderModel> _getMockRecentOrders(int limit) {
    final names = ['أحمد محمد', 'فاطمة علي', 'عمر خالد', 'سارة أحمد', 'محمد عبدالله', 'نورة سعيد'];
    final statuses = ['completed', 'processing', 'pending', 'completed', 'completed', 'processing'];
    final random = Random();
    
    return List.generate(limit, (index) {
      return RecentOrderModel(
        id: 'ORD${1000 + index}',
        customerName: names[index % names.length],
        customerAvatar: 'https://ui-avatars.com/api/?name=${names[index % names.length].replaceAll(' ', '+')}&background=D4AF37&color=fff',
        amount: 500 + random.nextInt(5000).toDouble(),
        status: statuses[index % statuses.length],
        createdAt: DateTime.now().subtract(Duration(hours: index * 3 + random.nextInt(10))),
        items: 1 + random.nextInt(5),
      );
    });
  }

  CustomerInsightModel _getMockCustomerInsights() {
    return CustomerInsightModel(
      totalCustomers: 245,
      newCustomers: 38,
      returningCustomers: 187,
      retentionRate: 76.3,
      topLocations: ['صنعاء', 'عدن', 'تعز', 'إب', 'الحديدة'],
    );
  }
}
