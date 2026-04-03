import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class RechargeCreditScreen extends StatefulWidget {
  const RechargeCreditScreen({super.key});

  @override
  State<RechargeCreditScreen> createState() => _RechargeCreditScreenState();
}

class _RechargeCreditScreenState extends State<RechargeCreditScreen> {
  String _selectedOperator = 'yemen_mobile';
  String _selectedAmount = '1000';
  final TextEditingController _phoneController = TextEditingController();
  
  final List<Map<String, dynamic>> _operators = [
    {'id': 'yemen_mobile', 'name': 'يمن موبايل', 'icon': Icons.sim_card, 'color': 0xFFE31E24},
    {'id': 'you', 'name': 'YOU', 'icon': Icons.sim_card, 'color': 0xFF4CAF50},
    {'id': 'way', 'name': 'Way', 'icon': Icons.sim_card, 'color': 0xFF9C27B0},
    {'id': 'yemen_net', 'name': 'يمن نت', 'icon': Icons.wifi, 'color': 0xFF2196F3},
  ];
  
  final List<Map<String, dynamic>> _amounts = [
    {'value': '500', 'label': '500 ر.ي', 'bonus': ''},
    {'value': '1000', 'label': '1,000 ر.ي', 'bonus': '+50'},
    {'value': '2000', 'label': '2,000 ر.ي', 'bonus': '+150'},
    {'value': '5000', 'label': '5,000 ر.ي', 'bonus': '+500'},
    {'value': '10000', 'label': '10,000 ر.ي', 'bonus': '+1,500'},
    {'value': '20000', 'label': '20,000 ر.ي', 'bonus': '+4,000'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'شحن الرصيد'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOperators(),
              const SizedBox(height: 24),
              _buildPhoneField(),
              const SizedBox(height: 24),
              _buildAmounts(),
              const SizedBox(height: 24),
              _buildSummary(),
              const SizedBox(height: 24),
              _buildRechargeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperators() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المشغل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: _operators.map((operator) {
            final isSelected = _selectedOperator == operator['id'];
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOperator = operator['id'];
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
                      Icon(operator['icon'], color: isSelected ? AppTheme.goldColor : Color(operator['color']), size: 28),
                      const SizedBox(height: 4),
                      Text(
                        operator['name'],
                        style: TextStyle(
                          color: isSelected ? AppTheme.goldColor : null,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : null,
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

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('رقم الجوال', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'أدخل رقم الجوال',
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildAmounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر المبلغ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _amounts.map((amount) {
            final isSelected = _selectedAmount == amount['value'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAmount = amount['value'];
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      amount['label'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (amount['bonus'].isNotEmpty)
                      Text(
                        amount['bonus'],
                        style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.green,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    final selectedAmount = _amounts.firstWhere((a) => a['value'] == _selectedAmount);
    final operator = _operators.firstWhere((o) => o['id'] == _selectedOperator);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.goldColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ملخص العملية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المشغل:'),
              Text(operator['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المبلغ:'),
              Text(selectedAmount['label'], style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          if (selectedAmount['bonus'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المكافأة:'),
                Text(selectedAmount['bonus'], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المبلغ الإجمالي:', style: TextStyle(fontSize: 16)),
              Text(
                '${int.parse(_selectedAmount).toString()} ر.ي',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRechargeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_phoneController.text.isEmpty) {
            _showError('الرجاء إدخال رقم الجوال');
            return;
          }
          if (_phoneController.text.length < 9) {
            _showError('رقم الجوال غير صحيح');
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
        child: const Text('تأكيد الشحن', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessDialog() {
    final operator = _operators.firstWhere((o) => o['id'] == _selectedOperator);
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
            Text('تم شحن رصيد ${operator['name']}'),
            Text('بمبلغ $_selectedAmount ريال'),
            Text('إلى الرقم: ${_phoneController.text}'),
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
