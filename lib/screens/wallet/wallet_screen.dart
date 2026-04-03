import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'deposit_screen.dart';
import 'withdraw_screen.dart';
import 'transfer_screen.dart';
import 'transactions_screen.dart';
import 'bill_payment_screen.dart';
import 'gift_cards_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'الشحن والسداد', 'icon': Icons.charging_station, 'color': 0xFF4CAF50},
    {'name': 'تحويلات مالية', 'icon': Icons.currency_exchange, 'color': 0xFF2196F3},
    {'name': 'حوالات محلية', 'icon': Icons.network_cell, 'color': 0xFFFF9800},
    {'name': 'شحن رصيد', 'icon': Icons.sim_card, 'color': 0xFF9C27B0},
    {'name': 'دفع المشتريات', 'icon': Icons.shopping_cart, 'color': 0xFFE91E63},
    {'name': 'شراء تطبيقات', 'icon': Icons.apps, 'color': 0xFF1B5E20},
    {'name': 'خدمات ترفيه', 'icon': Icons.movie, 'color': 0xFFF44336},
    {'name': 'مدفوعات حكومية', 'icon': Icons.account_balance, 'color': 0xFF607D8B},
  ];

  final List<Map<String, dynamic>> _recentTransactions = const [
    {'title': 'دفع مشتريات', 'amount': '5,000', 'date': '31/03/2026', 'type': 'دفع', 'icon': Icons.shopping_cart, 'color': 0xFFE91E63},
    {'title': 'شحن رصيد', 'amount': '2,000', 'date': '30/03/2026', 'type': 'شحن', 'icon': Icons.sim_card, 'color': 0xFF9C27B0},
    {'title': 'تحويل إلى جيب', 'amount': '10,000', 'date': '29/03/2026', 'type': 'تحويل', 'icon': Icons.swap_horiz, 'color': 0xFF2196F3},
    {'title': 'شراء تطبيق', 'amount': '1,500', 'date': '28/03/2026', 'type': 'شراء', 'icon': Icons.apps, 'color': 0xFF1B5E20},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final balance = 125000;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'محفظة جيب'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(context, balance, isDark),
            const SizedBox(height: 24),
            _buildServicesGrid(context),
            const SizedBox(height: 24),
            _buildQuickActions(context),
            const SizedBox(height: 24),
            _buildRecentTransactions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, double balance, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.goldColor, AppTheme.goldDark]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: const Row(children: [Icon(Icons.visibility, size: 16, color: Colors.white70), SizedBox(width: 4), Text('إظهار', style: TextStyle(color: Colors.white70, fontSize: 12))]),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('${balance.toInt()} ر.ي', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DepositScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [const Icon(Icons.arrow_downward, color: Colors.white, size: 20), const SizedBox(height: 4), const Text('إيداع', style: TextStyle(color: Colors.white, fontSize: 12))]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WithdrawScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [const Icon(Icons.arrow_upward, color: Colors.white, size: 20), const SizedBox(height: 4), const Text('سحب', style: TextStyle(color: Colors.white, fontSize: 12))]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransferScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: Column(children: [const Icon(Icons.swap_horiz, color: Colors.white, size: 20), const SizedBox(height: 4), const Text('تحويل', style: TextStyle(color: Colors.white, fontSize: 12))]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('خدماتنا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.9, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return Container(
              decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Color(service['color']).withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(service['icon'], color: Color(service['color']), size: 24)),
                  const SizedBox(height: 8),
                  Text(service['name'], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center, maxLines: 2),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldColor.withOpacity(0.3))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 20)), const SizedBox(height: 8), const Text('مسح QR', style: TextStyle(fontSize: 12))]),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BillPaymentScreen())),
            child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.receipt, color: Colors.white, size: 20)), const SizedBox(height: 8), const Text('فواتير', style: TextStyle(fontSize: 12))]),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftCardsScreen())),
            child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.card_giftcard, color: Colors.white, size: 20)), const SizedBox(height: 8), const Text('هدايا', style: TextStyle(fontSize: 12))]),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen())),
            child: Column(children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.goldColor, shape: BoxShape.circle), child: const Icon(Icons.history, color: Colors.white, size: 20)), const SizedBox(height: 8), const Text('العمليات', style: TextStyle(fontSize: 12))]),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('آخر العمليات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen())), child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _recentTransactions[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.getCardColor(context), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Color(transaction['color']).withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(transaction['icon'], color: Color(transaction['color']), size: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(transaction['title'], style: const TextStyle(fontWeight: FontWeight.bold)), Text(transaction['date'], style: const TextStyle(fontSize: 12, color: Colors.grey))])),
                  Text('${transaction['amount']} ر.ي', style: TextStyle(fontWeight: FontWeight.bold, color: transaction['type'] == 'دفع' ? Colors.red : Colors.green)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
