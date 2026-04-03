import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class BanksWalletsScreen extends StatefulWidget {
  const BanksWalletsScreen({super.key});

  @override
  State<BanksWalletsScreen> createState() => _BanksWalletsScreenState();
}

class _BanksWalletsScreenState extends State<BanksWalletsScreen> {
  String _selectedTab = 'banks';
  
  final List<Map<String, dynamic>> _banks = [
    {'name': 'البنك المركزي اليمني', 'code': 'CBY', 'icon': Icons.account_balance, 'color': 0xFF1B5E20, 'transfer_fee': '0', 'time': 'فوري'},
    {'name': 'بنك اليمن الدولي', 'code': 'YIB', 'icon': Icons.account_balance, 'color': 0xFF0D47A1, 'transfer_fee': '500', 'time': 'خلال 24 ساعة'},
    {'name': 'بنك التسليف', 'code': 'CBL', 'icon': Icons.account_balance, 'color': 0xFFE65100, 'transfer_fee': '300', 'time': 'خلال 24 ساعة'},
    {'name': 'بنك الكريمي', 'code': 'KIB', 'icon': Icons.account_balance, 'color': 0xFF4A148C, 'transfer_fee': '400', 'time': 'خلال 12 ساعة'},
    {'name': 'بنك التضامن', 'code': 'TSB', 'icon': Icons.account_balance, 'color': 0xFF004D40, 'transfer_fee': '350', 'time': 'خلال 24 ساعة'},
    {'name': 'بنك عدن', 'code': 'AIB', 'icon': Icons.account_balance, 'color': 0xFFB71C1C, 'transfer_fee': '450', 'time': 'خلال 12 ساعة'},
    {'name': 'بنك الأمل', 'code': 'Aml', 'icon': Icons.account_balance, 'color': 0xFF2196F3, 'transfer_fee': '400', 'time': 'خلال 24 ساعة'},
    {'name': 'بنك الوطني', 'code': 'NWB', 'icon': Icons.account_balance, 'color': 0xFF4CAF50, 'transfer_fee': '350', 'time': 'خلال 24 ساعة'},
  ];

  final List<Map<String, dynamic>> _wallets = [
    // المحافظ الرئيسية
    {'name': 'موبايل موني', 'code': 'MobileMoney', 'icon': Icons.phone_android, 'color': 0xFFE31E24, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'كاش', 'code': 'Cash', 'icon': Icons.money, 'color': 0xFF4CAF50, 'transfer_fee': '150', 'time': 'فوري'},
    {'name': 'سيا كاش', 'code': 'SiaCash', 'icon': Icons.account_balance_wallet, 'color': 0xFF2196F3, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'سبأ كاش', 'code': 'SabaCash', 'icon': Icons.account_balance_wallet, 'color': 0xFFFF9800, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'فلومك', 'code': 'Floosok', 'icon': Icons.account_balance_wallet, 'color': 0xFF9C27B0, 'transfer_fee': '150', 'time': 'فوري'},
    {'name': 'فلوسك', 'code': 'Floosk', 'icon': Icons.account_balance_wallet, 'color': 0xFFE91E63, 'transfer_fee': '150', 'time': 'فوري'},
    {'name': 'المتكاملة mPay', 'code': 'mPay', 'icon': Icons.account_balance_wallet, 'color': 0xFF1B5E20, 'transfer_fee': '100', 'time': 'فوري'},
    {'name': 'جوالي', 'code': 'Jawali', 'icon': Icons.phone_android, 'color': 0xFF0D47A1, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'ون كاش', 'code': 'OneCash', 'icon': Icons.account_balance_wallet, 'color': 0xFFE65100, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'شامل موني', 'code': 'ShamelMoney', 'icon': Icons.account_balance_wallet, 'color': 0xFF4A148C, 'transfer_fee': '150', 'time': 'فوري'},
    {'name': 'إيزي', 'code': 'Easy', 'icon': Icons.account_balance_wallet, 'color': 0xFF4CAF50, 'transfer_fee': '100', 'time': 'فوري'},
    {'name': 'يمن وانت', 'code': 'YemenWant', 'icon': Icons.account_balance_wallet, 'color': 0xFFFF9800, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'يمن والت', 'code': 'YemenWallet', 'icon': Icons.account_balance_wallet, 'color': 0xFF2196F3, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'واصل', 'code': 'Wasel', 'icon': Icons.swap_horiz, 'color': 0xFF4CAF50, 'transfer_fee': '250', 'time': 'فوري'},
    {'name': 'جيب', 'code': 'Jaib', 'icon': Icons.account_balance_wallet, 'color': 0xFFD4AF37, 'transfer_fee': '100', 'time': 'فوري'},
    {'name': 'ياه موني', 'code': 'YahMoney', 'icon': Icons.account_balance_wallet, 'color': 0xFFE91E63, 'transfer_fee': '200', 'time': 'فوري'},
    {'name': 'W', 'code': 'W', 'icon': Icons.account_balance_wallet, 'color': 0xFF9C27B0, 'transfer_fee': '150', 'time': 'فوري'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'البنوك والمحافظ'),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: _selectedTab == 'banks'
                ? ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _banks.length,
                    itemBuilder: (context, index) => _buildBankCard(_banks[index]),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _wallets.length,
                    itemBuilder: (context, index) => _buildWalletCard(_wallets[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 'banks'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 'banks' ? AppTheme.goldColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('الحسابات البنكية', textAlign: TextAlign.center,
                  style: TextStyle(color: _selectedTab == 'banks' ? Colors.white : null, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 'wallets'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 'wallets' ? AppTheme.goldColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('المحافظ الإلكترونية', textAlign: TextAlign.center,
                  style: TextStyle(color: _selectedTab == 'wallets' ? Colors.white : null, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankCard(Map<String, dynamic> bank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: Color(bank['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(bank['icon'], color: Color(bank['color']), size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bank['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('رمز البنك: ${bank['code']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => _showTransferDialog(bank, 'bank'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
                child: const Text('تحويل', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [const Icon(Icons.receipt, size: 16, color: Colors.grey), Text('رسوم التحويل', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  Text('${bank['transfer_fee']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
                Column(children: [const Icon(Icons.timer, size: 16, color: Colors.grey), Text('مدة التحويل', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  Text(bank['time'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard(Map<String, dynamic> wallet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: Color(wallet['color']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(wallet['icon'], color: Color(wallet['color']), size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wallet['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('رمز المحفظة: ${wallet['code']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text('رسوم التحويل: ${wallet['transfer_fee']} ر.ي', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _showTransferDialog(wallet, 'wallet'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تحويل', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _showTransferDialog(Map<String, dynamic> item, String type) {
    final TextEditingController _amountController = TextEditingController();
    final TextEditingController _accountController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('تحويل إلى ${item['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _accountController,
              decoration: InputDecoration(
                labelText: type == 'bank' ? 'رقم الحساب البنكي' : 'رقم المحفظة',
                prefixIcon: const Icon(Icons.account_balance),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'المبلغ',
                prefixIcon: const Icon(Icons.attach_money),
                suffixText: 'ر.ي',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('رسوم التحويل:'),
                  Text('${item['transfer_fee']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(item, _amountController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد التحويل'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> item, String amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم التحويل بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تحويل $amount ر.ي إلى ${item['name']}'),
            Text('رسوم التحويل: ${item['transfer_fee']} ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
