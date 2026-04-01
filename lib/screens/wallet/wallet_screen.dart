import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  final List<Map<String, dynamic>> _walletServices = const [
    {'icon': Icons.account_balance_wallet, 'title': 'إيداع', 'route': '/deposit'},
    {'icon': Icons.money_off, 'title': 'سحب', 'route': '/withdraw'},
    {'icon': Icons.swap_horiz, 'title': 'تحويل', 'route': '/transfer'},
    {'icon': Icons.payment, 'title': 'مدفوعات', 'route': '/payments'},
    {'icon': Icons.receipt_long, 'title': 'عمليات', 'route': '/transactions'},
    {'icon': Icons.network_cell, 'title': 'شبكة التحويل', 'route': '/transfer_network'},
    {'icon': Icons.movie, 'title': 'ترفيه', 'route': '/entertainment'},
    {'icon': Icons.sports_esports, 'title': 'ألعاب', 'route': '/games'},
    {'icon': Icons.apps, 'title': 'تطبيقات', 'route': '/apps'},
    {'icon': Icons.card_giftcard, 'title': 'بطاقات', 'route': '/gift_cards'},
    {'icon': Icons.shopping_cart, 'title': 'أمازون', 'route': '/amazon_gift_cards'},
    {'icon': Icons.account_balance, 'title': 'بنوك', 'route': '/banks_wallets'},
    {'icon': Icons.send, 'title': 'تحويلات', 'route': '/money_transfers'},
    {'icon': Icons.gavel, 'title': 'حكومية', 'route': '/government_payments'},
    {'icon': Icons.school, 'title': 'جيب', 'route': '/jib'},
    {'icon': Icons.money, 'title': 'سحب نقدي', 'route': '/cash_withdrawal'},
    {'icon': Icons.cast_for_education, 'title': 'جامعات', 'route': '/universities'},
    {'icon': Icons.phone_android, 'title': 'شحن', 'route': '/recharge_payment'},
    {'icon': Icons.sim_card, 'title': 'رصيد', 'route': '/recharge_credit'},
    {'icon': Icons.wifi_tethering, 'title': 'باقات', 'route': '/pay_bundles'},
    {'icon': Icons.wifi, 'title': 'إنترنت', 'route': '/internet_landline'},
    {'icon': Icons.redeem, 'title': 'استلام', 'route': '/receive_transfer'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المحفظة'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Balance Card
            _buildBalanceCard(context),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActions(context),

            const SizedBox(height: 24),

            // Services Grid
            _buildServicesGrid(context),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.goldColor, AppTheme.goldLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.goldColor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: Colors.black, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'موثق',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '250,000',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            'ر.ي',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'إيداع',
                  Icons.add,
                  () => Navigator.pushNamed(context, '/deposit'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'سحب',
                  Icons.remove,
                  () => Navigator.pushNamed(context, '/withdraw'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  'تحويل',
                  Icons.swap_horiz,
                  () => Navigator.pushNamed(context, '/transfer'),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final quickActions = [
      {'icon': Icons.qr_code, 'label': 'مسح QR', 'onTap': () {}},
      {'icon': Icons.send, 'label': 'إرسال', 'onTap': () => Navigator.pushNamed(context, '/transfer')},
      {'icon': Icons.request_page, 'label': 'طلب', 'onTap': () {}},
      {'icon': Icons.more_horiz, 'label': 'المزيد', 'onTap': () {}},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: quickActions.map((action) {
          return GestureDetector(
            onTap: action['onTap'] as VoidCallback,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    action['icon'] as IconData,
                    color: AppTheme.goldColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(action['label'] as String),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الخدمات',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
            ),
            itemCount: _walletServices.length,
            itemBuilder: (context, index) {
              final service = _walletServices[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, service['route'] as String),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.getCardColor(context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        service['icon'] as IconData,
                        color: AppTheme.goldColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }
}
