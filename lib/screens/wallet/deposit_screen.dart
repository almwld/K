import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/simple_app_bar.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  String? _selectedMethod;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'id': 'bank', 'name': 'تحويل بنكي', 'icon': Icons.account_balance},
    {'id': 'card', 'name': 'بطاقة ائتمانية', 'icon': Icons.credit_card},
    {'id': 'wallet', 'name': 'محفظة إلكترونية', 'icon': Icons.account_balance_wallet},
    {'id': 'cash', 'name': 'دفع نقدي', 'icon': Icons.money},
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
            // Amount Input
            Text(
              'المبلغ',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'أدخل المبلغ',
                suffixText: 'ر.ي',
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick Amounts
            Wrap(
              spacing: 8,
              children: [5000, 10000, 25000, 50000, 100000].map((amount) {
                return ActionChip(
                  label: Text('$amount ر.ي'),
                  onPressed: () => _amountController.text = amount.toString(),
                  backgroundColor: AppTheme.getCardColor(context),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Payment Methods
            Text(
              'طريقة الدفع',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            ..._paymentMethods.map((method) {
              final isSelected = _selectedMethod == method['id'];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: AppTheme.goldColor, width: 2)
                      : null,
                ),
                child: ListTile(
                  leading: Icon(method['icon'] as IconData, color: AppTheme.goldColor),
                  title: Text(method['name'] as String),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: AppTheme.goldColor)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () => setState(() => _selectedMethod = method['id'] as String),
                ),
              );
            }),

            const SizedBox(height: 32),

            CustomButton(
              text: 'إيداع',
              onPressed: () {
                if (_amountController.text.isEmpty || _selectedMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى إدخال المبلغ واختيار طريقة الدفع')),
                  );
                  return;
                }
                // Process deposit
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري معالجة الإيداع...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
