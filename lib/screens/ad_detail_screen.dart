import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../widgets/simple_app_bar.dart';
import 'checkout_screen.dart';
import 'chat_screen.dart';
import 'ai_chat_assistant.dart';

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
                errorWidget: (_, __, ___) => Container(height: 250, color: AppTheme.goldColor.withOpacity(0.1), child: const Icon(Icons.image)),
              ),
            ),
            const SizedBox(height: 16),
            Text(p.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${p.price.toStringAsFixed(0)} ر.ي', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor)),
            const SizedBox(height: 16),
            Row(children: [const Icon(Icons.location_on, size: 16), const SizedBox(width: 4), Text(p.city ?? 'صنعاء، اليمن')]),
            const SizedBox(height: 24),
            const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(p.description.isNotEmpty ? p.description : 'لا يوجد وصف', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(product: p))),
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('شراء الآن'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
                    icon: const Icon(Icons.chat),
                    label: const Text('محادثة'),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AIChatAssistant(product: p, sellerId: p.sellerId, sellerName: p.sellerName))),
                icon: const Icon(Icons.bolt),
                label: const Text('AI مساعد'),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
