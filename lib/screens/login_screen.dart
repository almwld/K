import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'home/main_navigation.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _userType = 'customer';
  
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _userType = _tabController.index == 0 ? 'customer' : 'merchant';
      });
    });
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  bool _isPhoneNumber(String input) {
    return RegExp(r'^[0-9]{9,15}$').hasMatch(input);
  }

  bool _isEmail(String input) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الجوال أو البريد الإلكتروني';
    }
    if (!_isPhoneNumber(value) && !_isEmail(value)) {
      return 'الرجاء إدخال رقم جوال صحيح أو بريد إلكتروني صحيح';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signIn(
      _identifierController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
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

  Future<void> _openWhatsApp() async {
    const url = 'https://wa.me/967777777777';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<void> _callTollFree() async {
    const url = 'tel:8001234567';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // Logo and Title
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppTheme.goldGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.goldPrimary.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Flex Yemen',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تسجيل الدخول إلى حسابك',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // User Type Tabs
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.navyCard : Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: AppTheme.goldGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.goldPrimary.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  unselectedLabelStyle: const TextStyle(fontSize: 16),
                  tabs: const [
                    Tab(text: 'عميل'),
                    Tab(text: 'تاجر'),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Phone/Email Field
                    TextFormField(
                      controller: _identifierController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'رقم الجوال أو البريد الإلكتروني',
                        hintText: 'سجل رقمك أو بريدك الإلكتروني',
                        prefixIcon: const Icon(Icons.person_outline, color: AppTheme.goldPrimary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: isDark ? AppTheme.navyCard : Colors.grey[50],
                      ),
                      validator: _validateIdentifier,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.goldPrimary),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: isDark ? AppTheme.navyCard : Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                          );
                        },
                        child: Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(color: AppTheme.goldPrimary),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'تسجيل الدخول${_userType == 'merchant' ? ' كتاجر' : ''}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ليس لديك حساب؟ ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            'إنشاء حساب جديد',
                            style: TextStyle(
                              color: AppTheme.goldPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Footer with SVG Icons
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // WhatsApp
                    _buildFooterItem(
                      iconPath: 'assets/icons/svg/whatsapp.svg',
                      label: 'واتساب',
                      onTap: _openWhatsApp,
                    ),
                    
                    // Service Points
                    _buildFooterItem(
                      iconPath: 'assets/icons/svg/service_points.svg',
                      label: 'نقاط الخدمة',
                      onTap: () {
                        // Navigate to service points
                      },
                    ),
                    
                    // Toll Free
                    _buildFooterItem(
                      iconPath: 'assets/icons/svg/toll_free.svg',
                      label: '800 123 4567',
                      onTap: _callTollFree,
                    ),
                    
                    // Email
                    _buildFooterItem(
                      iconPath: 'assets/icons/svg/email.svg',
                      label: 'الدعم الفني',
                      onTap: () {
                        // Open email
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterItem({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 28,
            height: 28,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
