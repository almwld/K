import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class MoneyTransfersScreen extends StatefulWidget {
  const MoneyTransfersScreen({super.key});

  @override
  State<MoneyTransfersScreen> createState() => _MoneyTransfersScreenState();
}

class _MoneyTransfersScreenState extends State<MoneyTransfersScreen> {
  String _selectedService = 'western';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverCountryController = TextEditingController();

  final List<Map<String, dynamic>> _services = [
    {'id': 'western', 'name': 'ويسترن يونيون', 'icon': Icons.currency_exchange, 'color': 0xFFF44336, 'fee': '2', 'min': '10000', 'max': '5000000', 'time': 'خلال ساعة'},
    {'id': 'moneygram', 'name': 'ماني غرام', 'icon': Icons.currency_exchange, 'color': 0xFF2196F3, 'fee': '1.5', 'min': '5000', 'max': '3000000', 'time': 'خلال ساعتين'},
    {'id': 'riyad', 'name': 'بنك الرياض', 'icon': Icons.account_balance, 'color': 0xFF4CAF50, 'fee': '1', 'min': '20000', 'max': '10000000', 'time': 'خلال 24 ساعة'},
    {'id': 'alrajhi', 'name': 'مصرف الراجحي', 'icon': Icons.account_balance, 'color': 0xFF9C27B0, 'fee': '1', 'min': '20000', 'max': '10000000', 'time': 'خلال 24 ساعة'},
  ];

  final List<Map<String, dynamic>> _countries = [
    {'name': 'السعودية', 'currency': 'ريال سعودي', 'code': 'SAR', 'rate': '65', 'flag': '🇸🇦'},
    {'name': 'الإمارات', 'currency': 'درهم إماراتي', 'code': 'AED', 'rate': '66.5', 'flag': '🇦🇪'},
    {'name': 'قطر', 'currency': 'ريال قطري', 'code': 'QAR', 'rate': '67', 'flag': '🇶🇦'},
    {'name': 'الكويت', 'currency': 'دينار كويتي', 'code': 'KWD', 'rate': '530', 'flag': '🇰🇼'},
    {'name': 'عمان', 'currency': 'ريال عماني', 'code': 'OMR', 'rate': '420', 'flag': '🇴🇲'},
    {'name': 'البحرين', 'currency': 'دينار بحريني', 'code': 'BHD', 'rate': '430', 'flag': '🇧🇭'},
    {'name': 'الأردن', 'currency': 'دينار أردني', 'code': 'JOD', 'rate': '228', 'flag': '🇯🇴'},
    {'name': 'مصر', 'currency': 'جنيه مصري', 'code': 'EGP', 'rate': '3.2', 'flag': '🇪🇬'},
    {'name': 'تركيا', 'currency': 'ليرة تركية', 'code': 'TRY', 'rate': '10', 'flag': '🇹🇷'},
    {'name': 'أمريكا', 'currency': 'دولار أمريكي', 'code': 'USD', 'rate': '250', 'flag': '🇺🇸'},
    {'name': 'بريطانيا', 'currency': 'جنيه إسترليني', 'code': 'GBP', 'rate': '320', 'flag': '🇬🇧'},
    {'name': 'أوروبا', 'currency': 'يورو', 'code': 'EUR', 'rate': '270', 'flag': '🇪🇺'},
  ];

  String _selectedCountry = '';
  double _exchangeRate = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedService = _services.firstWhere((s) => s['id'] == _selectedService);
    final amount = int.tryParse(_amountController.text) ?? 0;
    final feePercent = double.parse(selectedService['fee']);
    final fee = (amount * feePercent / 100).toInt();
    final total = amount + fee;
    final convertedAmount = amount * _exchangeRate;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تحويلات دولية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServicesGrid(),
            const SizedBox(height: 24),
            _buildCountrySelector(),
            const SizedBox(height: 16),
            _buildTransferForm(selectedService, amount, fee, total, convertedAmount),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر خدمة التحويل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            final isSelected = _selectedService == service['id'];
            return GestureDetector(
              onTap: () => setState(() => _selectedService = service['id']),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'], color: isSelected ? AppTheme.goldColor : Color(service['color']), size: 32),
                    const SizedBox(height: 8),
                    Text(service['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                    Text('رسوم: ${service['fee']}%', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCountrySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('الدولة المرسلة إليها', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCountry.isEmpty ? null : _selectedCountry,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          hint: const Text('اختر الدولة'),
          items: _countries.map((country) {
            return DropdownMenuItem<String>(
              value: country['name'],
              child: Row(children: [Text(country['flag']), const SizedBox(width: 8), Text(country['name']), const SizedBox(width: 8), Text(country['currency'], style: const TextStyle(fontSize: 12, color: Colors.grey))]),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCountry = value!;
              final country = _countries.firstWhere((c) => c['name'] == value);
              _exchangeRate = double.parse(country['rate']);
            });
          },
        ),
        if (_selectedCountry.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('سعر الصرف: 1 ${_countries.firstWhere((c) => c['name'] == _selectedCountry)['currency']} = ${_exchangeRate} ر.ي'), const Icon(Icons.trending_up, color: Colors.green)]),
            ),
          ),
      ],
    );
  }

  Widget _buildTransferForm(Map<String, dynamic> service, int amount, int fee, int total, double convertedAmount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('بيانات التحويل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: _receiverNameController,
          decoration: InputDecoration(labelText: 'اسم المستلم', prefixIcon: const Icon(Icons.person), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'المبلغ (ريال يمني)', prefixIcon: const Icon(Icons.attach_money), helperText: 'الحد الأدنى: ${service['min']} - الحد الأقصى: ${service['max']}', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          onChanged: (_) => setState(() {}),
        ),
        if (_selectedCountry.isNotEmpty && amount > 0)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppTheme.goldColor.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('المبلغ المحول:'), Text('$amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('المبلغ بعد التحويل:'), Text('${convertedAmount.toStringAsFixed(2)} ${_countries.firstWhere((c) => c['name'] == _selectedCountry)['currency']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green))]),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('رسوم التحويل (${service['fee']}%):'), Text('$fee ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))]),
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)), Text('$total ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldColor))]),
                ],
              ),
            ),
          ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_receiverNameController.text.isNotEmpty && _selectedCountry.isNotEmpty && amount > 0) ? () => _processTransfer(service, amount, fee, total) : null,
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('تأكيد التحويل', style: TextStyle(fontSize: 18)),
          ),
        ),
      ],
    );
  }

  void _processTransfer(Map<String, dynamic> service, int amount, int fee, int total) {
    final country = _countries.firstWhere((c) => c['name'] == _selectedCountry);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد التحويل'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.send, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('تحويل إلى ${country['name']} عبر ${service['name']}'),
            Text('المبلغ: $amount ر.ي'),
            Text('الرسوم: $fee ر.ي'),
            Text('الإجمالي: $total ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(service, country, amount);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> service, Map<String, dynamic> country, int amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم تقديم طلب التحويل'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تحويل $amount ر.ي إلى ${country['name']}'),
            Text('عبر خدمة ${service['name']}'),
            const SizedBox(height: 8),
            Text('سيتم التحويل خلال ${service['time']}', style: const TextStyle(color: Colors.orange)),
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
