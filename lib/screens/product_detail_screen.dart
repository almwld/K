import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String sellerName;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final bool inStock;

  const ProductDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.sellerName,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.inStock,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _currentImageIndex = 0;
  bool _isFavorite = false;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: theme.scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) => setState(() => _currentImageIndex = index),
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return Hero(
                            tag: 'product_${widget.id}_$index',
                            child: CachedNetworkImage(
                              imageUrl: widget.images[index],
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) => Container(
                                color: isDark ? AppTheme.nightSurface : Colors.grey[200],
                                child: const Icon(Icons.image, size: 80, color: Colors.grey),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.images.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index ? AppTheme.gold : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ...List.generate(5, (index) => Icon(
                            index < widget.rating.floor() ? Icons.star : Icons.star_border,
                            color: AppTheme.gold,
                            size: 20,
                          )),
                          const SizedBox(width: 8),
                          Text('(${widget.reviewCount} تقييم)', style: theme.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppTheme.gold, width: 2),
                              ),
                              child: const CircleAvatar(backgroundColor: AppTheme.gold, child: Icon(Icons.person, color: Colors.black)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.sellerName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                  const Row(
                                    children: [
                                      Icon(Icons.verified, color: AppTheme.gold, size: 16),
                                      SizedBox(width: 4),
                                      Text('بائع موثوق', style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('السعر', style: TextStyle(color: Colors.grey)),
                              Text('${widget.price.toStringAsFixed(0)} ر.ي', style: theme.textTheme.headlineSmall?.copyWith(color: AppTheme.gold, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.3)), borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                IconButton(onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null, icon: const Icon(Icons.remove), color: AppTheme.gold),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('$_quantity', style: theme.textTheme.titleMedium)),
                                IconButton(onPressed: () => setState(() => _quantity++), icon: const Icon(Icons.add), color: AppTheme.gold),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('الوصف', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 8),
                      Text(widget.description, style: theme.textTheme.bodyMedium?.copyWith(height: 1.6)),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: widget.inStock ? _handleAddToCart : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(widget.inStock ? 'أضف للسلة' : 'غير متوفر', style: const TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: widget.inStock ? _handleBuyNow : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.inStock ? AppTheme.goldDark : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('شراء الآن', style: TextStyle(fontFamily: 'Changa', fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة $_quantity قطعة من ${widget.title} إلى السلة', style: const TextStyle(fontFamily: 'Changa')),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _handleBuyNow() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشراء', style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المنتج: ${widget.title}', style: const TextStyle(fontFamily: 'Changa')),
            const SizedBox(height: 8),
            Text('الكمية: $_quantity', style: const TextStyle(fontFamily: 'Changa')),
            const SizedBox(height: 8),
            Text('الإجمالي: ${widget.price * _quantity} ر.ي', style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, color: AppTheme.gold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(fontFamily: 'Changa'))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري تحويلك لصفحة الدفع...', style: TextStyle(fontFamily: 'Changa')), backgroundColor: AppTheme.gold),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('تأكيد', style: TextStyle(fontFamily: 'Changa')),
          ),
        ],
      ),
    );
  }
}


  factory ProductDetailScreen.fromProduct(dynamic product) {
    if (product is ProductModel) {
      return ProductDetailScreen(
        id: product.id,
        title: product.title,
        image: product.images.isNotEmpty ? product.images[0] : '',
        price: product.price,
        description: product.description,
        sellerName: product.sellerName ?? 'غير معروف',
        rating: product.rating ?? 0.0,
        reviewCount: product.reviewCount ?? 0,
        images: product.images,
        inStock: product.stock > 0,
      );
    }
    return ProductDetailScreen(
      id: '',
      title: '',
      image: '',
      price: 0,
      description: '',
      sellerName: '',
      rating: 0,
      reviewCount: 0,
      images: [],
      inStock: false,
    );
  }
}
