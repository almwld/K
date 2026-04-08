import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/simple_app_bar.dart';
import 'identity_info_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String _userType = 'customer';
  bool _agreeToTerms = false;

  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء جميع الحقول')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمتا المرور غير متطابقتين')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى الموافقة على الشروط والأحكام')),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    final userData = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      userType: _userType,
    );

    await context.read<AuthProvider>().login(userData);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => IdentityInfoScreen(userData: userData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إنشاء حساب'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'إنشاء حساب جديد',
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.getTextColor(context),
                ),
              ).animate().fadeIn().slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                'أدخل بياناتك الأساسية، ثم سنطلب منك إكمال بيانات الهوية',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.getSecondaryTextColor(context),
                ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _UserTypeCard(
                      title: 'عميل',
                      subtitle: 'للشراء والتصفح',
                      icon: Icons.shopping_bag_outlined,
                      isSelected: _userType == 'customer',
                      onTap: () => setState(() => _userType = 'customer'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _UserTypeCard(
                      title: 'تاجر',
                      subtitle: 'للبيع والتسويق',
                      icon: Icons.store_outlined,
                      isSelected: _userType == 'merchant',
                      onTap: () => setState(() => _userType = 'merchant'),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'الاسم الكامل',
                controller: _nameController,
                prefixIcon: const Icon(Icons.person_outline),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'البريد الإلكتروني',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'رقم الهاتف',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 16),
              PasswordTextField(
                controller: _passwordController,
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 16),
              PasswordTextField(
                label: 'تأكيد كلمة المرور',
                controller: _confirmPasswordController,
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                    activeColor: AppTheme.goldColor,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'أوافق على ',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TermsScreen())),
                          child: const Text(
                            'الشروط والأحكام',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.goldColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 700.ms),
              const SizedBox(height: 24),
              CustomButton(
                text: 'متابعة',
                onPressed: _register,
                isLoading: _isLoading,
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك حساب بالفعل؟',
                    style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: AppTheme.goldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 900.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _UserTypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppTheme.goldColor, AppTheme.goldLight],
                )
              : null,
          color: isSelected ? null : AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? null
              : Border.all(
                  color: AppTheme.getDividerColor(context),
                  width: 1,
                ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.black : AppTheme.goldColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : AppTheme.getTextColor(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? Colors.black.withOpacity(0.7)
                    : AppTheme.getSecondaryTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// إضافة حقول تاريخ الميلاد وتاريخ الإصدار
// أضف هذه المتغيرات في بداية class _RegisterScreenState:

DateTime? _selectedBirthDate;
DateTime? _selectedIssueDate;
String? _selectedGender;

// أضف هذه الدوال:
Future<void> _selectBirthDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
    locale: const Locale('ar', 'YE'),
  );
  if (picked != null && picked != _selectedBirthDate) {
    setState(() => _selectedBirthDate = picked);
  }
}

Future<void> _selectIssueDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime.now(),
    locale: const Locale('ar', 'YE'),
  );
  if (picked != null && picked != _selectedIssueDate) {
    setState(() => _selectedIssueDate = picked);
  }
}

// أضف هذه الحقول في مكانها المناسب داخل build:
/*
const SizedBox(height: 16),
GestureDetector(
  onTap: () => _selectBirthDate(context),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(Icons.cake, color: AppTheme.goldColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            _selectedBirthDate == null
                ? 'تاريخ الميلاد'
                : '${_selectedBirthDate!.year}/${_selectedBirthDate!.month}/${_selectedBirthDate!.day}',
            style: TextStyle(
              color: _selectedBirthDate == null ? Colors.grey : AppTheme.getTextColor(context),
            ),
          ),
        ),
        const Icon(Icons.calendar_today, size: 18),
      ],
    ),
  ),
),
const SizedBox(height: 16),
GestureDetector(
  onTap: () => _selectIssueDate(context),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(Icons.assignment, color: AppTheme.goldColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            _selectedIssueDate == null
                ? 'تاريخ إصدار الهوية'
                : '${_selectedIssueDate!.year}/${_selectedIssueDate!.month}/${_selectedIssueDate!.day}',
            style: TextStyle(
              color: _selectedIssueDate == null ? Colors.grey : AppTheme.getTextColor(context),
            ),
          ),
        ),
        const Icon(Icons.calendar_today, size: 18),
      ],
    ),
  ),
),
*/
