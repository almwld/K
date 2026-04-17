import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class CashWithdrawalScreen extends StatefulWidget {
  const CashWithdrawalScreen({super.key});

  @override
  State<CashWithdrawalScreen> createState() => _CashWithdrawalScreenState();
}

class _CashWithdrawalScreenState extends State<CashWithdrawalScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedOffice = '';
  
  final List<Map<String, dynamic>> _offices = [
    {'name': 'فروع فلكس يمن - صنعاء', 'address': 'شارع حدة، صنعاء', 'working_hours': '9ص - 9م', 'phone': '+967712345678'},
    {'name': 'فروع فلكس يمن - عدن', 'address': 'شارع خور مكسر، عدن', 'working_hours': '9ص - 9م', 'phone': '+967712345679'},
    {'name': 'فروع فلكس يمن - تعز', 'address': 'شارع الجند، تعز', 'working_hours': '9ص - 8م', 'phone': '+967712345680'},
    {'name': 'وكلاء فلكس يمن', 'address': 'جميع المحافظات', 'working_hours': '9ص - 10م', 'phone': '+967712345681'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.navyPrimary : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سحب نقدي'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 24),
            _buildOfficeSelector(),
            const SizedBox(height: 16),
            _buildWithdrawForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldColor, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'السحب النقدي',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'يمكنك سحب أموالك من فروع فلكس يمن أو وكلائنا',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر الفرع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedOffice.isEmpty ? null : _selectedOffice,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          hint: const Text('اختر الفرع'),
          items: _offices.map((office) {
            return DropdownMenuItem<String>(
              value: office['name'],
              child: Text(office['name']),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedOffice = value!),
        ),
        if (_selectedOffice.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _offices.firstWhere((o) => o['name'] == _selectedOffice)['address'],
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        _offices.firstWhere((o) => o['name'] == _selectedOffice)['working_hours'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        _offices.firstWhere((o) => o['name'] == _selectedOffice)['phone'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildWithdrawForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات السحب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _phoneController,
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
            helperText: 'الحد الأدنى 1000 ر.ي - الحد الأقصى 50000 ر.ي',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_selectedOffice.isNotEmpty && _phoneController.text.isNotEmpty && _amountController.text.isNotEmpty)
                ? () => _processWithdrawal()
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('تأكيد طلب السحب', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processWithdrawal() {
    final amount = int.parse(_amountController.text);
    final office = _offices.firstWhere((o) => o['name'] == _selectedOffice);
    
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
            Text('الفرع: ${office['name']}'),
            const SizedBox(height: 8),
            const Text('سيتم التواصل معك لتأكيد العملية'),
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
