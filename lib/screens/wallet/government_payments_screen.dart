import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GovernmentPaymentsScreen extends StatefulWidget {
  const GovernmentPaymentsScreen({super.key});

  @override
  State<GovernmentPaymentsScreen> createState() => _GovernmentPaymentsScreenState();
}

class _GovernmentPaymentsScreenState extends State<GovernmentPaymentsScreen> {
  String _selectedService = 'tax';
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, dynamic>> _services = [
    {'id': 'tax', 'name': 'الضرائب', 'icon': Icons.receipt, 'color': 0xFFF44336},
    {'id': 'customs', 'name': 'الجمارك', 'icon': Icons.local_shipping, 'color': 0xFF2196F3},
    {'id': 'license', 'name': 'تراخيص', 'icon': Icons.assignment, 'color': 0xFF4CAF50},
    {'id': 'municipality', 'name': 'أمانة العاصمة', 'icon': Icons.location_city, 'color': 0xFFFF9800},
    {'id': 'passport', 'name': 'الجوازات', 'icon': Icons.airplane_ticket, 'color': 0xFF9C27B0},
    {'id': 'traffic', 'name': 'المرور', 'icon': Icons.traffic, 'color': 0xFFE91E63},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'مدفوعات حكومية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServicesGrid(),
            const SizedBox(height: 24),
            _buildPaymentForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
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
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            final isSelected = _selectedService == service['id'];
            return GestureDetector(
              onTap: () => setState(() => _selectedService = service['id']),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldAccent.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.goldAccent : Colors.grey.withOpacity(0.2),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'], color: isSelected ? AppTheme.goldAccent : Color(service['color']), size: 28),
                    const SizedBox(height: 8),
                    Text(service['name'], style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPaymentForm() {
    final service = _services.firstWhere((s) => s['id'] == _selectedService);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _idController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'الرقم التعريفي / رقم الهوية',
            prefixIcon: const Icon(Icons.badge),
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
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_idController.text.isNotEmpty && _amountController.text.isNotEmpty)
                ? () => _processPayment(service)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('دفع', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processPayment(Map<String, dynamic> service) {
    final amount = int.parse(_amountController.text);
    
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
            Text('دفع ${service['name']}'),
            Text('الرقم: ${_idController.text}'),
            Text('المبلغ: $amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(service);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> service) {
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
            Text('تم دفع ${service['name']} بنجاح'),
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
