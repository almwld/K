import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
 Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> games = [
      {'name': 'بلاي ستيشن', 'value': '10 USD', 'price': '12,500', 'icon': Icons.sports_esports, 'color': 0xFF2196F3},
      {'name': 'بلاي ستيشن', 'value': '25 USD', 'price': '31,250', 'icon': Icons.sports_esports, 'color': 0xFF2196F3},
      {'name': 'ستيم', 'value': '10 USD', 'price': '11,000', 'icon': Icons.games, 'color': 0xFF4CAF50},
      {'name': 'ستيم', 'value': '25 USD', 'price': '27,500', 'icon': Icons.games, 'color': 0xFF4CAF50},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'ألعاب وشحن'),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return _buildGameCard(context, game);
        },
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, Map<String, dynamic> game) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Color(game['color']).withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(game['icon'], color: Color(game['color']), size: 40)),
          const SizedBox(height: 12),
          Text(game['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(game['value'], style: TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text('${game['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () => _buyGame(context, game), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('شراء')),
        ],
      ),
    );
  }

  void _buyGame(BuildContext context, Map<String, dynamic> game) {
    showDialog(context: context, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('تأكيد الشراء'),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [const Icon(Icons.sports_esports, size: 60, color: Colors.green), const SizedBox(height: 16),
          Text('شراء ${game['name']} - ${game['value']}'), Text('السعر: ${game['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(context, game); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent), child: const Text('تأكيد'))]));
  }

  void _showSuccessDialog(BuildContext context, Map<String, dynamic> game) {
    showDialog(context: context, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('تم الشراء بنجاح'),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [const Icon(Icons.check_circle, color: Colors.green, size: 60), const SizedBox(height: 16),
          Text('تم شراء ${game['name']} - ${game['value']}'), const Text('سيتم إرسال الكود إلى بريدك الإلكتروني')]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))]));
  }
}
