import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _senderController = TextEditingController();
  String _selectedMethod = 'محفظة جيب';
  bool _isLoading = false;

  final List<String> _paymentMethods = ['محفظة جيب', 'محفظة جوالي', 'محفظة كاش', 'تحويل بنكي'];

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلب استلام الحوالة!'), backgroundColor: AppTheme.binanceGreen),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('استلام حوالة', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.binanceGold))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'المبلغ (ريال)',
                        prefixIcon: Icon(Icons.attach_money, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال المبلغ' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _senderController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'اسم المرسل',
                        prefixIcon: Icon(Icons.person, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedMethod,
                      items: _paymentMethods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                      onChanged: (v) => setState(() => _selectedMethod = v!),
                      decoration: const InputDecoration(
                        labelText: 'طريقة الاستلام',
                        prefixIcon: Icon(Icons.payment, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.binanceGold,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('تأكيد الاستلام', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
