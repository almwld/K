import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingDialog({super.key, this.message, this.size = 80});

  static Future<void> show(
    BuildContext context, {
    String? message,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => LoadingDialog(message: message),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // شعار Lottie متحرك
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Lottie.asset(
                'assets/animations/loading_logo.json',
                width: size,
                height: size,
                repeat: true,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.gold, width: 3),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

