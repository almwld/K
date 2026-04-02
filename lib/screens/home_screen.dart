import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import 'home/widgets/golden_floating_button.dart';
import 'home/widgets/quick_commands_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // سلايدرات العروض - صور حقيقية من الإنترنت
  final List<Map<String, dynamic>> _carouselItems = [
    {
      'title': 'عرض العيد',
      'subtitle': 'خصومات تصل إلى 50%',
      'image': 'https://images.unsplash.com/photo-1606293926075-21a6300f46d7?w=800',
      'tag': 'عرض خاص',
    },
    {
      'title': 'مزاد الجنابي',
      'subtitle': 'أكبر مزاد للأسلحة التراثية',
      'image': 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?w=800',
      'tag': 'مزاد',
    },
    {
      'title': 'توصيل مجاني',
      'subtitle': 'لجميع طلبات اليوم',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800',
      'tag': 'عرض سريع',
    },
    {
      'title': 'عقارات مميزة',
      'subtitle': 'أفضل العروض العقارية',
      'image': 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=800',
      'tag': 'استثمار',
    },
  ];

  void _openApps() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم فتح التطبيقات قريباً')),
    );
  }

  void _openSettings() {
    Navigator.pushNamed(context, '/settings');
  }

  void _openCommands() {
    Navigator.pushNamed(context, '/all_ads');
  }

  void _openHistory() {
    Navigator.pushNamed(context, '/auctions');
  }

  void _executeQuickCommand(String command) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تنفيذ الأمر: $command')),
    );
  }

  void _onGoldenButtonTap() {
    // عند الضغط على الزر الذهبي، يمكن فتح قائمة أو تنفيذ إجراء
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم فتح القائمة السريعة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = Provider.of<AuthProvider>(context);

    final quickActions = [
      QuickAction(
        icon: Icons.apps,
        label: 'التطبيقات',
        color: Colors.cyan,
        onTap: _openApps,
      ),
      QuickAction(
        icon: Icons.settings,
        label: 'الإعدادات',
        color: Colors.purple,
        onTap: _openSettings,
      ),
      QuickAction(
        icon: Icons.shopping_bag,
        label: 'المتجر',
        color: Colors.green,
        onTap: _openCommands,
      ),
      QuickAction(
        icon: Icons.history,
        label: 'السجل',
        color: Colors.orange,
        onTap: _openHistory,
      ),
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // الترحيب
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: const Icon(Icons.person, color: AppTheme.goldColor),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً',
                              style: TextStyle(
                                color: AppTheme.getSecondaryTextColor(context),
                              ),
                            ),
                            Text(
                              authProvider.userName ?? 'ضيف',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // سلايدر الصور - بدون ألوان افتراضية
                  _buildImageCarousel(),

                  const SizedBox(height: 24),

                  // الأقسام السريعة
                  QuickCommandsGrid(
                    onCommandSelected: _executeQuickCommand,
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),

            // الزر الذهبي الدوار
            GoldenFloatingButton(
              onCommandSelected: _onGoldenButtonTap,
              actions: quickActions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _carouselItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        // صورة الخلفية من الإنترنت
                        CachedNetworkImage(
                          imageUrl: item['image'],
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                        // تراكب داكن لتحسين قراءة النص
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                        // النص فوق الصورة
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.goldColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item['tag'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['subtitle'],
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _carouselItems.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentIndex == entry.key
                    ? AppTheme.goldColor
                    : Colors.grey.withOpacity(0.5),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
