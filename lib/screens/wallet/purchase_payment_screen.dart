import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PurchasePaymentScreen extends StatefulWidget {
  const PurchasePaymentScreen({super.key});

  @override
  State<PurchasePaymentScreen> createState() => _PurchasePaymentScreenState();
}

class _PurchasePaymentScreenState extends State<PurchasePaymentScreen> {
  String _selectedMethod = 'flexpay';
  String _selectedWallet = '';
  String _selectedNetwork = '';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _posNumberController = TextEditingController();

  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'flexpay', 'name': 'فلكس باي', 'icon': Icons.account_balance_wallet, 'color': AppTheme.goldColor, 'fee': '0', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x'},
    {'id': 'jaib', 'name': 'جيب', 'icon': Icons.account_balance_wallet, 'color': 0xFFD4AF37, 'fee': '0', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x'},
    {'id': 'other', 'name': 'محافظ أخرى', 'icon': Icons.account_balance_wallet, 'color': 0xFF4CAF50, 'fee': '0', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x'},
    {'id': 'wint', 'name': 'Wint', 'icon': Icons.account_balance_wallet, 'color': 0xFF2196F3, 'fee': '0', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x'},
  ];

  final List<Map<String, dynamic>> _wallets = [
    {'name': 'موبايل موني', 'code': 'MobileMoney', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'name': 'كاش', 'code': 'Cash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'سيا كاش', 'code': 'SiaCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
    {'name': 'سبأ كاش', 'code': 'SabaCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'فلومك', 'code': 'Floosok', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0},
    {'name': 'المتكاملة mPay', 'code': 'mPay', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20},
    {'name': 'جوالي', 'code': 'Jawali', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF0D47A1},
    {'name': 'ون كاش', 'code': 'OneCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE65100},
    {'name': 'شامل موني', 'code': 'ShamelMoney', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4A148C},
    {'name': 'إيزي', 'code': 'Easy', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'يمن وانت', 'code': 'YemenWant', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'واصل', 'code': 'Wasel', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'جيب', 'code': 'Jaib', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37},
  ];

  final List<Map<String, dynamic>> _networks = [
    {'name': 'شبكة حزمي', 'code': 'Hazmi', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
    {'name': 'شبكة النجم', 'code': 'AlNajm', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'شبكة البرق', 'code': 'AlBarq', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'شبكة المميز', 'code': 'AlMomayaz', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedMethod = _paymentMethods.firstWhere((m) => m['id'] == _selectedMethod);
    final amount = int.tryParse(_amountController.text) ?? 0;
    final fee = int.parse(selectedMethod['fee']);
    final total = amount + fee;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'دفع المشتريات'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPaymentMethods(),
            const SizedBox(height: 24),
            if (_selectedMethod == 'other') _buildWalletSelector(),
            if (_selectedMethod == 'wint') _buildNetworkSelector(),
            const SizedBox(height: 16),
            _buildPaymentForm(selectedMethod, amount, fee, total),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('طريقة الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _paymentMethods.length,
          itemBuilder: (context, index) {
            final method = _paymentMethods[index];
            final isSelected = _selectedMethod == method['id'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMethod = method['id'];
                  _selectedWallet = '';
                  _selectedNetwork = '';
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: method['image'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(method['icon'], color: Color(method['color']), size: 30),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(method['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                          Text('رسوم: ${method['fee']} ر.ي', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                    if (isSelected) const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWalletSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المحفظة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedWallet.isEmpty ? null : _selectedWallet,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          hint: const Text('اختر المحفظة'),
          items: _wallets.map((wallet) {
            return DropdownMenuItem<String>(
              value: wallet['code'],
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: wallet['image'],
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(Icons.account_balance_wallet, size: 20, color: Color(wallet['color'])),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(wallet['name']),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedWallet = value!),
        ),
      ],
    );
  }

  Widget _buildNetworkSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر الشبكة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedNetwork.isEmpty ? null : _selectedNetwork,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          hint: const Text('اختر الشبكة'),
          items: _networks.map((network) {
            return DropdownMenuItem<String>(
              value: network['code'],
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: network['image'],
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(Icons.network_cell, size: 20, color: Color(network['color'])),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(network['name']),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedNetwork = value!),
        ),
      ],
    );
  }

  Widget _buildPaymentForm(Map<String, dynamic> method, int amount, int fee, int total) {
    bool isWalletSelected = _selectedMethod != 'other' || (_selectedMethod == 'other' && _selectedWallet.isNotEmpty);
    bool isNetworkSelected = _selectedMethod != 'wint' || (_selectedMethod == 'wint' && _selectedNetwork.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _posNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'رقم نقطة البيع (POS)',
            prefixIcon: const Icon(Icons.point_of_sale),
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
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _noteController,
          decoration: InputDecoration(
            labelText: 'ملاحظات (اختياري)',
            prefixIcon: const Icon(Icons.note),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.goldColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('المبلغ:'), Text('$amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('رسوم الدفع (${method['fee']} ر.ي):'), Text('$fee ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))]),
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$total ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor))]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_posNumberController.text.isNotEmpty && amount > 0 && isWalletSelected && isNetworkSelected)
                ? () => _processPayment(method, amount, fee, total)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تأكيد الدفع', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processPayment(Map<String, dynamic> method, int amount, int fee, int total) {
    String paymentVia = method['name'];
    if (_selectedMethod == 'other' && _selectedWallet.isNotEmpty) {
      final wallet = _wallets.firstWhere((w) => w['code'] == _selectedWallet);
      paymentVia = wallet['name'];
    }
    if (_selectedMethod == 'wint' && _selectedNetwork.isNotEmpty) {
      final network = _networks.firstWhere((n) => n['code'] == _selectedNetwork);
      paymentVia = network['name'];
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الدفع'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.payment, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('دفع مشتريات بقيمة $amount ر.ي'),
            Text('عبر: $paymentVia'),
            Text('رسوم: $fee ر.ي'),
            Text('الإجمالي: $total ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(method, amount, paymentVia);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> method, int amount, String paymentVia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الدفع بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم دفع $amount ر.ي بنجاح'),
            Text('عبر: $paymentVia'),
            const SizedBox(height: 8),
            Text('رقم العملية: ${DateTime.now().millisecondsSinceEpoch}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
