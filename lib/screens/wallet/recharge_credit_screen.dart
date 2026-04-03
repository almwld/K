import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class RechargeCreditScreen extends StatefulWidget {
  const RechargeCreditScreen({super.key});

  @override
  State<RechargeCreditScreen> createState() => _RechargeCreditScreenState();
}

class _RechargeCreditScreenState extends State<RechargeCreditScreen> {
  String _selectedProvider = '';
  String _selectedAmount = '';
  String _selectedWallet = 'flexpay';
  final TextEditingController _phoneController = TextEditingController();

  final List<Map<String, dynamic>> _providers = [
    {'name': 'يمن موبايل', 'code': 'YMobile', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'name': 'YOU', 'code': 'YOU', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'MTN', 'code': 'MTN', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'سبأفون', 'code': 'SabaFon', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
  ];

  final List<Map<String, dynamic>> _amounts = [
    {'value': '500', 'price': '500', 'bonus': '0'},
    {'value': '1000', 'price': '1000', 'bonus': '50'},
    {'value': '2000', 'price': '2000', 'bonus': '150'},
    {'value': '5000', 'price': '5000', 'bonus': '500'},
    {'value': '10000', 'price': '10000', 'bonus': '1200'},
    {'value': '20000', 'price': '20000', 'bonus': '3000'},
  ];

  final List<Map<String, dynamic>> _wallets = [
    {'id': 'flexpay', 'name': 'فلكس باي', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': AppTheme.goldColor},
    {'id': 'jaib', 'name': 'جيب', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37},
    {'id': 'wasel', 'name': 'واصل', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedAmount = _amounts.firstWhere((a) => a['value'] == _selectedAmount, orElse: () => {});
    final amount = selectedAmount.isNotEmpty ? int.parse(selectedAmount['price']) : 0;
    final bonus = selectedAmount.isNotEmpty ? int.parse(selectedAmount['bonus']) : 0;
    final total = amount + bonus;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شحن رصيد الجوال'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProvidersGrid(),
            const SizedBox(height: 24),
            if (_selectedProvider.isNotEmpty) _buildAmountsGrid(),
            const SizedBox(height: 24),
            if (_selectedProvider.isNotEmpty && _selectedAmount.isNotEmpty) _buildWalletSelector(),
            const SizedBox(height: 24),
            if (_selectedProvider.isNotEmpty && _selectedAmount.isNotEmpty && _selectedWallet.isNotEmpty) _buildPaymentForm(amount, bonus, total),
          ],
        ),
      ),
    );
  }

  Widget _buildProvidersGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر شركة الاتصالات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _providers.length,
          itemBuilder: (context, index) {
            final provider = _providers[index];
            final isSelected = _selectedProvider == provider['code'];
            return GestureDetector(
              onTap: () => setState(() {
                _selectedProvider = provider['code'];
                _selectedAmount = '';
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: provider['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(Icons.sim_card, size: 40, color: Color(provider['color'])),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(provider['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAmountsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المبلغ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _amounts.length,
          itemBuilder: (context, index) {
            final amountItem = _amounts[index];
            final isSelected = _selectedAmount == amountItem['value'];
            return GestureDetector(
              onTap: () => setState(() => _selectedAmount = amountItem['value']),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${amountItem['value']} ر.ي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isSelected ? AppTheme.goldColor : null)),
                    const SizedBox(height: 4),
                    if (int.parse(amountItem['bonus']) > 0)
                      Text('+${amountItem['bonus']} بونص', style: TextStyle(fontSize: 10, color: Colors.green)),
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
        const Text('طريقة الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _wallets.length,
          itemBuilder: (context, index) {
            final wallet = _wallets[index];
            final isSelected = _selectedWallet == wallet['id'];
            return GestureDetector(
              onTap: () => setState(() => _selectedWallet = wallet['id']),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: wallet['image'],
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(Icons.account_balance_wallet, size: 30, color: Color(wallet['color'])),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(wallet['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaymentForm(int amount, int bonus, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الشحن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'رقم الجوال المراد شحنه',
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.goldColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('قيمة الشحن:'), Text('$amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
              if (bonus > 0) ...[
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('البونص:'), Text('+$bonus ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]),
              ],
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('الإجمالي المطلوب:'), Text('$total ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor))]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_phoneController.text.isNotEmpty) ? () => _processRecharge(amount, bonus, total) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تأكيد الشحن', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processRecharge(int amount, int bonus, int total) {
    final provider = _providers.firstWhere((p) => p['code'] == _selectedProvider);
    final wallet = _wallets.firstWhere((w) => w['id'] == _selectedWallet);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشحن'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.sim_card, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('شحن رصيد ${provider['name']}'),
            Text('رقم الجوال: ${_phoneController.text}'),
            Text('المبلغ: $amount ر.ي'),
            if (bonus > 0) Text('البونص: +$bonus ر.ي'),
            Text('الدفع عبر: ${wallet['name']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(amount, bonus);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(int amount, int bonus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشحن بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شحن $amount ر.ي بنجاح'),
            if (bonus > 0) Text('+$bonus ر.ي بونص'),
            const Text('سيتم إضافة الرصيد خلال دقائق'),
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
