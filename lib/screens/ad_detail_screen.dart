import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../widgets/simple_app_bar.dart';
import 'checkout_screen.dart';
import 'chat_screen.dart';

class AdDetailScreen extends StatelessWidget {
  final ProductModel? product;
  const AdDetailScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = product;

    if (p == null) {
      return Scaffold(
        appBar: const SimpleAppBar(title: 'تفاصيل الإعلان'),
        body: const Center(child: Text('لا توجد بيانات')),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: p.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: p.images.first,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(height: 250, color: AppTheme.goldColor.withOpacity(0.1)),
                errorWidget: (_, __, ___) => Container(height: 250, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image, size: 50)),
              ),
            ),
            const SizedBox(height: 16),
            Text(p.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '${p.price.toStringAsFixed(0)} ر.ي',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(p.city),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text('${p.rating}'),
                    const SizedBox(width: 8),
                    const Icon(Icons.remove_red_eye, size: 16),
                    const SizedBox(width: 4),
                    const Text('128'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              p.description.isNotEmpty ? p.description : 'منتج مميز وجودة عالية. مناسب للاستخدام اليومي. متوفر بأسعار منافسة.',
              style: TextStyle(height: 1.5, color: AppTheme.getSecondaryTextColor(context)),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                    child: Text(p.sellerName[0], style: const TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('بائع موثوق', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('متابعة'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('شراء الآن'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const ChatScreen()),
                      );
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('محادثة'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.goldColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
