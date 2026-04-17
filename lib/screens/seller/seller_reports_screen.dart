import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../services/seller_report_service.dart';
import '../../models/seller_report_model.dart';

class SellerReportsScreen extends StatefulWidget {
  const SellerReportsScreen({super.key});

  @override
  State<SellerReportsScreen> createState() => _SellerReportsScreenState();
}

class _SellerReportsScreenState extends State<SellerReportsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SellerReportService _reportService = SellerReportService();
  
  SalesSummaryModel? _summary;
  List<DailySalesModel> _dailySales = [];
  List<TopProductModel> _topProducts = [];
  List<CategorySalesModel> _categorySales = [];
  List<RecentOrderModel> _recentOrders = [];
  CustomerInsightModel? _customerInsights;
  bool _isLoading = true;
  ReportPeriod _selectedPeriod = ReportPeriod.month;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    final summary = await _reportService.getSalesSummary(period: _selectedPeriod);
    final dailySales = await _reportService.getDailySales(days: 7);
    final topProducts = await _reportService.getTopProducts(limit: 10);
    final categorySales = await _reportService.getCategorySales();
    final recentOrders = await _reportService.getRecentOrders(limit: 10);
    final insights = await _reportService.getCustomerInsights();
    
    setState(() {
      _summary = summary;
      _dailySales = dailySales;
      _topProducts = topProducts;
      _categorySales = categorySales;
      _recentOrders = recentOrders;
      _customerInsights = insights;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
      // 
        title: 'تقارير المبيعات',
        actions: [
          PopupMenuButton<ReportPeriod>(
            onSelected: (period) {
              setState(() => _selectedPeriod = period);
              _loadData();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: ReportPeriod.today, child: Text('اليوم')),
              const PopupMenuItem(value: ReportPeriod.week, child: Text('هذا الأسبوع')),
              const PopupMenuItem(value: ReportPeriod.month, child: Text('هذا الشهر')),
              const PopupMenuItem(value: ReportPeriod.quarter, child: Text('هذا الربع')),
              const PopupMenuItem(value: ReportPeriod.year, child: Text('هذه السنة')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(_getPeriodText(_selectedPeriod), style: const TextStyle(color: Colors.black)),
                  const Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
            ),
          ),
          IconButton(onPressed: _exportReport, icon: const Icon(Icons.download)),
        ],
        // bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.goldColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppTheme.goldColor,
          tabs: const [
            Tab(text: 'الملخص'),
            Tab(text: 'المبيعات'),
            Tab(text: 'المنتجات'),
            Tab(text: 'الطلبات'),
            Tab(text: 'العملاء'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildSummaryTab(),
                _buildSalesTab(),
                _buildProductsTab(),
                _buildOrdersTab(),
                _buildCustomersTab(),
              ],
            ),
    );
  }

  String _getPeriodText(ReportPeriod period) {
    switch (period) {
      case ReportPeriod.today: return 'اليوم';
      case ReportPeriod.week: return 'الأسبوع';
      case ReportPeriod.month: return 'الشهر';
      case ReportPeriod.quarter: return 'الربع';
      case ReportPeriod.year: return 'السنة';
      default: return 'الشهر';
    }
  }

  Widget _buildSummaryTab() {
    if (_summary == null) return const SizedBox();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // بطاقات الإحصائيات
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildStatCard('إجمالي المبيعات', '${_summary!.totalSales.toInt()} ريال', Icons.trending_up, Colors.green, '+${_summary!.growthPercentage.toStringAsFixed(1)}%'),
              _buildStatCard('عدد الطلبات', '${_summary!.totalOrders}', Icons.shopping_bag, Colors.blue),
              _buildStatCard('متوسط الطلب', '${_summary!.averageOrderValue.toInt()} ريال', Icons.receipt, Colors.orange),
              _buildStatCard('الأرباح', '${_summary!.totalProfit.toInt()} ريال', Icons.monetization_on, Colors.purple, '${_summary!.profitMargin.toInt()}%'),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // رسم بياني للمبيعات
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('المبيعات اليومية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _dailySales.map((d) => d.sales).reduce((a, b) => a > b ? a : b) * 1.2,
                      barGroups: _dailySales.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [BarChartRodData(toY: entry.value.sales, color: AppTheme.goldColor, width: 20, borderRadius: BorderRadius.circular(4))],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 50)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < _dailySales.length) {
                                return Text(_dailySales[value.toInt()].day, style: const TextStyle(fontSize: 10));
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // توزيع المبيعات حسب الفئة
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('المبيعات حسب الفئة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ..._categorySales.map((cat) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(width: 12, height: 12, decoration: BoxDecoration(color: cat.color, shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                              Text(cat.category),
                            ],
                          ),
                          Text('${cat.sales.toInt()} ريال (${cat.percentage.toInt()}%)'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(value: cat.percentage / 100, backgroundColor: Colors.grey[200], valueColor: AlwaysStoppedAnimation<Color>(cat.color), minHeight: 8),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildStatCard(String title, String value, IconData icon, Color color, [String? subtitle]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              if (subtitle != null) ...[
                const SizedBox(width: 8),
                Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(subtitle, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold))),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _dailySales.length,
      itemBuilder: (context, index) {
        final sale = _dailySales[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Container(width: 50, height: 50, decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(sale.day, style: const TextStyle(fontWeight: FontWeight.bold)))),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${sale.orders} طلب', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('${sale.profit.toInt()} ريال أرباح', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
              Text('${sale.sales.toInt()} ريال', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.goldColor)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _topProducts.length,
      itemBuilder: (context, index) {
        final product = _topProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('${product.quantitySold} مباع', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(width: 12),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: product.stock > 0 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text('المخزون: ${product.stock}', style: TextStyle(color: product.stock > 0 ? Colors.green : Colors.red, fontSize: 10))),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${product.revenue.toInt()} ريال', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(product.growth >= 0 ? Icons.trending_up : Icons.trending_down, size: 14, color: product.growth >= 0 ? Colors.green : Colors.red),
                      const SizedBox(width: 2),
                      Text('${product.growth.abs().toStringAsFixed(1)}%', style: TextStyle(fontSize: 12, color: product.growth >= 0 ? Colors.green : Colors.red)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrdersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _recentOrders.length,
      itemBuilder: (context, index) {
        final order = _recentOrders[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(order.customerAvatar)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(order.customerName, style: const TextStyle(fontWeight: FontWeight.bold))),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: order.statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Text(order.statusText, style: TextStyle(color: order.statusColor, fontSize: 10))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('#${order.id}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(width: 12),
                        Text('${order.items} منتج', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        const SizedBox(width: 12),
                        Text(order.timeAgo, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text('${order.amount.toInt()} ريال', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.goldColor)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomersTab() {
    if (_customerInsights == null) return const SizedBox();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildStatCard('إجمالي العملاء', '${_customerInsights!.totalCustomers}', Icons.people, Colors.blue),
              _buildStatCard('عملاء جدد', '${_customerInsights!.newCustomers}', Icons.person_add, Colors.green),
              _buildStatCard('عملاء متكررين', '${_customerInsights!.returningCustomers}', Icons.repeat, Colors.orange),
              _buildStatCard('نسبة الاحتفاظ', '${_customerInsights!.retentionRate.toStringAsFixed(1)}%', Icons.favorite, Colors.pink),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('أكثر المدن طلباً', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ..._customerInsights!.topLocations.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Container(width: 30, height: 30, decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Center(child: Text('${entry.key + 1}', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)))),
                        const SizedBox(width: 12),
                        Expanded(child: Text(entry.value, style: const TextStyle(fontWeight: FontWeight.w500))),
                        Icon(Icons.location_on, color: Colors.grey[400], size: 18),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exportReport() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصدير التقرير'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
              onTap: () async {
                Navigator.pop(context);
                final path = await _reportService.exportReport(period: _selectedPeriod, format: 'pdf');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تصدير التقرير: $path')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Excel'),
              onTap: () async {
                Navigator.pop(context);
                final path = await _reportService.exportReport(period: _selectedPeriod, format: 'xlsx');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تصدير التقرير: $path')));
              },
            ),
          ],
        ),
      ),
    );
  }
}
