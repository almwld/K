import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import 'home/widgets/golden_floating_button.dart';
import 'home/widgets/glowing_brain.dart';
import 'home/widgets/voice_visualizer.dart';
import 'home/widgets/quick_commands_grid.dart';
import 'ad_detail_screen.dart';
import 'all_ads_screen.dart';
import 'auctions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

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
            // المحتوى الرئيسي
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

                  // العروض
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'عروض العيد',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'خصومات تصل إلى 50% على جميع المنتجات',
                          style: TextStyle(color: Colors.black87),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/all_ads'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppTheme.goldColor,
                          ),
                          child: const Text('تسوق الآن'),
                        ),
                      ],
                    ),
                  ),

                  // الأقسام السريعة
                  const QuickCommandsGrid(
                    onCommandSelected: null,
                  ),
                ],
              ),
            ),

            // الزر الذهبي الدوار
            GoldenFloatingButton(
              onCommandSelected: _executeQuickCommand,
              actions: quickActions,
            ),
          ],
        ),
      ),
    );
  }
}
