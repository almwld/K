import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'home/main_navigation.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'contact_us_screen.dart';
import 'help_support_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.text = 'test@flexyemen.com';
    _passwordController.text = '123456';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
        (route) => false,
      );
    }
  }

  // ✅ دوال الاتصال
  Future<void> _callPhone() async {
    final Uri url = Uri.parse('tel:8001234567');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse('https://wa.me/9678001234567');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _openSupport() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                ),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      // الشعار
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'FLEX',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'YEMEN',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.goldLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'تسجيل الدخول إلى حسابك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 16,
                          color: AppTheme.getSecondaryTextColor(context),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // حقل البريد الإلكتروني
                      CustomTextField(
                        label: 'البريد الإلكتروني أو رقم الجوال',
                        hint: 'example@email.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال البريد الإلكتروني';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // حقل كلمة المرور
                      CustomTextField(
                        label: 'كلمة المرور',
                        hint: '********',
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      // نسيت كلمة المرور
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: AppTheme.gold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // زر تسجيل الدخول
                      CustomButton(
                        text: 'تسجيل الدخول',
                        onPressed: _login,
                      ),
                      const SizedBox(height: 16),
                      // إنشاء حساب جديد
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ليس لديك حساب؟ ',
                            style: TextStyle(
                              fontFamily: 'Changa',
                              color: AppTheme.getSecondaryTextColor(context),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const RegisterScreen()),
                              );
                            },
                            child: const Text(
                              'إنشاء حساب جديد',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: AppTheme.gold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // ✅ معلومات الاتصال - قابلة للضغط
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 📞 هاتف
                            GestureDetector(
                              onTap: _callPhone,
                              child: const Row(
                                children: [
                                  Icon(Icons.phone, size: 18, color: AppTheme.gold),
                                  SizedBox(width: 8),
                                  Text('800 123 4567', style: TextStyle(fontFamily: 'Changa', fontSize: 12)),
                                ],
                              ),
                            ),
                            // 🗺️ نقاط الخدمة
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.location_on, size: 18, color: AppTheme.gold),
                                  SizedBox(width: 8),
                                  Text('نقاط الخدمة', style: TextStyle(fontFamily: 'Changa', fontSize: 12)),
                                ],
                              ),
                            ),
                            // 🛟 الدعم الفني
                            GestureDetector(
                              onTap: _openSupport,
                              child: const Row(
                                children: [
                                  Icon(Icons.support_agent, size: 18, color: AppTheme.gold),
                                  SizedBox(width: 8),
                                  Text('الدعم الفني', style: TextStyle(fontFamily: 'Changa', fontSize: 12)),
                                ],
                              ),
                            ),
                            // 💬 واتساب
                            GestureDetector(
                              onTap: _openWhatsApp,
                              child: const Row(
                                children: [
                                  Icon(Icons.chat, size: 18, color: Colors.green),
                                  SizedBox(width: 8),
                                  Text('واتساب', style: TextStyle(fontFamily: 'Changa', fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
