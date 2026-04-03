import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedMethod = 'flexpay';
  
  final List<Map<String, dynamic>> _transferMethods = [
    {'id': 'flexpay', 'name': 'محفظة فلكس', 'icon': Icons.account_balance_wallet, 'color': AppTheme.goldColor, 'fee': '0'},
    {'id': 'yemen_mobile', 'name': 'يمن موبايل', 'icon': Icons.phone_android, 'color': 0xFFE31E24, 'fee': '200'},
    {'id': 'you', 'name': 'YOU', 'icon': Icons.phone_android, 'color': 0xFF4CAF50, 'fee': '200'},
    {'id': 'way', 'name': 'Way', 'icon': Icons.phone_android, 'color': 0xFF9C27B0, 'fee': '200'},
    {'id': 'bank', 'name': 'حساب بنكي', 'icon': Icons.account_balance, 'color': 0xFF1B5E20, 'fee': '500'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تحويل الأموال'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMethodsGrid(),
            const SizedBox(height: 24),
            _buildTransferForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('طريقة التحويل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _transferMethods.length,
          itemBuilder: (context, index) {
            final method = _transferMethods[index];
            final isSelected = _selectedMethod == method['id'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMethod = method['id'];
                });
              },
              child: Container(
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
                    Icon(method['icon'], color: isSelected ? AppTheme.goldColor : Color(method['color']), size: 32),
                    const SizedBox(height: 8),
                    Text(
                      method['name'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? AppTheme.goldColor : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'رسوم: ${method['fee']} ر.ي',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransferForm() {
    final selectedMethod = _transferMethods.firstWhere((m) => m['id'] == _selectedMethod);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات التحويل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: _selectedMethod == 'bank' ? 'رقم الحساب البنكي' : 'رقم الجوال',
            prefixIcon: Icon(_selectedMethod == 'bank' ? Icons.account_balance : Icons.phone),
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
        TextField(
          controller: _noteController,
          decoration: InputDecoration(
            labelText: 'ملاحظة (اختياري)',
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('رسوم التحويل:'),
              Text('${selectedMethod['fee']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.goldColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي:'),
              Text(
                _amountController.text.isEmpty 
                    ? '0 ر.ي' 
                    : '${int.parse(_amountController.text) + int.parse(selectedMethod['fee'])} ر.ي',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _validateAndTransfer,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تحويل', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _validateAndTransfer() {
    if (_phoneController.text.isEmpty) {
      _showError('الرجاء إدخال رقم الجوال أو الحساب');
      return;
    }
    if (_amountController.text.isEmpty) {
      _showError('الرجاء إدخال المبلغ');
      return;
    }
    
    final amount = int.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showError('المبلغ غير صحيح');
      return;
    }
    
    _showSuccessDialog();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessDialog() {
    final selectedMethod = _transferMethods.firstWhere((m) => m['id'] == _selectedMethod);
    final amount = int.parse(_amountController.text);
    final fee = int.parse(selectedMethod['fee']);
    
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
            Text('تم تحويل $amount ر.ي'),
            Text('إلى ${selectedMethod['name']}'),
            Text('رسوم التحويل: $fee ر.ي'),
            const Divider(),
            Text('الإجمالي: ${amount + fee} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
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
