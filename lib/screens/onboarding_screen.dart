import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';
import 'home/main_navigation.dart';

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
      'title': 'مرحباً بك في فلكس يمن',
      'description': 'أول منصة يمنية تجمع بين التجارة الإلكترونية والمحفظة الرقمية',
      'icon': Icons.shopping_bag,
      'color': 0xFFD4AF37,
    },
    {
      'title': 'تسوق بكل سهولة',
      'description': 'تصفح آلاف المنتجات من مختلف الفئات وأضفها إلى سلة التسوق',
      'icon': Icons.search,
      'color': 0xFF4CAF50,
    },
    {
      'title': 'محفظة رقمية متكاملة',
      'description': 'حول الأموال، ادفع الفواتير، واشحن الرصيد بسهولة وأمان',
      'icon': Icons.account_balance_wallet,
      'color': 0xFF2196F3,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: _onboardingData.map((data) => _buildOnboardingPage(data)).toList(),
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingData.length,
              effect: WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: AppTheme.goldColor,
                dotColor: Colors.grey[400]!,
              ),
            ),
            const SizedBox(height: 20),
            _buildButtons(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(data['color']).withOpacity(0.1),
            ),
            child: Icon(data['icon'], size: 100, color: Color(data['color'])),
          ),
          const SizedBox(height: 40),
          Text(data['title'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(data['description'], style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.5), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
              child: const Text('السابق'),
            )
          else
            const SizedBox(width: 60),
          
          if (_currentPage == _onboardingData.length - 1)
            ElevatedButton(
              onPressed: _completeOnboarding,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('ابدأ الآن', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            )
          else
            ElevatedButton(
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('التالي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          
          if (_currentPage < _onboardingData.length - 1)
            TextButton(onPressed: _skipOnboarding, child: const Text('تخطي'))
          else
            const SizedBox(width: 60),
        ],
      ),
    );
  }

  void _skipOnboarding() async {
    await _setOnboardingSeen();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
  }

  void _completeOnboarding() async {
    await _setOnboardingSeen();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
  }

  Future<void> _setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }
}
