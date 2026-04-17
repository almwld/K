import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _transferCodeController = TextEditingController();
  final _notesController = TextEditingController();
  
  bool _isSubmitting = false;

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }
      
      await supabase.from('transfer_requests').insert({
        'user_id': userId,
        'amount': double.parse(_amountController.text),
        'sender_name': _senderNameController.text,
        'transfer_code': _transferCodeController.text,
        'notes': _notesController.text,
        'status': 'pending',
        'created_at': DateTime.now().toIso8601String(),
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إرسال طلب استلام الحوالة بنجاح'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'استلام حوالة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.account_balance_wallet, size: 60, color: AppTheme.goldPrimary),
              const SizedBox(height: 16),
              const Text('استلام حوالة مالية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('أدخل بيانات الحوالة لاستلامها', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
              const SizedBox(height: 32),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'المبلغ (ريال)', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال المبلغ' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senderNameController,
                decoration: const InputDecoration(labelText: 'اسم المرسل', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال اسم المرسل' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _transferCodeController,
                decoration: const InputDecoration(labelText: 'رمز الحوالة', prefixIcon: Icon(Icons.code), border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'الرجاء إدخال رمز الحوالة' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'ملاحظات إضافية', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
                  child: _isSubmitting ? const CircularProgressIndicator(strokeWidth: 2) : const Text('استلام الحوالة'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
