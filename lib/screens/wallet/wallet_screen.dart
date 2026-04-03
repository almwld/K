import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

// استيراد جميع صفحات المحفظة
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
import 'recharge_credit_screen.dart';
import 'transfer_network_screen.dart';
import 'pay_bundles_screen.dart';
import 'wasil_transfers_screen.dart';
import 'receive_transfer_request_screen.dart';
import 'cash_withdrawal_screen.dart';
import 'games_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCarouselIndex = 0;
  
  // حالة إخفاء الرصيد لكل عملة على حدة
  Map<int, bool> _isBalanceHidden = {
    0: false,  // ريال يمني
    1: false,  // ريال سعودي
    2: false,  // دولار أمريكي
  };

  // أرصدة العملات
  final List<Map<String, dynamic>> _currencySliders = [
    {
      'title': 'الريال اليمني',
      'balance': '125,000',
      'currency': 'ر.ي',
      'code': 'YER',
      'gradient': [0xFFD4AF37, 0xFFB8860B],
      'icon': Icons.currency_exchange,
      'rate': 'السعر الأساسي',
    },
    {
      'title': 'الريال السعودي',
      'balance': '1,850',
      'currency': 'ر.س',
      'code': 'SAR',
      'gradient': [0xFF2196F3, 0xFF1976D2],
      'icon': Icons.currency_exchange,
      'rate': '1 SAR = 67.5 ر.ي',
    },
    {
      'title': 'الدولار الأمريكي',
      'balance': '495',
      'currency': 'USD',
      'code': 'USD',
      'gradient': [0xFF4CAF50, 0xFF388E3C],
      'icon': Icons.currency_exchange,
      'rate': '1 USD = 250 ر.ي',
    },
  ];

  // الخدمات الرئيسية
  final List<Map<String, dynamic>> _mainServices = [
    {'name': 'إيداع', 'icon': Icons.arrow_downward, 'color': 0xFF4CAF50, 'route': DepositScreen},
    {'name': 'سحب', 'icon': Icons.arrow_upward, 'color': 0xFFF44336, 'route': WithdrawScreen},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': 0xFF2196F3, 'route': TransferScreen},
    {'name': 'محافظ', 'icon': Icons.account_balance_wallet, 'color': 0xFF9C27B0, 'route': BanksWalletsScreen},
    {'name': 'فواتير', 'icon': Icons.receipt, 'color': 0xFFFF9800, 'route': BillPaymentScreen},
    {'name': 'بطاقات', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'route': GiftCardsScreen},
    {'name': 'إنترنت', 'icon': Icons.wifi, 'color': 0xFF00BCD4, 'route': InternetLandlineScreen},
    {'name': 'ترفيه', 'icon': Icons.movie, 'color': 0xFFF44336, 'route': EntertainmentServicesScreen},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': 0xFF1B5E20, 'route': AppsScreen},
    {'name': 'حوالات محلية', 'icon': Icons.network_cell, 'color': 0xFF795548, 'route': LocalTransferNetworksScreen},
    {'name': 'مدفوعات', 'icon': Icons.account_balance, 'color': 0xFF607D8B, 'route': GovernmentPaymentsScreen},
    {'name': 'تحويلات دولية', 'icon': Icons.public, 'color': 0xFF2196F3, 'route': MoneyTransfersScreen},
  ];

  // الإجراءات السريعة
  final List<Map<String, dynamic>> _quickActions = [
    {'name': 'شحن رصيد', 'icon': Icons.sim_card, 'color': 0xFFE31E24, 'route': RechargeCreditScreen},
    {'name': 'باقات', 'icon': Icons.data_usage, 'color': 0xFF4CAF50, 'route': PayBundlesScreen},
    {'name': 'تحويل شبكات', 'icon': Icons.phone_android, 'color': 0xFF2196F3, 'route': TransferNetworkScreen},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': 0xFF9C27B0, 'route': GamesScreen},
    {'name': 'سحب نقدي', 'icon': Icons.money, 'color': 0xFFFF9800, 'route': CashWithdrawalScreen},
    {'name': 'واصل', 'icon': Icons.swap_horiz, 'color': 0xFF4CAF50, 'route': WasilTransfersScreen},
  ];

  // آخر المعاملات
  final List<Map<String, dynamic>> _recentTransactions = [
    {'title': 'تحويل إلى جيب', 'amount': '-5,000', 'currency': 'ر.ي', 'date': 'اليوم', 'time': '10:30', 'type': 'send', 'status': 'completed'},
    {'title': 'إيداع نقدي', 'amount': '+10,000', 'currency': 'ر.ي', 'date': 'الأمس', 'time': '14:20', 'type': 'deposit', 'status': 'completed'},
    {'title': 'شراء باقة نت', 'amount': '-2,000', 'currency': 'ر.ي', 'date': '2024-04-02', 'time': '09:15', 'type': 'payment', 'status': 'completed'},
    {'title': 'استلام حوالة', 'amount': '+25,000', 'currency': 'ر.ي', 'date': '2024-04-01', 'time': '16:45', 'type': 'receive', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'محفظة فلكس'),
      body: CustomScrollView(
        slivers: [
          // 3 سلايدرات للعملات
          SliverToBoxAdapter(
            child: _buildCurrencyCarousel(),
          ),
          // الخدمات الرئيسية
          SliverToBoxAdapter(
            child: _buildMainServices(),
          ),
          // الإجراءات السريعة
          SliverToBoxAdapter(
            child: _buildQuickActions(),
          ),
          // آخر المعاملات
          SliverToBoxAdapter(
            child: _buildRecentTransactions(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildCurrencyCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
          items: _currencySliders.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isHidden = _isBalanceHidden[index] ?? false;
            
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(item['gradient'][0]), Color(item['gradient'][1])],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Color(item['gradient'][0]).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // خلفية زخرفية
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Icon(item['icon'], size: 120, color: Colors.white.withOpacity(0.1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isBalanceHidden[index] = !(_isBalanceHidden[index] ?? false);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Icon(
                                      isHidden ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  isHidden ? '●●●●●' : item['balance'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['currency'],
                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.info_outline, size: 14, color: Colors.white70),
                                const SizedBox(width: 4),
                                Text(
                                  item['rate'],
                                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _currencySliders.asMap().entries.map((entry) {
            return Container(
              width: _currentCarouselIndex == entry.key ? 24.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.goldColor
                    : Colors.grey.withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMainServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('الخدمات المالية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
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
          itemCount: _mainServices.length,
          itemBuilder: (context, index) {
            final service = _mainServices[index];
            return _buildServiceCard(service);
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(service['color']).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(service['icon'], color: Color(service['color']), size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              service['name'],
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('إجراءات سريعة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _quickActions.length,
            itemBuilder: (context, index) {
              final action = _quickActions[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => action['route']()),
                  );
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(action['color']).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(action['icon'], color: Color(action['color']), size: 22),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        action['name'],
                        style: const TextStyle(fontSize: 10),
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
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('آخر المعاملات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TransactionsScreen()),
                  );
                },
                child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor)),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentTransactions.length,
          itemBuilder: (context, index) {
            final transaction = _recentTransactions[index];
            final isPositive = transaction['amount'].startsWith('+');
            final amountColor = isPositive ? Colors.green : Colors.red;
            final iconData = transaction['type'] == 'send' ? Icons.send :
                             transaction['type'] == 'deposit' ? Icons.arrow_downward :
                             transaction['type'] == 'payment' ? Icons.shopping_cart : Icons.download;
            final iconBg = transaction['type'] == 'send' ? Colors.blue.withOpacity(0.1) :
                           transaction['type'] == 'deposit' ? Colors.green.withOpacity(0.1) :
                           transaction['type'] == 'payment' ? Colors.orange.withOpacity(0.1) : Colors.purple.withOpacity(0.1);
            final iconColor = transaction['type'] == 'send' ? Colors.blue :
                              transaction['type'] == 'deposit' ? Colors.green :
                              transaction['type'] == 'payment' ? Colors.orange : Colors.purple;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${transaction['date']} • ${transaction['time']}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text(
                    '${transaction['amount']} ${transaction['currency']}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: amountColor),
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
