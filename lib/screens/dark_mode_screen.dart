import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/theme_manager.dart';

class DarkModeScreen extends StatelessWidget {
  const DarkModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('المظهر', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: ListView(
        children: [
          _buildOption(
            context,
            title: 'فاتح',
            subtitle: 'مظهر فاتح خلال النهار',
            icon: Icons.light_mode,
            isSelected: !themeManager.isDarkMode,
            onTap: () => themeManager.setLightMode(),
          ),
          _buildOption(
            context,
            title: 'داكن',
            subtitle: 'مظهر داكن مريح للعين',
            icon: Icons.dark_mode,
            isSelected: themeManager.isDarkMode,
            onTap: () => themeManager.setDarkMode(),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('معاينة', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.binanceCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.binanceBorder),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.binanceGold,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, color: Colors.black),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('أحمد محمد', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                                Text('ahmed@flexyemen.com', style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade700, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.binanceGold.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.binanceGold),
      ),
      title: Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
      subtitle: Text(subtitle, style: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade700)),
      trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.binanceGold) : null,
      onTap: onTap,
    );
  }
}
