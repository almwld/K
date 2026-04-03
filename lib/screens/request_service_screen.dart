import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});

  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _detailsController = TextEditingController();
  
  String _selectedService = 'صيانة منزلية';
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _services = [
    {'name': 'صيانة منزلية', 'icon': Icons.handyman, 'price': 'يبدأ من 5000 ر.ي'},
    {'name': 'تنظيف', 'icon': Icons.cleaning_services, 'price': 'يبدأ من 3000 ر.ي'},
    {'name': 'سباكة', 'icon': Icons.plumbing, 'price': 'يبدأ من 4000 ر.ي'},
    {'name': 'كهرباء', 'icon': Icons.electrical_services, 'price': 'يبدأ من 4000 ر.ي'},
    {'name': 'تكييف', 'icon': Icons.ac_unit, 'price': 'يبدأ من 6000 ر.ي'},
    {'name': 'نقل عفش', 'icon': Icons.local_shipping, 'price': 'يبدأ من 8000 ر.ي'},
  ];
  
  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackBar('يرجى ملء جميع الحقول', Colors.red);
      return;
    }
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    
    _showSuccessDialog();
  }
  
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم إرسال الطلب!'),
        content: const Text('سيتم التواصل معك قريباً لتأكيد الطلب.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
  
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طلب خدمة'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // اختيار الخدمة
                  const Text('اختر الخدمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _services.length,
                    itemBuilder: (context, index) {
                      final service = _services[index];
                      final isSelected = _selectedService == service['name'];
                      return GestureDetector(
                        onTap: () => setState(() => _selectedService = service['name']),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : AppTheme.getCardColor(context),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(service['icon'], color: isSelected ? AppTheme.goldColor : Colors.grey, size: 28),
                              const SizedBox(height: 8),
                              Text(service['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(service['price'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // معلومات العميل
                  const Text('معلومات العميل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'رقم الجوال', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'العنوان', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 12),
                  TextFormField(controller: _detailsController, maxLines: 3, decoration: const InputDecoration(labelText: 'تفاصيل إضافية', border: OutlineInputBorder()), validator: (v) => v?.isEmpty == true ? 'مطلوب' : null),
                  const SizedBox(height: 32),
                  CustomButton(text: 'إرسال الطلب', onPressed: _submitRequest, isLoading: _isSubmitting),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(child: CircularProgressIndicator(color: AppTheme.goldColor)),
            ),
        ],
      ),
    );
  }
}
