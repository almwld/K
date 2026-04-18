import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SpendingAnalyticsScreen extends StatefulWidget {
  const SpendingAnalyticsScreen({super.key});

  @override
  State<SpendingAnalyticsScreen> createState() => _SpendingAnalyticsScreenState();
}

class _SpendingAnalyticsScreenState extends State<SpendingAnalyticsScreen> {
  String _selectedPeriod = 'month';
  String _selectedChartType = 'pie';
  
  final List<Map<String, dynamic>> _periods = [
    {'id': 'week', 'name': 'أسبوعي'},
    {'id': 'month', 'name': 'شهري'},
    {'id': 'year', 'name': 'سنوي'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'name': 'تحويلات', 'amount': 25000, 'color': 0xFF2196F3, 'icon': Icons.swap_horiz, 'percentage': 35},
    {'name': 'مشتريات', 'amount': 15000, 'color': 0xFFFF9800, 'icon': Icons.shopping_cart, 'percentage': 21},
    {'name': 'فواتير', 'amount': 12000, 'color': 0xFF4CAF50, 'icon': Icons.receipt, 'percentage': 17},
    {'name': 'ترفيه', 'amount': 8000, 'color': 0xFFF44336, 'icon': Icons.movie, 'percentage': 11},
    {'name': 'تطبيقات', 'amount': 5000, 'color': 0xFF9C27B0, 'icon': Icons.apps, 'percentage': 7},
    {'name': 'أخرى', 'amount': 6000, 'color': 0xFF795548, 'icon': Icons.more_horiz, 'percentage': 9},
  ];

  final List<Map<String, dynamic>> _monthlySpending = [
    {'month': 'يناير', 'amount': 18000},
    {'month': 'فبراير', 'amount': 22000},
    {'month': 'مارس', 'amount': 15000},
    {'month': 'أبريل', 'amount': 25000},
    {'month': 'مايو', 'amount': 30000},
    {'month': 'يونيو', 'amount': 28000},
  ];

  final List<Map<String, dynamic>> _recentSpending = [
    {'title': 'تحويل إلى جيب', 'amount': '5,000', 'date': 'اليوم', 'category': 'تحويلات', 'icon': Icons.swap_horiz, 'color': 0xFF2196F3},
    {'title': 'شراء باقة نت', 'amount': '2,000', 'date': 'الأمس', 'category': 'فواتير', 'icon': Icons.wifi, 'color': 0xFF4CAF50},
    {'title': 'نتفليكس', 'amount': '1,500', 'date': '2024-04-02', 'category': 'ترفيه', 'icon': Icons.movie, 'color': 0xFFF44336},
    {'title': 'شحن رصيد', 'amount': '1,000', 'date': '2024-04-01', 'category': 'أخرى', 'icon': Icons.sim_card, 'color': 0xFF795548},
  ];

  double get _totalSpending {
    return _categories.fold(0.0, (sum, item) => sum + (item['amount'] as num).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تحليل الإنفاق'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildPeriodSelector(),
          ),
          SliverToBoxAdapter(
            child: _buildTotalSpendingCard(),
          ),
          SliverToBoxAdapter(
            child: _buildChartTypeSelector(),
          ),
          SliverToBoxAdapter(
            child: _selectedChartType == 'pie' ? _buildPieChart() : _buildBarChart(),
          ),
          SliverToBoxAdapter(
            child: _buildCategoriesList(),
          ),
          SliverToBoxAdapter(
            child: _buildRecentSpending(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: _periods.map((period) {
          final isSelected = _selectedPeriod == period['id'];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedPeriod = period['id']),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldLight : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  period['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTotalSpendingCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldLight, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إجمالي الإنفاق', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            '${NumberFormat('#,###').format(_totalSpending)} ر.ي',
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                '+12% عن الشهر الماضي',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartTypeSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedChartType = 'pie'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedChartType == 'pie' ? AppTheme.goldLight.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedChartType == 'pie' ? AppTheme.goldLight : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pie_chart, color: _selectedChartType == 'pie' ? AppTheme.goldLight : Colors.grey),
                    const SizedBox(width: 8),
                    Text('دائري', style: TextStyle(color: _selectedChartType == 'pie' ? AppTheme.goldLight : null)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedChartType = 'bar'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedChartType == 'bar' ? AppTheme.goldLight.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedChartType == 'bar' ? AppTheme.goldLight : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart, color: _selectedChartType == 'bar' ? AppTheme.goldLight : Colors.grey),
                    const SizedBox(width: 8),
                    Text('أعمدة', style: TextStyle(color: _selectedChartType == 'bar' ? AppTheme.goldLight : null)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: PieChart(
        PieChartData(
          sections: _categories.asMap().entries.map((entry) {
            final index = entry.key;
            final category = entry.value;
            return PieChartSectionData(
              value: category['amount'].toDouble(),
              title: '${category['percentage']}%',
              color: Color(category['color']),
              radius: 80,
              titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 35000,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < _monthlySpending.length) {
                    return Text(_monthlySpending[value.toInt()]['month'], style: const TextStyle(fontSize: 10));
                  }
                  return const Text('');
                },
                reservedSize: 30,
              ),
            ),
          ),
          barGroups: _monthlySpending.asMap().entries.map((entry) {
            return BarChartGroupData(
              x: entry.key,
              barRods: [
                BarChartRodData(
                  toY: entry.value['amount'].toDouble(),
                  color: AppTheme.goldLight,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }).toList(),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  Widget _buildCategoriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('تفصيل حسب الفئة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(category['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(category['icon'], color: Color(category['color']), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(category['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        LinearProgressIndicator(
                          value: category['amount'] / _totalSpending,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(category['color'])),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${NumberFormat('#,###').format(category['amount'])} ر.ي',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentSpending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('آخر المعاملات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentSpending.length,
          itemBuilder: (context, index) {
            final spending = _recentSpending[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(spending['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(spending['icon'], color: Color(spending['color']), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spending['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(spending['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(spending['color']).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(spending['category'], style: TextStyle(fontSize: 9, color: Color(spending['color']))),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '-${spending['amount']} ر.ي',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
