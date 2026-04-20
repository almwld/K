import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.gold.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                size: 60,
                color: AppTheme.gold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'محفظتك',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'الرصيد: 0 ر.ي',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                color: AppTheme.getSecondaryTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

