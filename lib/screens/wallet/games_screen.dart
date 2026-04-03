import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final List<Map<String, dynamic>> _games = [
    {'name': 'ببجي موبايل', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '2,500', 'currency': 'UC', 'category': 'شحن'},
    {'name': 'فري فاير', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '1,500', 'currency': 'دايموند', 'category': 'شحن'},
    {'name': 'كول أوف ديوتي', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '3,000', 'currency': 'CP', 'category': 'شحن'},
    {'name': 'ببجي موبايل', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '5,000', 'currency': 'UC', 'category': 'شحن'},
    {'name': 'فري فاير', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '3,000', 'currency': 'دايموند', 'category': 'شحن'},
    {'name': 'كول أوف ديوتي', 'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200', 'price': '6,000', 'currency': 'CP', 'category': 'شحن'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الألعاب'),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          return _buildGameCard(game);
        },
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return GestureDetector(
      onTap: () {
        _showPurchaseDialog(game);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                game['image'],
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(Icons.games, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${game['price']} ${game['currency']}',
                    style: TextStyle(
                      color: AppTheme.goldColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseDialog(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('شحن ${game['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.games, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            Text('القيمة: ${game['price']} ${game['currency']}'),
            const SizedBox(height: 8),
            const Text('سيتم إضافة الرصيد فوراً', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(game);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('شحن الآن'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشحن بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شحن ${game['name']}'),
            Text('بمبلغ ${game['price']} ${game['currency']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
