import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/simple_app_bar.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _amountController = TextEditingController();
  String? _selectedMethod;

  final List<Map<String, dynamic>> _withdrawMethods = [
    {'id': 'bank', 'name': 'تحويل بنكي', 'icon': Icons.account_balance},
    {'id': 'wallet', 'name': 'محفظة إلكترونية', 'icon': Icons.account_balance_wallet},
    {'id': 'cash', 'name': 'استلام نقدي', 'icon': Icons.money},
    {'id': 'agent', 'name': 'وكيل معتمد', 'icon': Icons.store},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سحب'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الرصيد المتاح'),
                  const Text(
                    '250,000 ر.ي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldColor,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

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

            // Withdraw Methods
            Text(
              'طريقة السحب',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            ..._withdrawMethods.map((method) {
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
              text: 'سحب',
              onPressed: () {
                if (_amountController.text.isEmpty || _selectedMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى إدخال المبلغ واختيار طريقة السحب')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('جاري معالجة السحب...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
