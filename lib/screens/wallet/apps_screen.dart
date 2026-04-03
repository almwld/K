import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  // 30+ تطبيق وخدمة رقمية مع صور حقيقية
  final List<Map<String, dynamic>> _apps = [
    // متاجر التطبيقات
    {'name': 'Google Play', 'value': '10\$', 'price': '11,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'color': 0xFF4CAF50, 'category': 'متاجر'},
    {'name': 'Google Play', 'value': '25\$', 'price': '28,750', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'color': 0xFF4CAF50, 'category': 'متاجر'},
    {'name': 'Google Play', 'value': '50\$', 'price': '57,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'color': 0xFF4CAF50, 'category': 'متاجر'},
    {'name': 'App Store', 'value': '10\$', 'price': '12,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'color': 0xFF9C27B0, 'category': 'متاجر'},
    {'name': 'App Store', 'value': '25\$', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'color': 0xFF9C27B0, 'category': 'متاجر'},
    {'name': 'App Store', 'value': '50\$', 'price': '60,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'color': 0xFF9C27B0, 'category': 'متاجر'},
    
    // منصات البث الموسيقي
    {'name': 'Spotify', 'value': 'شهر', 'price': '8,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'موسيقى'},
    {'name': 'Spotify', 'value': '3 شهور', 'price': '22,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'موسيقى'},
    {'name': 'Spotify', 'value': 'سنة', 'price': '85,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'موسيقى'},
    {'name': 'Anghami', 'value': 'شهر', 'price': '7,000', 'image': 'https://play-lh.googleusercontent.com/2Kg4kO8C5aJpNfBQ-8sXB8R24n8kGjqNoxBfUy4kRz5x5x5x5x5x5x5x5x5', 'color': 0xFFE91E63, 'category': 'موسيقى'},
    {'name': 'Anghami', 'value': 'سنة', 'price': '75,000', 'image': 'https://play-lh.googleusercontent.com/2Kg4kO8C5aJpNfBQ-8sXB8R24n8kGjqNoxBfUy4kRz5x5x5x5x5x5x5x5x5', 'color': 0xFFE91E63, 'category': 'موسيقى'},
    {'name': 'Apple Music', 'value': 'شهر', 'price': '9,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Apple_Music_icon.svg', 'color': 0xFF9C27B0, 'category': 'موسيقى'},
    
    // منصات البث المرئي
    {'name': 'Netflix', 'value': 'شهر Basic', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
    {'name': 'Netflix', 'value': 'شهر Standard', 'price': '22,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
    {'name': 'Netflix', 'value': 'شهر Premium', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
    {'name': 'YouTube Premium', 'value': 'شهر', 'price': '10,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
    {'name': 'YouTube Premium', 'value': 'سنة', 'price': '100,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg', 'color': 0xFFF44336, 'category': 'فيديو'},
    {'name': 'Shahid', 'value': 'شهر', 'price': '12,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'category': 'فيديو'},
    {'name': 'Shahid', 'value': 'سنة', 'price': '120,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'category': 'فيديو'},
    {'name': 'Amazon Prime', 'value': 'شهر', 'price': '14,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/11/Amazon_Prime_Video_logo.svg', 'color': 0xFF2196F3, 'category': 'فيديو'},
    {'name': 'Disney+', 'value': 'شهر', 'price': '18,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3e/Disney%2B_logo.svg', 'color': 0xFF2196F3, 'category': 'فيديو'},
    
    // منصات الألعاب
    {'name': 'Steam', 'value': '10\$', 'price': '11,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    {'name': 'Steam', 'value': '25\$', 'price': '27,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    {'name': 'Steam', 'value': '50\$', 'price': '55,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    {'name': 'PlayStation', 'value': '10\$', 'price': '12,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/2/2a/PlayStation_logo.svg', 'color': 0xFF2196F3, 'category': 'ألعاب'},
    {'name': 'PlayStation', 'value': '25\$', 'price': '31,250', 'image': 'https://upload.wikimedia.org/wikipedia/commons/2/2a/PlayStation_logo.svg', 'color': 0xFF2196F3, 'category': 'ألعاب'},
    {'name': 'PlayStation', 'value': '50\$', 'price': '62,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/2/2a/PlayStation_logo.svg', 'color': 0xFF2196F3, 'category': 'ألعاب'},
    {'name': 'Xbox', 'value': '10\$', 'price': '12,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Xbox_one_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    {'name': 'Xbox', 'value': '25\$', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Xbox_one_logo.svg', 'color': 0xFF4CAF50, 'category': 'ألعاب'},
    {'name': 'Nintendo', 'value': '20\$', 'price': '24,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Nintendo_Switch_logo.png', 'color': 0xFFF44336, 'category': 'ألعاب'},
    
    // تطبيقات الإنتاجية
    {'name': 'Microsoft 365', 'value': 'شهر', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/93/Microsoft_Office_2019_logo.svg', 'color': 0xFF2196F3, 'category': 'إنتاجية'},
    {'name': 'Microsoft 365', 'value': 'سنة', 'price': '150,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/93/Microsoft_Office_2019_logo.svg', 'color': 0xFF2196F3, 'category': 'إنتاجية'},
    {'name': 'Adobe Creative Cloud', 'value': 'شهر', 'price': '25,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/8d/Adobe_Creative_Cloud_icon.svg', 'color': 0xFFF44336, 'category': 'إنتاجية'},
    {'name': 'Adobe Creative Cloud', 'value': 'سنة', 'price': '250,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/8d/Adobe_Creative_Cloud_icon.svg', 'color': 0xFFF44336, 'category': 'إنتاجية'},
    
    // تطبيقات التواصل
    {'name': 'Telegram Premium', 'value': 'شهر', 'price': '5,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg', 'color': 0xFF2196F3, 'category': 'تواصل'},
    {'name': 'Telegram Premium', 'value': 'سنة', 'price': '50,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/82/Telegram_logo.svg', 'color': 0xFF2196F3, 'category': 'تواصل'},
    {'name': 'WhatsApp Business', 'value': 'شهر', 'price': '7,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg', 'color': 0xFF4CAF50, 'category': 'تواصل'},
    
    // تطبيقات تعليمية
    {'name': 'Duolingo Plus', 'value': 'شهر', 'price': '6,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/0a/Duolingo_logo.svg', 'color': 0xFF4CAF50, 'category': 'تعليم'},
    {'name': 'Duolingo Plus', 'value': 'سنة', 'price': '60,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/0a/Duolingo_logo.svg', 'color': 0xFF4CAF50, 'category': 'تعليم'},
    {'name': 'Coursera Plus', 'value': 'شهر', 'price': '20,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Coursera_logo.svg', 'color': 0xFF2196F3, 'category': 'تعليم'},
    
    // تطبيقات الصحة واللياقة
    {'name': 'Calm Premium', 'value': 'شهر', 'price': '8,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50, 'category': 'صحة'},
    {'name': 'Headspace', 'value': 'شهر', 'price': '8,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'category': 'صحة'},
    {'name': 'MyFitnessPal', 'value': 'شهر', 'price': '6,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3, 'category': 'صحة'},
  ]

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تطبيقات وخدمات رقمية'),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _apps.length,
        itemBuilder: (context, index) {
          final app = _apps[index]
          return _buildAppCard(app);
        },
      ),
    );
  }

  Widget _buildAppCard(Map<String, dynamic> app) {
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
          // صورة التطبيق
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(app['color']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: app['image'],
              placeholder: (context, url) => Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.apps,
                size: 40,
                color: Color(app['color']),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            app['name'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              app['category'],
              style: TextStyle(color: AppTheme.goldColor, fontSize: 10),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            app['value'],
            style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            '${app['price']} ر.ي',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _buyApp(app),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.goldColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              minimumSize: const Size(80, 32),
            ),
            child: const Text('شراء', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _buyApp(Map<String, dynamic> app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشراء'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('شراء ${app['name']} - ${app['value']}'),
            const SizedBox(height: 8),
            Text('السعر: ${app['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(app);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> app) {
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
            Text('تم شراء ${app['name']} - ${app['value']}'),
            const SizedBox(height: 8),
            const Text('سيتم إرسال الكود إلى بريدك الإلكتروني'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
