import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  String _selectedBank = '';
  String _selectedMethod = 'bank';
  double _balance = 125000; // الرصيد الحالي
  
  final List<Map<String, dynamic>> _banks = [
    {'id': 'cby', 'name': 'البنك المركزي اليمني', 'code': 'CBY', 'icon': Icons.account_balance, 'color': 0xFF1B5E20},
    {'id': 'yib', 'name': 'بنك اليمن الدولي', 'code': 'YIB', 'icon': Icons.account_balance, 'color': 0xFF0D47A1},
    {'id': 'cbl', 'name': 'بنك التسليف', 'code': 'CBL', 'icon': Icons.account_balance, 'color': 0xFFE65100},
    {'id': 'kib', 'name': 'بنك الكريمي', 'code': 'KIB', 'icon': Icons.account_balance, 'color': 0xFF4A148C},
  ];
  
  final List<Map<String, dynamic>> _withdrawMethods = [
    {'id': 'bank', 'name': 'حساب بنكي', 'icon': Icons.account_balance, 'color': 0xFF1B5E20, 'fee': '0', 'min': '5000', 'max': '500000', 'time': '24 ساعة'},
    {'id': 'wallet', 'name': 'محفظة إلكترونية', 'icon': Icons.account_balance_wallet, 'color': AppTheme.goldLight, 'fee': '0', 'min': '1000', 'max': '100000', 'time': 'فوري'},
    {'id': 'cash', 'name': 'سحب نقدي', 'icon': Icons.money, 'color': 0xFF4CAF50, 'fee': '0', 'min': '1000', 'max': '50000', 'time': 'فوري'},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedMethod = _withdrawMethods.firstWhere((m) => m['id'] == _selectedMethod);
    final amount = int.tryParse(_amountController.text) ?? 0;
    final fee = int.parse(selectedMethod['fee']);
    final total = amount + fee;
    final isValid = amount > 0 && amount <= _balance && amount >= int.parse(selectedMethod['min']);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark 
          ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سحب الأموال'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildWithdrawMethods(),
            const SizedBox(height: 24),
            _buildWithdrawForm(selectedMethod, isValid, total),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldLight, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الرصيد المتاح',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '$_balance ر.ي',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                'الحد الأدنى للسحب 1000 ر.ي',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('طريقة السحب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: _withdrawMethods.map((method) {
            final isSelected = _selectedMethod == method['id'];
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedMethod = method['id']),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.goldLight.withOpacity(0.1) : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.goldLight : Colors.grey.withOpacity(0.2),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(method['icon'], color: isSelected ? AppTheme.goldLight : Color(method['color']), size: 28),
                      const SizedBox(height: 4),
                      Text(
                        method['name'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppTheme.goldLight : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildWithdrawForm(Map<String, dynamic> method, bool isValid, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات السحب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        
        if (_selectedMethod == 'bank') ...[
          DropdownButtonFormField<String>(
            value: _selectedBank.isEmpty ? null : _selectedBank,
            decoration: InputDecoration(
              labelText: 'اختر البنك',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _banks.map((bank) {
              return DropdownMenuItem<String>(
                value: bank['id'],
                child: Row(
                  children: [
                    Icon(bank['icon'], size: 20, color: Color(bank['color'])),
                    const SizedBox(width: 8),
                    Text(bank['name']),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedBank = value!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _bankAccountController,
            decoration: InputDecoration(
              labelText: 'رقم الحساب البنكي',
              prefixIcon: const Icon(Icons.numbers),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
        ],
        
        TextField(
          controller: _accountNameController,
          decoration: InputDecoration(
            labelText: 'اسم المستلم',
            prefixIcon: const Icon(Icons.person),
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
            helperText: 'الحد الأدنى: ${method['min']} ر.ي - الحد الأقصى: ${method['max']} ر.ي',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.goldLight.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('المبلغ المطلوب:'),
                  Text('${_amountController.text.isEmpty ? 0 : int.parse(_amountController.text)} ر.ي'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('رسوم السحب (${method['fee']} ر.ي):'),
                  Text('${method['fee']} ر.ي'),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$total ر.ي', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldLight)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (_amountController.text.isNotEmpty && int.parse(_amountController.text) > _balance)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 16),
                SizedBox(width: 8),
                Text('الرصيد غير كافٍ', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isValid ? () => _processWithdraw(method) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldLight,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تأكيد السحب', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processWithdraw(Map<String, dynamic> method) {
    final amount = int.parse(_amountController.text);
    final fee = int.parse(method['fee']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد عملية السحب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('المبلغ: $amount ر.ي'),
            Text('الرسوم: $fee ر.ي'),
            Text('الإجمالي: ${amount + fee} ر.ي'),
            const SizedBox(height: 16),
            const Text('سيتم خصم المبلغ من رصيدك', style: TextStyle(color: Colors.red)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(method);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> method) {
    final amount = int.parse(_amountController.text);
    final fee = int.parse(method['fee']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم تقديم طلب السحب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تقديم طلب سحب بقيمة $amount ر.ي'),
            const SizedBox(height: 8),
            Text('الرسوم: $fee ر.ي'),
            const SizedBox(height: 8),
            Text('سيتم التحويل خلال ${method['time']}', style: const TextStyle(color: Colors.orange)),
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
