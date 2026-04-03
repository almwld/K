import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GovernmentPaymentsScreen extends StatefulWidget {
  const GovernmentPaymentsScreen({super.key});

  @override
  State<GovernmentPaymentsScreen> createState() => _GovernmentPaymentsScreenState();
}

class _GovernmentPaymentsScreenState extends State<GovernmentPaymentsScreen> {
  String _selectedService = 'electricity';
  String _selectedAmount = '5000';
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  final List<Map<String, dynamic>> _services = [
    {'id': 'electricity', 'name': 'كهرباء', 'icon': Icons.electric_bolt, 'color': 0xFFFF9800},
    {'id': 'water', 'name': 'مياه', 'icon': Icons.water_drop, 'color': 0xFF2196F3},
    {'id': 'internet', 'name': 'إنترنت', 'icon': Icons.wifi, 'color': 0xFF4CAF50},
    {'id': 'landline', 'name': 'هاتف أرضي', 'icon': Icons.phone, 'color': 0xFF9C27B0},
    {'id': 'tax', 'name': 'ضرائب', 'icon': Icons.receipt, 'color': 0xFFE31E24},
    {'id': 'municipality', 'name': 'أمانة', 'icon': Icons.business, 'color': 0xFF607D8B},
  ];

  final List<Map<String, dynamic>> _amounts = [
    {'value': '1000', 'label': '1,000 ر.ي'},
    {'value': '2000', 'label': '2,000 ر.ي'},
    {'value': '5000', 'label': '5,000 ر.ي'},
    {'value': '10000', 'label': '10,000 ر.ي'},
    {'value': '20000', 'label': '20,000 ر.ي'},
    {'value': '50000', 'label': '50,000 ر.ي'},
  ];

  String get _selectedServiceName {
    final service = _services.firstWhere((s) => s['id'] == _selectedService);
    return service['name'];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المدفوعات الحكومية'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServices(),
              const SizedBox(height: 24),
              _buildAccountNumberField(),
              const SizedBox(height: 16),
              _buildCustomerNameField(),
              const SizedBox(height: 24),
              _buildAmounts(),
              const SizedBox(height: 24),
              _buildSummary(),
              const SizedBox(height: 24),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر الخدمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            final isSelected = _selectedService == service['id'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedService = service['id'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'], color: isSelected ? AppTheme.goldColor : Color(service['color']), size: 28),
                    const SizedBox(height: 8),
                    Text(
                      service['name'],
                      style: TextStyle(
                        color: isSelected ? AppTheme.goldColor : null,
                        fontSize: 12,
                      ),
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

  Widget _buildAccountNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('رقم الحساب / العداد', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'أدخل رقم الحساب',
            prefixIcon: const Icon(Icons.numbers),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اسم العميل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _customerNameController,
          decoration: InputDecoration(
            hintText: 'أدخل اسم العميل',
            prefixIcon: const Icon(Icons.person),
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
        const Text('المبلغ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  amount['label'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSummary() {
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
          const Text('ملخص الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الخدمة:'),
              Text(_selectedServiceName, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('رقم الحساب:'),
              Text(_accountNumberController.text.isEmpty ? '---' : _accountNumberController.text),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('اسم العميل:'),
              Text(_customerNameController.text.isEmpty ? '---' : _customerNameController.text),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المبلغ:', style: TextStyle(fontSize: 16)),
              Text(
                '${int.parse(_selectedAmount).toString()} ر.ي',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('رسوم الخدمة:'),
              const Text('500 ر.ي'),
            ],
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                '${(int.parse(_selectedAmount) + 500).toString()} ر.ي',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_accountNumberController.text.isEmpty) {
            _showError('الرجاء إدخال رقم الحساب');
            return;
          }
          if (_customerNameController.text.isEmpty) {
            _showError('الرجاء إدخال اسم العميل');
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
        child: const Text('تأكيد الدفع', style: TextStyle(fontSize: 16)),
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
        title: const Text('تم الدفع بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم دفع فاتورة $_selectedServiceName'),
            Text('بمبلغ ${(int.parse(_selectedAmount) + 500).toString()} ريال'),
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
