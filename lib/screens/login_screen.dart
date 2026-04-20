import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
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

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _userType = 'customer';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _emailController.text = 'test@flexyemen.com';
    _passwordController.text = '123456';
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _userType = _tabController.index == 0 ? 'customer' : 'merchant';
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error ?? 'فشل تسجيل الدخول'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loginAsGuest() async {
    final authProvider = context.read<AuthProvider>();
    authProvider.loginAsGuest();
    
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigation()),
      (route) => false,
    );
  }

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
                      const SizedBox(height: 20),
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
                      
                      // تبويبات عميل / تاجر
                      Container(
                        height: 55,
                        margin: const EdgeInsets.only(top: 16, bottom: 8),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            gradient: AppTheme.goldGradient,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.black,
                          unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
                          labelStyle: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 14,
                          ),
                          tabs: const [
                            Tab(text: 'عميل'),
                            Tab(text: 'تاجر'),
                          ],
                        ),
                      ),
                      
                      Text(
                        _userType == 'customer' 
                            ? 'تسجيل الدخول كعميل' 
                            : 'تسجيل الدخول كتاجر',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 14,
                          color: AppTheme.getSecondaryTextColor(context),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
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
                          TextButton(
                            onPressed: _loginAsGuest,
                            child: const Text(
                              'الدخول كضيف',
                              style: TextStyle(
                                fontFamily: 'Changa',
                                color: AppTheme.gold,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: _userType == 'customer' ? 'تسجيل دخول عميل' : 'تسجيل دخول تاجر',
                        onPressed: _login,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildContactItem(
                              icon: Icons.support_agent,
                              label: 'الدعم الفني',
                              onTap: _openSupport,
                            ),
                            _buildContactItem(
                              icon: Icons.phone,
                              label: '800 123 4567',
                              onTap: _callPhone,
                            ),
                            _buildContactItem(
                              icon: Icons.location_on,
                              label: 'نقاط الخدمة',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                                );
                              },
                            ),
                            _buildContactItem(
                              icon: Icons.chat,
                              label: 'واتساب',
                              onTap: _openWhatsApp,
                              iconColor: Colors.green,
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

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (iconColor ?? AppTheme.gold).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor ?? AppTheme.gold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
