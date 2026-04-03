import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'deposit_screen.dart';
import 'withdraw_screen.dart';
import 'transfer_screen.dart';
import 'transactions_screen.dart';
import 'banks_wallets_screen.dart';
import 'recharge_credit_screen.dart';
import 'government_payments_screen.dart';
import 'gift_cards_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCurrencyIndex = 0;
  bool _hideBalance = false;
  
  // بيانات العملات
  final List<Map<String, dynamic>> _currencies = [
    {
      'name': 'ريال يمني',
      'code': 'YER',
      'symbol': 'ر.ي',
      'balance': 125000.00,
      'color': 0xFF2E7D32,
    },
    {
      'name': 'ريال سعودي',
      'code': 'SAR',
      'symbol': 'ر.س',
      'balance': 500.00,
      'color': 0xFF1B5E20,
    },
    {
      'name': 'دولار أمريكي',
      'code': 'USD',
      'symbol': '\$',
      'balance': 100.00,
      'color': 0xFF0D47A1,
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {'icon': Icons.compare_arrows, 'name': 'تحويل', 'screen': const TransferScreen()},
    {'icon': Icons.history, 'name': 'المعاملات', 'screen': const TransactionsScreen()},
    {'icon': Icons.qr_code_scanner, 'name': 'مسح QR', 'screen': null},
    {'icon': Icons.account_balance_wallet, 'name': 'البنوك', 'screen': const BanksWalletsScreen()},
  ];

  final List<Map<String, dynamic>> _services = [
    {'icon': Icons.sim_card, 'name': 'شحن رصيد', 'screen': const RechargeCreditScreen()},
    {'icon': Icons.receipt, 'name': 'فواتير', 'screen': const GovernmentPaymentsScreen()},
    {'icon': Icons.card_giftcard, 'name': 'بطاقات هدايا', 'screen': const GiftCardsScreen()},
    {'icon': Icons.school, 'name': 'جامعات', 'screen': null},
    {'icon': Icons.sports_esports, 'name': 'ألعاب', 'screen': null},
    {'icon': Icons.apps, 'name': 'تطبيقات', 'screen': null},
  ];

  final List<Map<String, dynamic>> _recentTransactions = [
    {'name': 'شحن رصيد', 'amount': '+5,000', 'currency': 'YER', 'date': 'اليوم', 'isPositive': true},
    {'name': 'دفع فاتورة كهرباء', 'amount': '-2,500', 'currency': 'YER', 'date': 'أمس', 'isPositive': false},
    {'name': 'تحويل إلى أحمد', 'amount': '-50', 'currency': 'SAR', 'date': 'أمس', 'isPositive': false},
    {'name': 'استلام من محمد', 'amount': '+20', 'currency': 'USD', 'date': 'قبل يومين', 'isPositive': true},
  ];

  String _getCurrencySymbol(String code) {
    switch (code) {
      case 'YER': return 'ر.ي';
      case 'SAR': return 'ر.س';
      case 'USD': return '\$';
      default: return '';
    }
  }

  String _formatBalance(double balance, String code) {
    if (_hideBalance) {
      return '••••••';
    }
    final formatter = NumberFormat('#,###.##');
    return '${formatter.format(balance)} ${_getCurrencySymbol(code)}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentCurrency = _currencies[_currentCurrencyIndex];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: 'محفظتي',
        actions: [
          IconButton(
            icon: Icon(
              _hideBalance ? Icons.visibility_off : Icons.visibility,
              color: AppTheme.goldColor,
            ),
            onPressed: () {
              setState(() {
                _hideBalance = !_hideBalance;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildCurrencySlider(),
            const SizedBox(height: 16),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildServicesSection(),
            const SizedBox(height: 24),
            _buildRecentTransactions(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCurrencyIndex = index;
              });
            },
          ),
          items: _currencies.map((currency) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(currency['color']),
                        Color(currency['color']).withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(currency['color']).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currency['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currency['code'],
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  currency['code'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الرصيد المتاح',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatBalance(currency['balance'], currency['code']),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const DepositScreen()),
                                    );
                                  },
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('إيداع'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Color(currency['color']),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const WithdrawScreen()),
                                    );
                                  },
                                  icon: const Icon(Icons.remove, size: 18),
                                  label: const Text('سحب'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(color: Colors.white),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _currencies.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentCurrencyIndex == entry.key
                    ? AppTheme.goldColor
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _quickActions.map((action) {
          return GestureDetector(
            onTap: () {
              if (action['screen'] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => action['screen']));
              }
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.goldColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(action['icon'], color: AppTheme.goldColor, size: 24),
                ),
                const SizedBox(height: 8),
                Text(action['name'], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('الخدمات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            return GestureDetector(
              onTap: () {
                if (service['screen'] != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => service['screen']));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'], color: AppTheme.goldColor, size: 28),
                    const SizedBox(height: 8),
                    Text(service['name'], style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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
              const Text('أحدث المعاملات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        ..._recentTransactions.map((transaction) => ListTile(
          leading: CircleAvatar(
            backgroundColor: transaction['isPositive'] ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
            child: Icon(
              transaction['isPositive'] ? Icons.arrow_upward : Icons.arrow_downward,
              color: transaction['isPositive'] ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          title: Text(transaction['name']),
          subtitle: Text(transaction['date']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: TextStyle(
                  color: transaction['isPositive'] ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                transaction['currency'],
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
