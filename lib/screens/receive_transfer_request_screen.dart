import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  final _amountController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _transferCodeController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitRequest() async {
    if (_amountController.text.isEmpty || _transferCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول'), backgroundColor: Colors.orange),
      );
      return;
    }

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلب استلام الحوالة بنجاح'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'استلام حوالة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_balance_wallet, size: 60, color: AppTheme.goldColor),
            const SizedBox(height: 16),
            const Text('استلام حوالة مالية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('أدخل بيانات الحوالة لاستلامها', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
            const SizedBox(height: 32),
            TextFormField(
              controller: _senderNameController,
              decoration: const InputDecoration(
                labelText: 'اسم المرسل',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'المبلغ (ريال)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _transferCodeController,
              decoration: const InputDecoration(
                labelText: 'رمز الحوالة',
                prefixIcon: Icon(Icons.code),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : const Text('استلام الحوالة', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
