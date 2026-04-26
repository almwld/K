import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _balance = 125000;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _transactions = [
    {'title': 'شحن رصيد', 'amount': 50000, 'date': '2024-04-20', 'type': 'deposit', 'status': 'completed'},
    {'title': 'شراء iPhone 15 Pro', 'amount': -350000, 'date': '2024-04-18', 'type': 'purchase', 'status': 'completed'},
    {'title': 'استرداد مبلغ', 'amount': 25000, 'date': '2024-04-15', 'type': 'refund', 'status': 'completed'},
    {'title': 'كاش باك', 'amount': 5000, 'date': '2024-04-05', 'type': 'cashback', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(title: const Text('المحفظة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: AppTheme.binanceDark, centerTitle: true),
      body: Column(children: [
        _buildBalanceCard(),
        _buildQuickActions(),
        _buildTabs(),
        Expanded(child: _selectedTab == 0 ? _buildTransactionsList() : _buildCardsList()),
      ]),
    );
  }

  Widget _buildBalanceCard() {
    return Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: AppTheme.goldGradient, borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الرصيد الحالي', style: TextStyle(color: Colors.black87, fontSize: 14)), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('ريال يمني', style: TextStyle(color: Colors.black, fontSize: 10)))]),
      const SizedBox(height: 8),
      Text('$_balance', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black)),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('إيداع'), style: ElevatedButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.2), foregroundColor: Colors.black))),
        const SizedBox(width: 12),
        Expanded(child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.remove), label: const Text('سحب'), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black))),
      ]),
    ]));
  }

  Widget _buildQuickActions() {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _buildActionButton(Icons.qr_code_scanner, 'مسح QR'),
      _buildActionButton(Icons.transfer_within_a_station, 'تحويل'),
      _buildActionButton(Icons.receipt, 'الفواتير'),
      _buildActionButton(Icons.history, 'السجل'),
    ]));
  }

  Widget _buildActionButton(IconData icon, String label) {
    return GestureDetector(child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: AppTheme.binanceGold, size: 24)), const SizedBox(height: 6), Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11))]));
  }

  Widget _buildTabs() {
    return Container(margin: const EdgeInsets.all(16), child: Row(children: [
      _buildTab('المعاملات', 0), const SizedBox(width: 12), _buildTab('البطاقات', 1),
    ]));
  }

  Widget _buildTab(String title, int index) {
    return Expanded(child: GestureDetector(onTap: () => setState(() => _selectedTab = index), child: Container(padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: _selectedTab == index ? AppTheme.binanceGold : AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)), child: Center(child: Text(title, style: TextStyle(color: _selectedTab == index ? Colors.black : Colors.white, fontWeight: FontWeight.bold))))));
  }

  Widget _buildTransactionsList() {
    return ListView.builder(padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _transactions.length, itemBuilder: (context, index) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.binanceCard, borderRadius: BorderRadius.circular(12)), child: Row(children: [
      Container(width: 45, height: 45, decoration: BoxDecoration(color: (_transactions[index]['amount'] > 0 ? AppTheme.binanceGreen : AppTheme.binanceRed).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(_transactions[index]['amount'] > 0 ? Icons.download : Icons.shopping_bag, color: _transactions[index]['amount'] > 0 ? AppTheme.binanceGreen : AppTheme.binanceRed)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_transactions[index]['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(_transactions[index]['date'], style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11))])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text('${_transactions[index]['amount'] > 0 ? '+' : ''}${_transactions[index]['amount'].abs()} ريال', style: TextStyle(color: _transactions[index]['amount'] > 0 ? AppTheme.binanceGreen : AppTheme.binanceRed, fontWeight: FontWeight.bold)),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.binanceGreen.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: const Text('مكتمل', style: TextStyle(color: AppTheme.binanceGreen, fontSize: 10))),
      ]),
    ])));
  }

  Widget _buildCardsList() {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.credit_card, size: 80, color: AppTheme.binanceGold.withOpacity(0.3)),
      const SizedBox(height: 16),
      const Text('لا توجد بطاقات', style: TextStyle(color: Color(0xFF9CA3AF))),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold), child: const Text('إضافة بطاقة', style: TextStyle(color: Colors.black))),
    ]));
  }
}
