import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class EarningsInterestScreen extends StatefulWidget {
  const EarningsInterestScreen({super.key});

  @override
  State<EarningsInterestScreen> createState() => _EarningsInterestScreenState();
}

class _EarningsInterestScreenState extends State<EarningsInterestScreen> {
  String _selectedPeriod = 'month';
  
  final List<Map<String, dynamic>> _periods = [
    {'id': 'week', 'name': 'أسبوعي'},
    {'id': 'month', 'name': 'شهري'},
    {'id': 'year', 'name': 'سنوي'},
  ];

  final Map<String, dynamic> _earningsData = {
    'total_earnings': 12500,
    'total_profit': 850,
    'total_commission': 320,
    'reserved_balance': 5000,
  };

  final List<Map<String, dynamic>> _monthlyEarnings = [
    {'month': 'يناير', 'earnings': 1200, 'profit': 80},
    {'month': 'فبراير', 'earnings': 1350, 'profit': 95},
    {'month': 'مارس', 'earnings': 1100, 'profit': 70},
    {'month': 'أبريل', 'earnings': 1450, 'profit': 110},
    {'month': 'مايو', 'earnings': 1600, 'profit': 125},
    {'month': 'يونيو', 'earnings': 1400, 'profit': 100},
  ];

  final List<Map<String, dynamic>> _reservedTransactions = [
    {'title': 'حوالة معلقة', 'amount': '3,000', 'date': '2024-04-03', 'status': 'pending', 'release_date': '2024-04-05'},
    {'title': 'دفعة تأمين', 'amount': '1,500', 'date': '2024-04-02', 'status': 'pending', 'release_date': '2024-04-10'},
    {'title': 'عمولة مؤجلة', 'amount': '500', 'date': '2024-04-01', 'status': 'pending', 'release_date': '2024-04-15'},
  ];

  final List<Map<String, dynamic>> _profitHistory = [
    {'title': 'أرباح الإحالات', 'amount': '250', 'date': '2024-04-03', 'type': 'profit'},
    {'title': 'فوائد المحفظة', 'amount': '120', 'date': '2024-04-02', 'type': 'interest'},
    {'title': 'عمولة تحويلات', 'amount': '85', 'date': '2024-04-01', 'type': 'commission'},
    {'title': 'مكافأة تسجيل', 'amount': '50', 'date': '2024-03-30', 'type': 'bonus'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأرباح والفوائد'),
      body: CustomScrollView(
        slivers: [
          // بطاقات الإحصائيات
          SliverToBoxAdapter(
            child: _buildStatsCards(),
          ),
          // الرصيد المحجوز
          SliverToBoxAdapter(
            child: _buildReservedBalance(),
          ),
          // الرسم البياني
          SliverToBoxAdapter(
            child: _buildChart(),
          ),
          // سجل الأرباح
          SliverToBoxAdapter(
            child: _buildProfitHistory(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'إجمالي الأرباح',
                  '${_earningsData['total_earnings']} ر.ي',
                  Icons.trending_up,
                  Colors.green,
                  '+12%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'أرباح الإحالات',
                  '${_earningsData['total_profit']} ر.ي',
                  Icons.people,
                  Colors.blue,
                  '+8%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'العمولات',
                  '${_earningsData['total_commission']} ر.ي',
                  Icons.percent,
                  Colors.orange,
                  '+5%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'الرصيد المحجوز',
                  '${_earningsData['reserved_balance']} ر.ي',
                  Icons.lock_outline,
                  Colors.red,
                  'معلق',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon, Color color, String change) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: change.contains('+') ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: change.contains('+') ? Colors.green : Colors.orange,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.getSecondaryTextColor(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservedBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'الرصيد المحجوز',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _reservedTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _reservedTransactions[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_clock, color: Colors.orange, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(transaction['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${transaction['amount']} ر.ي',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      Text(
                        'يتم فك: ${transaction['release_date']}',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الرسم البياني للأرباح',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedPeriod,
                items: _periods.map((period) {
                  return DropdownMenuItem<String>(
                    value: period['id'],
                    child: Text(period['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPeriod = value!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 2000,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < _monthlyEarnings.length) {
                        return Text(_monthlyEarnings[value.toInt()]['month'], style: const TextStyle(fontSize: 10));
                      }
                      return const Text('');
                    },
                    reservedSize: 30,
                  ),
                ),
              ),
              barGroups: _monthlyEarnings.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: (entry.value['earnings'] as num).toDouble(),
                      color: AppTheme.goldColor,
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfitHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'سجل الأرباح',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _profitHistory.length,
          itemBuilder: (context, index) {
            final profit = _profitHistory[index];
            final iconData = profit['type'] == 'profit' ? Icons.people :
                            profit['type'] == 'interest' ? Icons.trending_up :
                            profit['type'] == 'commission' ? Icons.percent : Icons.card_giftcard;
            final iconColor = profit['type'] == 'profit' ? Colors.blue :
                              profit['type'] == 'interest' ? Colors.green :
                              profit['type'] == 'commission' ? Colors.orange : Colors.purple;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profit['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(profit['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text(
                    '+${profit['amount']} ر.ي',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
