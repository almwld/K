import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedService = 'صيانة منزلية';
  bool _isUrgent = false;
  bool _isLoading = false;

  final List<String> _services = [
    'صيانة منزلية',
    'تنظيف',
    'سباكة',
    'كهرباء',
    'دهان',
    'نقل عفش',
    'تصليح أجهزة',
  ];

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلب الخدمة بنجاح!'), backgroundColor: AppTheme.binanceGreen),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('طلب خدمة', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'الاسم الكامل',
                        prefixIcon: Icon(Icons.person, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال الاسم' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'رقم الهاتف',
                        prefixIcon: Icon(Icons.phone, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v!.isEmpty ? 'يرجى إدخال رقم الهاتف' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() => _selectedService = v!),
                      decoration: const InputDecoration(
                        labelText: 'نوع الخدمة',
                        prefixIcon: Icon(Icons.handyman, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'تفاصيل الطلب',
                        prefixIcon: Icon(Icons.description, color: AppTheme.binanceGold),
                        filled: true,
                        fillColor: Color(0xFF1E2329),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('طلب مستعجل'),
                      value: _isUrgent,
                      onChanged: (v) => setState(() => _isUrgent = v),
                      activeColor: AppTheme.binanceGold,
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
                        child: const Text('إرسال الطلب', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
