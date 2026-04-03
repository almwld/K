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
  String _selectedCurrency = 'الكل';
  
  final List<String> _filters = ['الكل', 'إيداع', 'سحب', 'تحويل', 'دفع', 'شحن'];
  final List<String> _currencies = ['الكل', 'YER', 'SAR', 'USD'];
  
  final List<Map<String, dynamic>> _allTransactions = [
    {'id': '1', 'name': 'شحن رصيد - يمن موبايل', 'amount': '+5,000', 'currency': 'YER', 'date': '2024-04-04', 'time': '10:30 ص', 'type': 'شحن', 'status': 'completed', 'icon': Icons.sim_card, 'color': 0xFF4CAF50},
    {'id': '2', 'name': 'تحويل إلى أحمد محمد', 'amount': '-2,500', 'currency': 'YER', 'date': '2024-04-03', 'time': '15:45 م', 'type': 'تحويل', 'status': 'completed', 'icon': Icons.compare_arrows, 'color': 0xFFFF9800},
    {'id': '3', 'name': 'دفع فاتورة الكهرباء', 'amount': '-1,200', 'currency': 'YER', 'date': '2024-04-03', 'time': '09:15 ص', 'type': 'دفع', 'status': 'completed', 'icon': Icons.receipt, 'color': 0xFFF44336},
    {'id': '4', 'name': 'إيداع بنكي', 'amount': '+10,000', 'currency': 'YER', 'date': '2024-04-02', 'time': '14:20 م', 'type': 'إيداع', 'status': 'completed', 'icon': Icons.account_balance, 'color': 0xFF2196F3},
    {'id': '5', 'name': 'سحب نقدي', 'amount': '-3,000', 'currency': 'YER', 'date': '2024-04-01', 'time': '11:00 ص', 'type': 'سحب', 'status': 'completed', 'icon': Icons.attach_money, 'color': 0xFF9C27B0},
    {'id': '6', 'name': 'تحويل إلى فاطمة علي', 'amount': '-100', 'currency': 'SAR', 'date': '2024-04-01', 'time': '16:30 م', 'type': 'تحويل', 'status': 'pending', 'icon': Icons.compare_arrows, 'color': 0xFFFF9800},
    {'id': '7', 'name': 'استلام من محمد سعيد', 'amount': '+50', 'currency': 'USD', 'date': '2024-03-31', 'time': '09:45 ص', 'type': 'تحويل', 'status': 'completed', 'icon': Icons.compare_arrows, 'color': 0xFFFF9800},
    {'id': '8', 'name': 'شراء بطاقة شحن', 'amount': '-500', 'currency': 'YER', 'date': '2024-03-30', 'time': '20:00 م', 'type': 'شحن', 'status': 'completed', 'icon': Icons.card_giftcard, 'color': 0xFF4CAF50},
    {'id': '9', 'name': 'دفع فاتورة الماء', 'amount': '-800', 'currency': 'YER', 'date': '2024-03-29', 'time': '13:15 م', 'type': 'دفع', 'status': 'completed', 'icon': Icons.receipt, 'color': 0xFFF44336},
    {'id': '10', 'name': 'شحن رصيد - يمن نت', 'amount': '-1,000', 'currency': 'YER', 'date': '2024-03-28', 'time': '18:30 م', 'type': 'شحن', 'status': 'failed', 'icon': Icons.sim_card, 'color': 0xFF4CAF50},
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    var transactions = _allTransactions;
    
    if (_selectedFilter != 'الكل') {
      transactions = transactions.where((t) => t['type'] == _selectedFilter).toList();
    }
    
    if (_selectedCurrency != 'الكل') {
      transactions = transactions.where((t) => t['currency'] == _selectedCurrency).toList();
    }
    
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final transactions = _filteredTransactions;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المعاملات'),
      body: Column(
        children: [
          _buildFilters(),
          _buildCurrencyFilter(),
          Expanded(
            child: transactions.isEmpty
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
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _buildTransactionCard(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
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
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.bold : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrencyFilter() {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.currency_exchange, size: 18),
          const SizedBox(width: 8),
          const Text('العملة:'),
          const SizedBox(width: 8),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _currencies.length,
              itemBuilder: (context, index) {
                final currency = _currencies[index];
                final isSelected = _selectedCurrency == currency;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCurrency = currency;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      currency,
                      style: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isPositive = transaction['amount'].startsWith('+');
    final statusColor = transaction['status'] == 'completed' ? Colors.green :
                       transaction['status'] == 'pending' ? Colors.orange : Colors.red;
    final statusText = transaction['status'] == 'completed' ? 'مكتمل' :
                       transaction['status'] == 'pending' ? 'قيد الانتظار' : 'فشل';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(transaction['color']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction['icon'], color: Color(transaction['color']), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      transaction['date'],
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      transaction['time'],
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(fontSize: 9, color: statusColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['currency'],
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
