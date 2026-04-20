import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransferNetworkScreen extends StatefulWidget {
  const TransferNetworkScreen({super.key});

  @override
  State<TransferNetworkScreen> createState() => _TransferNetworkScreenState();
}

class _TransferNetworkScreenState extends State<TransferNetworkScreen> {
  String _selectedFromNetwork = '';
  String _selectedToNetwork = '';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, dynamic>> _networks = [
    {'name': 'يمن موبايل', 'code': 'ymobile', 'color': 0xFFE31E24, 'fee': '0'},
    {'name': 'YOU', 'code': 'you', 'color': 0xFF4CAF50, 'fee': '0'},
    {'name': 'سبأفون', 'code': 'sabafon', 'color': 0xFF2196F3, 'fee': '0'},
    {'name': 'واي', 'code': 'way', 'color': 0xFF9C27B0, 'fee': '0'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fromNetwork = _networks.firstWhere((n) => n['code'] == _selectedFromNetwork, orElse: () => {});
    final toNetwork = _networks.firstWhere((n) => n['code'] == _selectedToNetwork, orElse: () => {});
    final amount = int.tryParse(_amountController.text) ?? 0;
    final fee = fromNetwork.isNotEmpty ? int.parse(fromNetwork['fee']) : 0;
    final total = amount + fee;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تحويل رصيد بين الشبكات'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNetworkSelector('من', _selectedFromNetwork, (value) => setState(() => _selectedFromNetwork = value)),
            const SizedBox(height: 16),
            _buildNetworkSelector('إلى', _selectedToNetwork, (value) => setState(() => _selectedToNetwork = value)),
            const SizedBox(height: 16),
            _buildPhoneInput(),
            const SizedBox(height: 16),
            _buildAmountInput(),
            if (_selectedFromNetwork.isNotEmpty && _selectedToNetwork.isNotEmpty && amount > 0) _buildSummary(fromNetwork, toNetwork, amount, fee, total),
            const SizedBox(height: 24),
            if (_selectedFromNetwork.isNotEmpty && _selectedToNetwork.isNotEmpty && amount > 0) _buildTransferButton(fromNetwork, toNetwork, amount, fee, total),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkSelector(String label, String selectedValue, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue.isEmpty ? null : selectedValue,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          hint: Text('اختر الشبكة $label'),
          items: _networks.map((network) {
            return DropdownMenuItem<String>(
              value: network['code'],
              child: Row(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: Color(network['color']), shape: BoxShape.circle)), const SizedBox(width: 8), Text(network['name'])]),
            );
          }).toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(labelText: 'رقم الجوال', prefixIcon: const Icon(Icons.phone), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    );
  }

  Widget _buildAmountInput() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'المبلغ', prefixIcon: const Icon(Icons.attach_money), suffixText: 'ر.ي', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _buildSummary(Map<String, dynamic> fromNetwork, Map<String, dynamic> toNetwork, int amount, int fee, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.goldLight.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('من:'), Text(fromNetwork['name'], style: const TextStyle(fontWeight: FontWeight.bold))]),
        const SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('إلى:'), Text(toNetwork['name'], style: const TextStyle(fontWeight: FontWeight.bold))]),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('المبلغ:'), Text('$amount ر.ي')]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('رسوم التحويل:'), Text('$fee ر.ي', style: const TextStyle(color: Colors.orange))]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)), Text('$total ر.ي', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldLight))]),
      ]),
    );
  }

  Widget _buildTransferButton(Map<String, dynamic> fromNetwork, Map<String, dynamic> toNetwork, int amount, int fee, int total) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_phoneController.text.isNotEmpty) ? () => _processTransfer(fromNetwork, toNetwork, amount, fee, total) : null,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: const Text('تأكيد التحويل', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  void _processTransfer(Map<String, dynamic> fromNetwork, Map<String, dynamic> toNetwork, int amount, int fee, int total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد التحويل'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_horiz, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('تحويل $amount ر.ي من ${fromNetwork['name']} إلى ${toNetwork['name']}'),
            Text('الرقم: ${_phoneController.text}'),
            Text('الرسوم: $fee ر.ي'),
            Text('الإجمالي: $total ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(fromNetwork, toNetwork, amount); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight), child: const Text('تأكيد')),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> fromNetwork, Map<String, dynamic> toNetwork, int amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم التحويل بنجاح'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تحويل $amount ر.ي'),
            Text('من ${fromNetwork['name']} إلى ${toNetwork['name']}'),
          ],
        ),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('حسناً'))],
      ),
    );
  }
}

