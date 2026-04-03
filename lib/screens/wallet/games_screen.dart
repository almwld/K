import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  final List<Map<String, dynamic>> _games = const [
    {'name': 'بلاي ستيشن', 'value': '10\$', 'price': '12,500', 'icon': Icons.sports_esports, 'color': 0xFF2196F3},
    {'name': 'بلاي ستيشن', 'value': '20\$', 'price': '25,000', 'icon': Icons.sports_esports, 'color': 0xFF2196F3},
    {'name': 'بلاي ستيشن', 'value': '50\$', 'price': '62,500', 'icon': Icons.sports_esports, 'color': 0xFF2196F3},
    {'name': 'ستيم', 'value': '10\$', 'price': '11,000', 'icon': Icons.games, 'color': 0xFF4CAF50},
    {'name': 'ستيم', 'value': '20\$', 'price': '22,000', 'icon': Icons.games, 'color': 0xFF4CAF50},
    {'name': 'ستيم', 'value': '50\$', 'price': '55,000', 'icon': Icons.games, 'color': 0xFF4CAF50},
    {'name': 'إكس بوكس', 'value': '10\$', 'price': '12,000', 'icon': Icons.games, 'color': 0xFFFF9800},
    {'name': 'إكس بوكس', 'value': '25\$', 'price': '30,000', 'icon': Icons.games, 'color': 0xFFFF9800},
    {'name': 'نينتندو', 'value': '20\$', 'price': '24,000', 'icon': Icons.games, 'color': 0xFFF44336},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'ألعاب وشحن'),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(game['color']).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(game['icon'], color: Color(game['color']), size: 40),
          ),
          const SizedBox(height: 12),
          Text(
            game['name'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            game['value'],
            style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            '${game['price']} ر.ي',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _buyGameCard(game),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('شراء'),
          ),
        ],
      ),
    );
  }

  void _buyGameCard(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشراء'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.sports_esports, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('شراء ${game['name']} - ${game['value']}'),
            const SizedBox(height: 8),
            Text('السعر: ${game['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(game);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
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
        title: const Text('تم الشراء بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شراء ${game['name']} - ${game['value']}'),
            const SizedBox(height: 8),
            Text('سيتم إرسال الكود إلى بريدك الإلكتروني'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
