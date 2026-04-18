import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class IdentityInfoScreen extends StatefulWidget {
  final dynamic userData;
  
  const IdentityInfoScreen({super.key, this.userData});

  @override
  State<IdentityInfoScreen> createState() => _IdentityInfoScreenState();
}

class _IdentityInfoScreenState extends State<IdentityInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // حقول الهوية
  final _fullNameController = TextEditingController();
  final _nationalIdController = TextEditingController();
  final _addressController = TextEditingController();
  
  String? _selectedGender;
  String? _selectedCity;
  
  bool _isLoading = false;
  
  final List<String> _genders = ['ذكر', 'أنثى'];
  final List<String> _cities = [
    'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 
    'ذمار', 'صعدة', 'عمران', 'حجة', 'المحويت', 'مارب',
    'الجوف', 'شبوة', 'حضرموت', 'سقطرى', 'البيضاء', 'لحج',
    'أبين', 'الضالع', 'ريمة'
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _nationalIdController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitIdentityInfo() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // محاكاة حفظ البيانات
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isLoading = false);
    
    // عرض رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ بيانات الهوية بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
    
    // الانتقال إلى الشاشة الرئيسية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'بيانات الهوية'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.gold.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    size: 40,
                    color: AppTheme.gold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'الرجاء إدخال بيانات هويتك',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'هذه البيانات ضرورية لتأكيد هويتك',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              
              // الاسم الكامل
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم الكامل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // الرقم الوطني
              TextFormField(
                controller: _nationalIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'رقم الهوية الوطنية',
                  prefixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال رقم الهوية';
                  }
                  if (value.length < 9) {
                    return 'رقم الهوية يجب أن يكون 9 أرقام على الأقل';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // الجنس
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'الجنس',
                  prefixIcon: Icon(Icons.people_outline),
                  border: OutlineInputBorder(),
                ),
                items: _genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedGender = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار الجنس';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // المدينة
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'المدينة',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCity = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار المدينة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // العنوان التفصيلي
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'العنوان التفصيلي',
                  prefixIcon: Icon(Icons.home_outlined),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // زر المتابعة
              CustomButton(
                text: 'تأكيد وحفظ',
                onPressed: _submitIdentityInfo,
                isLoading: _isLoading,
              ),
              
              const SizedBox(height: 20),
              
              // نص توضيحي
              Center(
                child: Text(
                  'سيتم استخدام هذه البيانات لتأكيد هويتك',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[500] : Colors.grey[400],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
