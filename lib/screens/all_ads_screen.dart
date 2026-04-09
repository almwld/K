import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/ad_service.dart';
import '../models/ad_model.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'ad_detail_screen.dart';

class AllAdsScreen extends StatefulWidget {
  const AllAdsScreen({super.key});

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  final AdService _adService = AdService();
  List<AdModel> _ads = [];
  bool _isLoading = true;
  String _selectedCategory = 'الكل';
  String _sortBy = 'newest';

  final List<String> _categories = ['الكل', 'electronics', 'fashion', 'furniture', 'cars', 'real_estate', 'services'];
  final List<Map<String, String>> _sortOptions = [
    {'value': 'newest', 'label': 'الأحدث'},
    {'value': 'price_low', 'label': 'السعر: من الأقل للأعلى'},
    {'value': 'price_high', 'label': 'السعر: من الأعلى للأقل'},
    {'value': 'popular', 'label': 'الأكثر مشاهدة'},
  ];

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  Future<void> _loadAds() async {
    setState(() => _isLoading = true);
    final ads = await _adService.getAds(
      category: _selectedCategory == 'الكل' ? null : _selectedCategory,
      sortBy: _sortBy,
    );
    setState(() {
      _ads = ads;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'جميع الإعلانات'),
      body: Column(
        children: [
          // فلتر التصنيفات
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = category);
                    _loadAds();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[800] : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category == 'الكل' ? 'الكل' : _getCategoryName(category),
                      style: TextStyle(color: isSelected ? Colors.black : null),
                    ),
                  ),
                );
              },
            ),
          ),
          // فلتر الترتيب
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ترتيب حسب:'),
                DropdownButton(
                  value: _sortBy,
                  items: _sortOptions.map((opt) {
                    return DropdownMenuItem(value: opt['value'], child: Text(opt['label']!));
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _sortBy = value.toString());
                    _loadAds();
                  },
                ),
              ],
            ),
          ),
          // قائمة الإعلانات
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _ads.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox, size: 80, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('لا توجد إعلانات', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _ads.length,
                        itemBuilder: (context, index) {
                          final ad = _ads[index];
                          return _buildAdCard(ad);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdCard(AdModel ad) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdDetailScreen(adId: ad.id))),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: ad.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: ad.images[0],
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(height: 140, color: Colors.grey[300]),
                    )
                  : Container(height: 140, color: Colors.grey[300], child: const Icon(Icons.image, size: 40)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ad.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(ad.formattedPrice, style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold)),
                  if (ad.oldPrice != null)
                    Text(ad.formattedOldPrice, style: const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(child: Text(ad.location ?? 'اليمن', maxLines: 1, style: const TextStyle(fontSize: 11, color: Colors.grey))),
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

  String _getCategoryName(String id) {
    switch (id) {
      case 'electronics': return 'إلكترونيات';
      case 'fashion': return 'أزياء';
      case 'furniture': return 'أثاث';
      case 'cars': return 'سيارات';
      case 'real_estate': return 'عقارات';
      case 'services': return 'خدمات';
      default: return id;
    }
  }
}
