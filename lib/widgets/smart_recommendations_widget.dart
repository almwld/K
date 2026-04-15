import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/recommendation_service.dart';
import '../models/market_item.dart';
import '../theme/app_theme.dart';
import '../screens/product/product_detail_screen.dart';

class SmartRecommendationsWidget extends StatefulWidget {
  final String? productId;
  final bool showAllSections;

  const SmartRecommendationsWidget({
    super.key,
    this.productId,
    this.showAllSections = true,
  });

  @override
  State<SmartRecommendationsWidget> createState() => _SmartRecommendationsWidgetState();
}

class _SmartRecommendationsWidgetState extends State<SmartRecommendationsWidget> {
  final SmartRecommendationEngine _engine = SmartRecommendationEngine();
  List<PersonalizedRecommendation> _recommendations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    if (widget.productId != null) {
      // توصيات صفحة المنتج فقط
      final items = _engine.getProductPageRecommendations(widget.productId!);
      setState(() {
        _recommendations = [
          PersonalizedRecommendation(
            title: '🛒 منتجات مشابهة',
            subtitle: 'قد تعجبك أيضاً',
            items: items,
            type: RecommendationType.similar,
          ),
        ];
        _isLoading = false;
      });
    } else {
      // توصيات الصفحة الرئيسية
      final recommendations = await _engine.getHomePageRecommendations();
      setState(() {
        _recommendations = recommendations;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: _recommendations.map((rec) => _buildRecommendationSection(rec)).toList(),
    );
  }

  Widget _buildRecommendationSection(PersonalizedRecommendation rec) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rec.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(rec.subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('عرض الكل', style: TextStyle(color: AppTheme.goldColor))),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: rec.items.length,
            itemBuilder: (context, index) {
              return _buildProductCard(rec.items[index], rec.type);
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildProductCard(MarketItem product, RecommendationType type) {
    return GestureDetector(
      onTap: () {
        // تسجيل النقر على التوصية
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              productId: product.name,
              productName: product.name,
              storeName: product.store,
            ),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // شارة نوع التوصية
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getBadgeColor(type),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getBadgeText(type),
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // معلومات المنتج
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.formattedPrice,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        product.isPositive ? Icons.trending_up : Icons.trending_down,
                        size: 12,
                        color: product.isPositive ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        product.formattedChange,
                        style: TextStyle(
                          fontSize: 10,
                          color: product.isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBadgeColor(RecommendationType type) {
    switch (type) {
      case RecommendationType.forYou:
        return Colors.purple;
      case RecommendationType.trending:
        return Colors.orange;
      case RecommendationType.history:
        return Colors.blue;
      case RecommendationType.timeBased:
        return Colors.teal;
      case RecommendationType.location:
        return Colors.green;
      case RecommendationType.seasonal:
        return Colors.brown;
      default:
        return AppTheme.goldColor;
    }
  }

  String _getBadgeText(RecommendationType type) {
    switch (type) {
      case RecommendationType.forYou:
        return '✨ لك';
      case RecommendationType.trending:
        return '🔥 رائج';
      case RecommendationType.history:
        return '👀 شوهد';
      case RecommendationType.timeBased:
        return '🕐 الآن';
      case RecommendationType.location:
        return '📍 قريب';
      case RecommendationType.seasonal:
        return '🍂 موسم';
      default:
        return '⭐ مميز';
    }
  }
}
