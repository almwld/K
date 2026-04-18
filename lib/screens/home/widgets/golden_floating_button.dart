import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../add_ad_screen.dart';
import '../../seller_products_screen.dart';
import '../../request_service_screen.dart';
import '../../receive_transfer_request_screen.dart';

class GoldenFloatingButton extends StatelessWidget {
  const GoldenFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppTheme.gold,
      child: const Icon(Icons.add, color: Colors.black, size: 30),
      onPressed: () => _showGoldenMenu(context),
    );
  }

  void _showGoldenMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ماذا تريد أن تفعل؟', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton(context, Icons.campaign, 'إضافة إعلان', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAdScreen()))),
                _buildMenuButton(context, Icons.shopping_bag, 'إضافة منتج', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SellerProductsScreen()))),
                _buildMenuButton(context, Icons.help, 'طلب خدمة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RequestServiceScreen()))),
                _buildMenuButton(context, Icons.account_balance_wallet, 'استلام حوالة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReceiveTransferRequestScreen()))),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.gold, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
