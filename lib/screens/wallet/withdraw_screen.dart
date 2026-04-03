import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String _selectedCurrency = 'YER';
  String _selectedMethod = 'bank';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  final List<Map<String, dynamic>> _currencies = [
    {'code': 'YER', 'name': 'ريال يمني', 'symbol': 'ر.ي', 'balance': 125000, 'min': 1000, 'max': 100000},
    {'code': 'SAR', 'name': 'ريال سعودي', 'symbol': 'ر.س', 'balance': 500, 'min': 10, 'max': 500},
    {'code': 'USD', 'name': 'دولار أمريكي', 'symbol': '\$', 'balance': 100, 'min': 5, 'max': 100},
  ];

  final List<Map<String, dynamic>> _withdrawMethods = [
    {'id': 'bank', 'name': 'حساب بنكي', 'icon': Icons.account_balance, 'color': 0xFF2196F3},
    {'id': 'mobile', 'name': 'محفظة جوال', 'icon': Icons.phone_android, 'color': 0xFFFF9800},
    {'id': 'cash', 'name': 'سحب نقدي', 'icon': Icons.attach_money, 'color': 0xFF4CAF50},
  ];

  double get _currentBalance {
    final currency = _currencies.firstWhere((c) => c['code'] == _selectedCurrency);
    return currency['balance'];
  }

  int get _minAmount {
    final currency = _currencies.firstWhere((c) => c['code'] == _selectedCurrency);
    return currency['min'];
  }

  int get _maxAmount {
    final currency = _currencies.firstWhere((c) => c['code'] == _selectedCurrency);
    return currency['max'];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سحب'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              const SizedBox(height: 24),
              _buildAmountCard(),
              const SizedBox(height: 24),
              _buildCurrencySelector(),
              const SizedBox(height: 24),
              _buildWithdrawMethods(),
              const SizedBox(height: 24),
              if (_selectedMethod == 'bank') _buildBankDetails(),
              const SizedBox(height: 24),
              _buildPinField(),
              const SizedBox(height: 24),
              _buildWithdrawButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('الرصيد المتاح', style: TextStyle(fontSize: 14)),
          Text(
            '$_currentBalance $_selectedCurrency',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldColor, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'المبلغ المراد سحبه',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: const TextStyle(color: Colors.white54, fontSize: 32),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                _selectedCurrency,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'الحد الأدنى: $_minAmount | الحد الأقصى: $_maxAmount',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر العملة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: _currencies.map((currency) {
            final isSelected = _selectedCurrency == currency['code'];
            return FilterChip(
              label: Text('${currency['code']} (${currency['symbol']})'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCurrency = currency['code'];
                });
              },
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            );
          }).toList(),
        ),
      ],
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
                onTap: () {
                  setState(() {
                    _selectedMethod = method['id'];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(method['icon'], color: isSelected ? AppTheme.goldColor : Colors.grey, size: 28),
                      const SizedBox(height: 4),
                      Text(method['name'], style: TextStyle(color: isSelected ? AppTheme.goldColor : Colors.grey, fontSize: 10)),
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

  Widget _buildBankDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الحساب البنكي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _bankAccountController,
          decoration: InputDecoration(
            labelText: 'رقم الحساب / IBAN',
            prefixIcon: const Icon(Icons.account_balance),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildPinField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('رمز التحقق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            labelText: 'أدخل رمز الـ PIN المكون من 6 أرقام',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final amount = double.tryParse(_amountController.text);
          if (amount == null || amount < _minAmount) {
            _showError('الرجاء إدخال مبلغ صحيح (الحد الأدنى $_minAmount)');
            return;
          }
          if (amount > _currentBalance) {
            _showError('الرصيد غير كافٍ');
            return;
          }
          if (amount > _maxAmount) {
            _showError('الحد الأقصى للسحب هو $_maxAmount $_selectedCurrency');
            return;
          }
          if (_pinController.text.length != 6) {
            _showError('الرجاء إدخال رمز PIN صحيح');
            return;
          }
          _showSuccessDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.goldColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('تأكيد السحب', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم طلب سحب ${_amountController.text} $_selectedCurrency'),
            const SizedBox(height: 8),
            const Text('سيتم تحويل المبلغ إلى حسابك خلال 24 ساعة'),
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
