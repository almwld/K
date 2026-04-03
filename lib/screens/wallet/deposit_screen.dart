import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import 'banks_wallets_screen.dart';
import 'gift_cards_screen.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  final List<Map<String, dynamic>> _depositMethods = const [
    {'id': 'bank', 'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'color': 0xFF1B5E20, 'route': BanksWalletsScreen'},
    {'id': 'wallet', 'name': 'محفظة إلكترونية', 'icon': Icons.account_balance_wallet, 'color': 0xFFD4AF37, 'route': BanksWalletsScreen},
    {'id': 'card', 'name': 'بطاقة هدايا', 'icon': Icons.card_giftcard, 'color': 0xFFE91E63, 'route': GiftCardsScreen},
    {'id': 'cash', 'name': 'إيداع نقدي', 'icon': Icons.money, 'color': 0xFF4CAF50, 'route': null},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إيداع'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'اختر طريقة الإيداع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._depositMethods.map((method) => _buildDepositMethod(method, context)),
            const SizedBox(height: 24),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDepositMethod(Map<String, dynamic> method, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () {
          if (method['route'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => method['route']()),
            );
          } else {
            _showCashDepositDialog(context);
          }
        },
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(method['color']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(method['icon'], color: Color(method['color']), size: 28),
        ),
        title: Text(method['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: AppTheme.getCardColor(context),
      ),
    );
  }

  void _showCashDepositDialog(BuildContext context) {
    final TextEditingController _amountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('إيداع نقدي'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.money, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            const Text('يمكنك الإيداع النقدي من خلال:'),
            const SizedBox(height: 8),
            const Text('• فروع فلكس يمن'),
            const Text('• وكلاء فلكس يمن'),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'المبلغ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixText: 'ر.ي',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (_amountController.text.isNotEmpty) {
                Navigator.pop(context);
                _showRequestDialog(context, _amountController.text);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تقديم طلب'),
          ),
        ],
      ),
    );
  }

  void _showRequestDialog(BuildContext context, String amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم تقديم الطلب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تقديم طلب إيداع بقيمة $amount ر.ي'),
            const SizedBox(height: 8),
            const Text('سيتم التواصل معك لتأكيد العملية'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.goldColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'معلومات الإيداع',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '• الحد الأدنى للإيداع 1000 ر.ي',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '• الإيداع متاح 24/7',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '• العمولة 0% على الإيداع',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
