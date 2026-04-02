import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? leading;
  final Color? backgroundColor;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,  // تغيير القيمة الافتراضية إلى false
    this.onBackPressed,
    this.leading,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor ?? (isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
      automaticallyImplyLeading: false,  // إخفاء زر الرجوع التلقائي
      leading: leading,  // استخدام الـ leading المخصص فقط
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
