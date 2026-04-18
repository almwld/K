import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> apps = [
      {'name': 'Google Play', 'value': '10 USD', 'price': '11,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'color': 0xFF4CAF50, 'category': 'متاجر'},
      {'name': 'Google Play', 'value': '25 USD', 'price': '28,750', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'color': 0xFF4CAF50, 'category': 'متاجر'},
      {'name': 'App Store', 'value': '10 USD', 'price': '12,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'color': 0xFF9C27B0, 'category': 'متاجر'},
      {'name': 'Spotify', 'value': 'شهر', 'price': '8,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'موسيقى'},
      {'name': 'Netflix', 'value': 'شهر Basic', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
      {'name': 'Steam', 'value': '10 USD', 'price': '11,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    ];

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تطبيقات وخدمات رقمية'),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 12, mainAxisSpacing: 12),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return _buildAppCard(context, app);
        },
      ),
    );
  }

  Widget _buildAppCard(BuildContext context, Map<String, dynamic> app) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 70, height: 70, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Color(app['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: CachedNetworkImage(imageUrl: app['image'], placeholder: (_, __) => Icon(Icons.apps, color: Color(app['color']), size: 40),
              errorWidget: (_, __, ___) => Icon(Icons.apps, color: Color(app['color']), size: 40))),
          const SizedBox(height: 12),
          Text(app['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(app['value'], style: TextStyle(color: AppTheme.goldLight, fontWeight: FontWeight.bold, fontSize: 12)),
          Text('${app['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Color(app['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Text(app['category'], style: TextStyle(color: Color(app['color']), fontSize: 10))),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () => _buyApp(context, app), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('شراء', style: TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  void _buyApp(BuildContext context, Map<String, dynamic> app) {
    showDialog(context: context, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('تأكيد الشراء'),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [const Icon(Icons.check_circle, size: 60, color: Colors.green), const SizedBox(height: 16),
          Text('شراء ${app['name']} - ${app['value']}'), Text('السعر: ${app['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(context, app); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight), child: const Text('تأكيد'))]));
  }

  void _showSuccessDialog(BuildContext context, Map<String, dynamic> app) {
    showDialog(context: context, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('تم الشراء بنجاح'),
      content: Column(mainAxisSize: MainAxisSize.min,
        children: [const Icon(Icons.check_circle, color: Colors.green, size: 60), const SizedBox(height: 16),
          Text('تم شراء ${app['name']} - ${app['value']}'), const Text('سيتم إرسال الكود إلى بريدك الإلكتروني')]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))]));
  }
}
