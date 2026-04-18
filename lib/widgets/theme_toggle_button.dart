import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;
  
  const ThemeToggleButton({
    super.key,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    
    return IconButton(
      onPressed: () => themeManager.toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Icon(
          themeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(themeManager.isDarkMode),
          color: Theme.of(context).primaryColor,
        ),
      ),
      tooltip: themeManager.isDarkMode ? 'الوضع النهاري' : 'الوضع الليلي',
    );
  }
}

// زر متقدم مع قائمة منبثقة للأوضاع الثلاثة
class ThemeMenuButton extends StatelessWidget {
  const ThemeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    
    return PopupMenuButton<ThemeMode>(
      onSelected: (mode) => themeManager.setThemeMode(mode),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ThemeMode.light,
          child: Row(
            children: [
              const Icon(Icons.light_mode, color: AppTheme.gold),
              const SizedBox(width: 12),
              const Text('نهاري'),
              if (!themeManager.isDarkMode) ...[
                const Spacer(),
                const Icon(Icons.check, color: AppTheme.gold, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.dark,
          child: Row(
            children: [
              const Icon(Icons.dark_mode, color: AppTheme.navyGold),
              const SizedBox(width: 12),
              const Text('داكن'),
              if (themeManager.isDarkMode) ...[
                const Spacer(),
                const Icon(Icons.check, color: AppTheme.navyGold, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: ThemeMode.system,
          child: Row(
            children: [
              Icon(Icons.settings_suggest, color: Colors.grey[600]),
              const SizedBox(width: 12),
              const Text('النظام'),
              if (themeManager.isSystemMode) ...[
                const Spacer(),
                Icon(Icons.check, color: Colors.grey[600], size: 18),
              ],
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          themeManager.modeIcon,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
