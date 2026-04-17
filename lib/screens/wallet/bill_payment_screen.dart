import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  String _selectedCategory = 'electricity';
  
  final List<Map<String, dynamic>> _categories = [
    {'id': 'electricity', 'name': 'كهرباء', 'icon': Icons.electrical_services, 'color': 0xFFFF9800},
    {'id': 'water', 'name': 'مياه', 'icon': Icons.water_drop, 'color': 0xFF2196F3},
    {'id': 'internet', 'name': 'إنترنت', 'icon': Icons.wifi, 'color': 0xFF4CAF50},
    {'id': 'mobile', 'name': 'جوال', 'icon': Icons.phone_android, 'color': 0xFF9C27B0},
    {'id': 'gas', 'name': 'غاز', 'icon': Icons.local_fire_department, 'color': 0xFFF44336},
  ];
  
  final Map<String, List<Map<String, dynamic>>> _providers = {
    'electricity': [
      {'name': 'مؤسسة كهرباء صنعاء', 'code': 'PEC', 'min': '1000', 'icon': Icons.electrical_services},
      {'name': 'مؤسسة كهرباء عدن', 'code': 'AEC', 'min': '1000', 'icon': Icons.electrical_services},
    ],
    'water': [
      {'name': 'مؤسسة مياه صنعاء', 'code': 'PWC', 'min': '500', 'icon': Icons.water_drop},
      {'name': 'مؤسسة مياه عدن', 'code': 'AWC', 'min': '500', 'icon': Icons.water_drop},
    ],
    'internet': [
      {'name': 'يمن نت', 'code': 'YNet', 'min': '2000', 'icon': Icons.wifi},
      {'name': 'تيليمن', 'code': 'TeleYemen', 'min': '2000', 'icon': Icons.wifi},
    ],
    'mobile': [
      {'name': 'يمن موبايل', 'code': 'YMobile', 'min': '200', 'icon': Icons.phone_android},
      {'name': 'YOU', 'code': 'YOU', 'min': '200', 'icon': Icons.phone_android},
      {'name': 'MTN', 'code': 'MTN', 'min': '200', 'icon': Icons.phone_android},
    ],
    'gas': [
      {'name': 'غاز صنعاء', 'code': 'PGC', 'min': '1000', 'icon': Icons.local_fire_department},
    ],
  };

  String _selectedProvider = '';
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final providers = _providers[_selectedCategory] ?? [];
    final selectedProviderObj = providers.firstWhere(
      (p) => p['code'] == _selectedProvider,
      orElse: () => {},
    );

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'دفع الفواتير'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategories(),
            const SizedBox(height: 24),
            _buildProviderSelector(providers),
            const SizedBox(height: 16),
            _buildPaymentForm(selectedProviderObj),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر نوع الفاتورة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['id'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category['id'];
                    _selectedProvider = '';
                  });
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category['icon'], color: isSelected ? AppTheme.goldColor : Color(category['color']), size: 28),
                      const SizedBox(height: 4),
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? AppTheme.goldColor : null,
                        ),
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

  Widget _buildProviderSelector(List<Map<String, dynamic>> providers) {
    if (providers.isEmpty) return const SizedBox();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المزود', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedProvider.isEmpty ? null : _selectedProvider,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          hint: const Text('اختر المزود'),
          items: providers.map((provider) {
            return DropdownMenuItem<String>(
              value: provider['code'],
              child: Row(
                children: [
                  Icon(provider['icon'], size: 20, color: AppTheme.goldColor),
                  const SizedBox(width: 8),
                  Text(provider['name']),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedProvider = value!),
        ),
      ],
    );
  }

  Widget _buildPaymentForm(Map<String, dynamic> provider) {
    if (_selectedProvider.isEmpty) return const SizedBox();
    
    final amount = int.tryParse(_amountController.text) ?? 0;
    final minAmount = int.tryParse(provider['min'] ?? '0') ?? 0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _accountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'رقم الحساب / العداد',
            prefixIcon: const Icon(Icons.numbers),
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
            helperText: 'الحد الأدنى: $minAmount ر.ي',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_accountController.text.isNotEmpty && amount >= minAmount)
                ? () => _processPayment(provider)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('دفع الفاتورة', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processPayment(Map<String, dynamic> provider) {
    final amount = int.parse(_amountController.text);
    final category = _categories.firstWhere((c) => c['id'] == _selectedCategory);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الدفع'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('دفع فاتورة ${category['name']}'),
            Text('لحساب رقم: ${_accountController.text}'),
            Text('المبلغ: $amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(category);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> category) {
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
            Text('تم دفع فاتورة ${category['name']} بنجاح'),
            const Text('سيتم إرسال إيصال الدفع إلى بريدك الإلكتروني'),
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
