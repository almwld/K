import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_manager.dart';
import '../services/theme_service.dart';
import '../widgets/simple_app_bar.dart';

class ThemeSelectionScreen extends StatelessWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = context.watch<ThemeManager>();
    final modes = AppThemeMode.values;

    return Scaffold(
      appBar: const SimpleAppBar(title: 'اختر مظهر المنصة'),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: modes.length,
        itemBuilder: (context, index) {
          final mode = modes[index];
          final isSelected = themeManager.currentMode == mode;
          
          return _buildThemeCard(
            context: context,
            mode: mode,
            isSelected: isSelected,
            onTap: () => themeManager.setThemeMode(mode),
          );
        },
      ),
    );
  }

  Widget _buildThemeCard({
    required BuildContext context,
    required AppThemeMode mode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final primaryColor = ThemeService.primaryColors[mode]!;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ] : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                ThemeService.modeIcons[mode],
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              ThemeService.modeNames[mode]!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primaryColor : null,
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.check_circle,
                  color: primaryColor,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
