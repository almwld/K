import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'تسوق بسهولة',
      'description': 'اكتشف آلاف المنتجات من المتاجر المحلية والعالمية',
      'icon': 'cart',
      'color': const Color(0xFF2196F3),
    },
    {
      'title': 'ادفع بأمان',
      'description': 'طرق دفع متعددة وآمنة تناسب جميع احتياجاتك',
      'icon': 'wallet',
      'color': const Color(0xFF4CAF50),
    },
    {
      'title': 'توصيل سريع',
      'description': 'نوصل طلباتك إلى باب منزلك في أسرع وقت',
      'icon': 'shipping',
      'color': const Color(0xFFFF9800),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text(
                  'تخطي',
                  style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              data['color'] as Color,
                              (data['color'] as Color).withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/svg/${data['icon']}.svg',
                            width: 80,
                            height: 80,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        data['title'] as String,
                        style: const TextStyle(
                          fontFamily: 'Changa',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          data['description'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Changa',
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingData.length,
              effect: WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: const Color(0xFFD4AF37),
                dotColor: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFD4AF37)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('إنشاء حساب', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
