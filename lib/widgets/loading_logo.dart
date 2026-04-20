import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingLogo extends StatelessWidget {
  final String text;
  final String? animationAsset;
  
  const LoadingLogo({
    super.key,
    this.text = 'جاري التحميل...',
    this.animationAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark 
              ? Colors.grey[900] 
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              animationAsset ?? 'assets/animations/loading_logo.json',
              width: 120,
              height: 120,
              repeat: true,
            ),
            const SizedBox(height: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

