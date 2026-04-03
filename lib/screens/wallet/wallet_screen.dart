import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'deposit_screen.dart';
import 'withdraw_screen.dart';
import 'transfer_screen.dart';
import 'transactions_screen.dart';
import 'banks_wallets_screen.dart';
import 'bill_payment_screen.dart';
import 'gift_cards_screen.dart';
import 'money_transfers_screen.dart';
import 'government_payments_screen.dart';
import 'internet_landline_screen.dart';
import 'entertainment_services_screen.dart';
import 'apps_screen.dart';
import 'local_transfer_networks_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {'name': 'الشحن والسداد', 'icon': Icons.charge_station, 'color': 0xFF4CAF50, 'route': BillPaymentScreen},
    {'name': 'تحويلات مالية', 'icon': Icons.currency_exchange, 'color': 0xFF2196F3, 'route': MoneyTransfersScreen},
    {'name': 'حوالات محلية', 'icon': Icons.network_cell, 'color': 0xFFFF9800, 'route': LocalTransferNetworksScreen},
    {'name': 'شحن رصيد', 'icon': Icons.sim_card, 'color': 0xFF9C27B0, 'route': InternetLandlineScreen},
    {'name': 'دفع المشتريات', 'icon': Icons.shopping_cart, 'color': 0xFFE91E63, 'route': GiftCardsScreen},
    {'name': 'شراء تطبيقات', 'icon': Icons.apps, 'color': 0xFF1B5E20, 'route': AppsScreen},
    {'name': 'خدمات ترفيه', 'icon': Icons.movie, 'color': 0xFFF44336, 'route': EntertainmentServicesScreen},
    {'name': 'مدفوعات حكومية', 'icon': Icons.account_balance, 'color': 0xFF607D8B, 'route': GovernmentPaymentsScreen},
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
    final balance = 125000; // رصيد افتراضي

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'محفظة جيب'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(balance, isDark),
            const SizedBox(height: 24),
            _buildServicesGrid(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildRecentTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double balance, bool isDark) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldColor, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الرصيد المتاح',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.visibility, size: 16, color: Colors.white70),
                    SizedBox(width: 4),
                    Text('إظهار', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '$balance ر.ي',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.arrow_downward,
                  label: 'إيداع',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DepositScreen())),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.arrow_upward,
                  label: 'سحب',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WithdrawScreen())),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.swap_horiz,
                  label: 'تحويل',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransferScreen())),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('خدماتنا', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.9,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => service['route']()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(service['color']).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(service['icon'], color: Color(service['color']), size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['name'],
                      style: const TextStyle(fontSize: 11),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildQuickActionItem(Icons.qr_code_scanner, 'مسح QR', () {}),
          _buildQuickActionItem(Icons.receipt, 'فواتير', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const BillPaymentScreen()));
          }),
          _buildQuickActionItem(Icons.card_giftcard, 'هدايا', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const GiftCardsScreen()));
          }),
          _buildQuickActionItem(Icons.history, 'العمليات', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.goldColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('آخر العمليات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen()));
                },
                child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
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
            return _buildTransactionItem(transaction);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
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
              color: Color(transaction['color']).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(transaction['icon'], color: Color(transaction['color']), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(transaction['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(
            '${transaction['amount']} ر.ي',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction['type'] == 'دفع' ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
