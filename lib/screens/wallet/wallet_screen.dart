import "package:flutter/material.dart";
import "package:cached_network_image/cached_network_image.dart";
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  int _balance = 125000; // الرصيد الحالي
  int _selectedTab = 0; // 0: المعاملات, 1: البطاقات
  
  final List<Map<String, dynamic>> _transactions = [
    {'id': '1', 'title': 'شحن رصيد', 'amount': 50000, 'date': '2024-04-20', 'type': 'deposit', 'status': 'completed', 'paymentMethod': 'بطاقة ائتمان'},
    {'id': '2', 'title': 'شراء iPhone 15 Pro', 'amount': -350000, 'date': '2024-04-18', 'type': 'purchase', 'status': 'completed', 'store': 'متجر التقنية'},
    {'id': '3', 'title': 'استرداد مبلغ', 'amount': 25000, 'date': '2024-04-15', 'type': 'refund', 'status': 'completed', 'order': 'ORD-001'},
    {'id': '4', 'title': 'دفع فاتورة', 'amount': -15000, 'date': '2024-04-14', 'type': 'bill', 'status': 'completed', 'service': 'كهرباء'},
    {'id': '5', 'title': 'شحن رصيد', 'amount': 100000, 'date': '2024-04-10', 'type': 'deposit', 'status': 'completed', 'paymentMethod': 'محفظة جوال'},
    {'id': '6', 'title': 'شراء ساعة أبل', 'amount': -45000, 'date': '2024-04-08', 'type': 'purchase', 'status': 'completed', 'store': 'متجر التقنية'},
    {'id': '7', 'title': 'كاش باك', 'amount': 5000, 'date': '2024-04-05', 'type': 'cashback', 'status': 'completed'},
  ];

  final List<Map<String, dynamic>> _cards = [
    {'id': '1', 'name': 'بطاقة فيزا', 'number': '**** **** **** 1234', 'expiry': '12/26', 'type': 'visa', 'color': const Color(0xFF1E2329), 'isDefault': true},
    {'id': '2', 'name': 'بطاقة ماستركارد', 'number': '**** **** **** 5678', 'expiry': '08/27', 'type': 'mastercard', 'color': const Color(0xFF1E2329), 'isDefault': false},
  ];

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'color': AppTheme.binanceGold},
    {'name': 'محفظة جوال', 'icon': Icons.phone_android, 'color': AppTheme.binanceGreen},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'color': AppTheme.serviceBlue},
    {'name': 'كاش يو', 'icon': Icons.wallet, 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        backgroundColor: AppTheme.binanceDark,
        elevation: 0,
        title: const Text('المحفظة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.more_horiz, color: AppTheme.binanceGold), onPressed: () {}),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildBalanceCard()),
          SliverToBoxAdapter(child: _buildQuickActions()),
          SliverToBoxAdapter(child: _buildTabs()),
          SliverToBoxAdapter(child: _buildTabContent()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD4AF37), Color(0xFFB8962E), Color(0xFFF4E4A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: AppTheme.binanceGold.withOpacity(0.3), blurRadius: 15, spreadRadius: 2)],
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('الرصيد الحالي', style: TextStyle(color: Colors.black87, fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                        child: const Text('ريال يمني', style: TextStyle(color: Colors.black, fontSize: 10)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$_balance',
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      const Text('ريال', style: TextStyle(fontSize: 16, color: Colors.black87)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showDepositDialog(),
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('إيداع'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black.withOpacity(0.2),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showWithdrawDialog(),
                          icon: const Icon(Icons.remove, size: 18),
                          label: const Text('سحب'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(Icons.qr_code_scanner, 'مسح QR', () {}),
            _buildActionButton(Icons.transfer_within_a_station, 'تحويل', () {}),
            _buildActionButton(Icons.receipt, 'الفواتير', () {}),
            _buildActionButton(Icons.history, 'السجل', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.binanceCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppTheme.binanceGold, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildTab('المعاملات', _selectedTab == 0, 0),
          const SizedBox(width: 12),
          _buildTab('البطاقات', _selectedTab == 1, 1),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.binanceGold : AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return _selectedTab == 0 ? _buildTransactionsList() : _buildCardsList();
  }

  Widget _buildTransactionsList() {
    if (_transactions.isEmpty) {
      return const Center(child: Text('لا توجد معاملات', style: TextStyle(color: Color(0xFF9CA3AF))));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) => _buildTransactionCard(_transactions[index]),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isPositive = transaction['amount'] > 0;
    final amount = transaction['amount'].abs();
    final icon = _getTransactionIcon(transaction['type'] as String);
    final color = _getTransactionColor(transaction['type'] as String);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(transaction['date'] as String, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
                if (transaction['store'] != null)
                  Text(transaction['store'] as String, style: const TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isPositive ? '+' : '-'} $amount ريال',
                style: TextStyle(
                  color: isPositive ? AppTheme.binanceGreen : AppTheme.binanceRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.binanceGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('مكتمل', style: TextStyle(color: AppTheme.binanceGreen, fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'deposit': return Icons.download;
      case 'purchase': return Icons.shopping_bag;
      case 'refund': return Icons.refresh;
      case 'bill': return Icons.receipt;
      case 'cashback': return Icons.card_giftcard;
      default: return Icons.history;
    }
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'deposit': return AppTheme.binanceGreen;
      case 'purchase': return AppTheme.binanceGold;
      case 'refund': return AppTheme.serviceBlue;
      case 'bill': return Colors.orange;
      case 'cashback': return AppTheme.binanceGold;
      default: return AppTheme.binanceRed;
    }
  }

  Widget _buildCardsList() {
    return Column(
      children: [
        ..._cards.map((card) => _buildCardItem(card)).toList(),
        const SizedBox(height: 12),
        _buildAddCardButton(),
      ],
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: card['type'] == 'visa' 
              ? [const Color(0xFF1A2A44), const Color(0xFF1E2329)]
              : [const Color(0xFF2A1A44), const Color(0xFF1E2329)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.binanceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card['name'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              SvgPicture.asset(
                card['type'] == 'visa' ? 'assets/icons/svg/visa.svg' : 'assets/icons/svg/mastercard.svg',
                width: 40,
                height: 30,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(card['number'] as String, style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('صالح حتى ${card['expiry']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              if (card['isDefault'] as bool)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppTheme.binanceGold.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: const Text('الافتراضية', style: TextStyle(color: AppTheme.binanceGold, fontSize: 10)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardButton() {
    return GestureDetector(
      onTap: () => _showAddCardDialog(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.binanceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.binanceBorder, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: AppTheme.binanceGold),
            const SizedBox(width: 8),
            const Text('إضافة بطاقة جديدة', style: TextStyle(color: AppTheme.binanceGold)),
          ],
        ),
      ),
    );
  }

  void _showDepositDialog() {
    _showPaymentDialog('إيداع', 'إضافة رصيد');
  }

  void _showWithdrawDialog() {
    _showPaymentDialog('سحب', 'سحب رصيد');
  }

  void _showPaymentDialog(String title, String action) {
    final amountController = TextEditingController();
    int selectedMethod = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.binanceBorder,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'المبلغ بالريال',
                        hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                        prefixIcon: Icon(Icons.money, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: AppTheme.binanceDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('طريقة الدفع', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...List.generate(_paymentMethods.length, (i) {
                      final method = _paymentMethods[i];
                      return GestureDetector(
                        onTap: () => setState(() => selectedMethod = i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.binanceDark,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: selectedMethod == i ? AppTheme.binanceGold : AppTheme.binanceBorder),
                          ),
                          child: Row(
                            children: [
                              Icon(method['icon'] as IconData, color: method['color'] as Color),
                              const SizedBox(width: 12),
                              Expanded(child: Text(method['name'] as String, style: const TextStyle(color: Colors.white))),
                              if (selectedMethod == i)
                                const Icon(Icons.check_circle, color: AppTheme.binanceGold),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final amount = int.tryParse(amountController.text);
                          if (amount != null && amount > 0) {
                            setState(() {
                              if (title == 'إيداع') {
                                _balance += amount;
                              } else {
                                if (_balance >= amount) {
                                  _balance -= amount;
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('الرصيد غير كافٍ'), backgroundColor: AppTheme.binanceRed),
                                  );
                                  return;
                                }
                              }
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('تم ${title == 'إيداع' ? 'إيداع' : 'سحب'} $amount ريال بنجاح'), backgroundColor: AppTheme.binanceGreen),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.binanceGold,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(action, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddCardDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.binanceCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.binanceBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text('إضافة بطاقة جديدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'رقم البطاقة',
                  hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                  filled: true,
                  fillColor: AppTheme.binanceDark,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'تاريخ الانتهاء (MM/YY)',
                        hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                        filled: true,
                        fillColor: AppTheme.binanceDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'CVV',
                        hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                        filled: true,
                        fillColor: AppTheme.binanceDark,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.binanceGold,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('إضافة البطاقة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
