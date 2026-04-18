import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class LocalTransferNetworksScreen extends StatefulWidget {
  const LocalTransferNetworksScreen({super.key});

  @override
  State<LocalTransferNetworksScreen> createState() => _LocalTransferNetworksScreenState();
}

class _LocalTransferNetworksScreenState extends State<LocalTransferNetworksScreen> {
  String _selectedNetwork = '';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneController = TextEditingController();

  final List<Map<String, dynamic>> _networks = [
    {'name': 'شبكة حزمي', 'code': 'Hazmi', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3, 'fee': '0%', 'time': 'فوري'},
    {'name': 'جيب حوالات', 'code': 'JaibTransfers', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37, 'fee': '0%', 'time': 'فوري'},
    {'name': 'الامتياز', 'code': 'AlEmtiaz', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'شبكة النجم', 'code': 'AlNajm', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'يمن اكسبرس', 'code': 'YemenExpress', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE91E63, 'fee': '0%', 'time': 'خلال ساعتين'},
    {'name': 'إتش بي فاست', 'code': 'HBFast', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0, 'fee': '0%', 'time': 'فوري'},
    {'name': 'شبكة الحوشي', 'code': 'AlHawshi', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'شبكة الاكوع', 'code': 'AlAkoa', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF0D47A1, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'الشبكة اليمنية للتحويلات', 'code': 'YemenTransfers', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE65100, 'fee': '0%', 'time': 'خلال 24 ساعة'},
    {'name': 'شبكة المميز', 'code': 'AlMomayaz', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37, 'fee': '0%', 'time': 'فوري'},
    {'name': 'شبكة الهتار', 'code': 'AlHattar', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4A148C, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'شبكة مال موني', 'code': 'MalMoney', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50, 'fee': '0%', 'time': 'فوري'},
    {'name': 'شبكة البرق', 'code': 'AlBarq', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'fee': '0%', 'time': 'فوري'},
    {'name': 'السريع للحوالات', 'code': 'AlSaree', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFF44336, 'fee': '0%', 'time': 'فوري'},
    {'name': 'شبكة الناصر', 'code': 'AlNaser', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3, 'fee': '0%', 'time': 'خلال ساعة'},
    {'name': 'شبكة المحيط', 'code': 'AlMuheet', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20, 'fee': '0%', 'time': 'خلال ساعتين'},
    {'name': 'شبكة العامري كاش', 'code': 'AlAmeryCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0, 'fee': '0%', 'time': 'فوري'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedNetwork = _networks.firstWhere((n) => n['code'] == _selectedNetwork, orElse: () => {});
    final amount = int.tryParse(_amountController.text) ?? 0;
    final fee = selectedNetwork.isNotEmpty ? (amount * (double.parse(selectedNetwork['fee'].replaceAll('%', '')) / 100)).toInt() : 0;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شبكات التحويل المحلية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNetworksGrid(),
            const SizedBox(height: 24),
            if (_selectedNetwork.isNotEmpty) _buildTransferForm(selectedNetwork, amount, fee),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworksGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر شبكة التحويل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _networks.length,
          itemBuilder: (context, index) {
            final network = _networks[index];
            final isSelected = _selectedNetwork == network['code'];
            return GestureDetector(
              onTap: () => setState(() => _selectedNetwork = network['code']),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldAccent.withOpacity(0.1) : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldAccent : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                        imageUrl: network['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 50, height: 50,
                          color: Color(network['color']).withOpacity(0.1),
                          child: Icon(Icons.network_cell, color: Color(network['color']), size: 30),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 50, height: 50,
                          color: Color(network['color']).withOpacity(0.1),
                          child: Icon(Icons.network_cell, color: Color(network['color']), size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(network['name'], textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                    Text('رسوم: ${network['fee']}', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransferForm(Map<String, dynamic> network, int amount, int fee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الحوالة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _receiverNameController,
          decoration: InputDecoration(
            labelText: 'اسم المستلم',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _receiverPhoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'رقم الجوال',
            prefixIcon: const Icon(Icons.phone),
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
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.goldAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('المبلغ:'), Text('$amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('رسوم التحويل (${network['fee']}):'), Text('$fee ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))]),
              const Divider(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${amount + fee} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldAccent))]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_receiverNameController.text.isNotEmpty && amount > 0) ? () => _processTransfer(network, amount, fee) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('إرسال حوالة', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processTransfer(Map<String, dynamic> network, int amount, int fee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد إرسال الحوالة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.send, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('إرسال حوالة عبر ${network['name']}'),
            Text('المبلغ: $amount ر.ي'),
            Text('الرسوم: $fee ر.ي'),
            Text('الإجمالي: ${amount + fee} ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(network, amount);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> network, int amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم إرسال الحوالة بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم إرسال $amount ر.ي عبر ${network['name']}'),
            Text('سيتم الإرسال خلال ${network['time']}', style: const TextStyle(color: Colors.orange)),
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
