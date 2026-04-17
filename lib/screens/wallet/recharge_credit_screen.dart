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
  String _selectedOperator = 'ymobile';
  String _selectedAmount = '';
  final TextEditingController _phoneController = TextEditingController();

  // شبكات الجوال المحدثة
  final List<Map<String, dynamic>> _operators = [
    {'id': 'ymobile', 'name': 'يمن موبايل', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'id': 'you', 'name': 'YOU', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'id': 'sabafon', 'name': 'سبأفون', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
    {'id': 'way', 'name': 'واي', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0},
  ];

  final List<Map<String, dynamic>> _amounts = [
    {'value': '500', 'price': '500', 'bonus': '0'},
    {'value': '1000', 'price': '1000', 'bonus': '50'},
    {'value': '2000', 'price': '2000', 'bonus': '150'},
    {'value': '5000', 'price': '5000', 'bonus': '500'},
    {'value': '10000', 'price': '10000', 'bonus': '1200'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedAmount = _amounts.firstWhere((a) => a['value'] == _selectedAmount, orElse: () => {});

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شحن رصيد'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOperatorsGrid(),
            const SizedBox(height: 24),
            _buildAmountsGrid(),
            const SizedBox(height: 16),
            _buildPhoneInput(),
            const SizedBox(height: 24),
            if (_selectedAmount.isNotEmpty) _buildPaymentButton(selectedAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المشغل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _operators.length,
          itemBuilder: (context, index) {
            final operator = _operators[index];
            final isSelected = _selectedOperator == operator['id'];
            return GestureDetector(
              onTap: () => setState(() => _selectedOperator = operator['id']),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldAccent.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldAccent : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(30), child: CachedNetworkImage(imageUrl: operator['image'], width: 50, height: 50, fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(Icons.sim_card, color: Color(operator['color']), size: 40))),
                    const SizedBox(height: 8),
                    Text(operator['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _amounts.length,
          itemBuilder: (context, index) {
            final amount = _amounts[index];
            final isSelected = _selectedAmount == amount['value'];
            return GestureDetector(
              onTap: () => setState(() => _selectedAmount = amount['value']),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldAccent.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldAccent : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${amount['value']} ر.ي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (amount['bonus'] != '0') Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                      child: Text('+${amount['bonus']}', style: const TextStyle(color: Colors.white, fontSize: 10))),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'رقم الجوال',
        prefixIcon: const Icon(Icons.phone),
        hintText: 'مثال: 777123456',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPaymentButton(Map<String, dynamic> amount) {
    final operator = _operators.firstWhere((o) => o['id'] == _selectedOperator);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_phoneController.text.length >= 9) ? () => _processRecharge(amount, operator) : null,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: Text('شحن ${operator['name']} بـ ${amount['value']} ر.ي', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _processRecharge(Map<String, dynamic> amount, Map<String, dynamic> operator) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشحن'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone_android, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('شحن رصيد ${operator['name']}'),
            Text('الرقم: ${_phoneController.text}'),
            Text('المبلغ: ${amount['value']} ر.ي'),
            if (amount['bonus'] != '0') Text('بونص: ${amount['bonus']} ر.ي', style: const TextStyle(color: Colors.green)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(amount, operator); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent), child: const Text('تأكيد')),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> amount, Map<String, dynamic> operator) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشحن بنجاح'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شحن ${amount['value']} ر.ي'),
            Text('إلى ${operator['name']} - ${_phoneController.text}'),
            if (amount['bonus'] != '0') Text('بونص: ${amount['bonus']} ر.ي', style: const TextStyle(color: Colors.green)),
          ],
        ),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('حسناً'))],
      ),
    );
  }
}
