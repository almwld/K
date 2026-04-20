import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    this.title,
    this.showLogo = false,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: backgroundColor ?? (isDark ? AppTheme.nightSurface : AppTheme.lightSurface),
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: leading ?? (showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null),
      title: showLogo
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.gold, AppTheme.goldLight],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shopping_bag,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'FLEX YEMEN',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.gold,
                  ),
                ),
              ],
            )
          : title != null
              ? Text(
                  title!,
                  style: const TextStyle(
                    fontFamily: 'Changa',
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
      actions: actions ?? [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => Navigator.pushNamed(context, '/search'),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      automaticallyImplyLeading: showBackButton,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

