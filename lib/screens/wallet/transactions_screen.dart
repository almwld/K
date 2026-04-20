import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'الكل';
  
  final List<String> _filters = ['الكل', 'إيداع', 'سحب', 'تحويل', 'دفع'];
  
  final List<Map<String, dynamic>> _transactions = [
    {'id': '1', 'title': 'إيداع نقدي', 'amount': 50000, 'type': 'إيداع', 'date': '2024-03-15', 'time': '10:30', 'status': 'completed', 'icon': Icons.arrow_downward, 'color': 0xFF4CAF50},
    {'id': '2', 'title': 'تحويل إلى يمن موبايل', 'amount': 25000, 'type': 'تحويل', 'date': '2024-03-14', 'time': '14:20', 'status': 'completed', 'icon': Icons.swap_horiz, 'color': 0xFF2196F3},
    {'id': '3', 'title': 'شراء رصيد YOU', 'amount': 5000, 'type': 'دفع', 'date': '2024-03-13', 'time': '09:15', 'status': 'completed', 'icon': Icons.shopping_cart, 'color': 0xFFFF9800},
    {'id': '4', 'title': 'سحب نقدي', 'amount': 30000, 'type': 'سحب', 'date': '2024-03-12', 'time': '16:45', 'status': 'pending', 'icon': Icons.arrow_upward, 'color': 0xFFF44336},
    {'id': '5', 'title': 'تحويل إلى بنك اليمن', 'amount': 100000, 'type': 'تحويل', 'date': '2024-03-11', 'time': '11:00', 'status': 'completed', 'icon': Icons.swap_horiz, 'color': 0xFF2196F3},
    {'id': '6', 'title': 'إيداع فلكس باي', 'amount': 75000, 'type': 'إيداع', 'date': '2024-03-10', 'time': '08:30', 'status': 'completed', 'icon': Icons.arrow_downward, 'color': 0xFF4CAF50},
    {'id': '7', 'title': 'شراء بطاقة شحن', 'amount': 3000, 'type': 'دفع', 'date': '2024-03-09', 'time': '19:20', 'status': 'failed', 'icon': Icons.shopping_cart, 'color': 0xFFF44336},
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'الكل') return _transactions;
    return _transactions.where((t) => t['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredTransactions;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سجل المعاملات'),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد معاملات', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final transaction = filtered[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = selected ? filter : 'الكل';
                });
              },
              selectedColor: AppTheme.goldLight,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final statusColor = transaction['status'] == 'completed' ? Colors.green 
        : transaction['status'] == 'pending' ? Colors.orange : Colors.red;
    final statusText = transaction['status'] == 'completed' ? 'مكتمل'
        : transaction['status'] == 'pending' ? 'قيد الانتظار' : 'فشل';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(transaction['color']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction['icon'], color: Color(transaction['color']), size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  '${transaction['date']} • ${transaction['time']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(statusText, style: TextStyle(color: statusColor, fontSize: 10)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${transaction['amount']} ر.ي',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: transaction['type'] == 'إيداع' ? Colors.green : transaction['type'] == 'سحب' ? Colors.red : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['type'],
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

