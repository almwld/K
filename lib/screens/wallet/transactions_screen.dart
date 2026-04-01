import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  final List<Map<String, dynamic>> _transactions = const [
    {'type': 'deposit', 'title': 'إيداع', 'amount': 50000, 'date': '2026-03-28', 'status': 'completed'},
    {'type': 'withdraw', 'title': 'سحب', 'amount': -20000, 'date': '2026-03-27', 'status': 'completed'},
    {'type': 'transfer', 'title': 'تحويل', 'amount': -15000, 'date': '2026-03-26', 'status': 'completed'},
    {'type': 'payment', 'title': 'دفع', 'amount': -5000, 'date': '2026-03-25', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سجل العمليات'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          final transaction = _transactions[index];
          final isPositive = transaction['amount'] > 0;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isPositive ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
              title: Text(transaction['title'] as String),
              subtitle: Text(transaction['date'] as String),
              trailing: Text(
                '${isPositive ? '+' : ''}${transaction['amount']} ر.ي',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
