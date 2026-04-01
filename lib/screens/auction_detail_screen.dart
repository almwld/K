import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../models/auction_model.dart';

class AuctionDetailScreen extends StatefulWidget {
  final AuctionModel auction;
  const AuctionDetailScreen({super.key, required this.auction});

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _countdownController;
  final TextEditingController _bidController = TextEditingController();
  bool _isBidding = false;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _countdownController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _bidController.text = widget.auction.nextBidAmount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _bidController.dispose();
    super.dispose();
  }

  Future<void> _placeBid() async {
    final bidAmount = double.tryParse(_bidController.text);
    if (bidAmount == null) {
      _showSnackBar('يرجى إدخال مبلغ صحيح', Colors.red);
      return;
    }
    if (bidAmount < widget.auction.nextBidAmount) {
      _showSnackBar('المزايدة يجب أن تكون ${widget.auction.nextBidAmount.toStringAsFixed(0)} ريال على الأقل', Colors.red);
      return;
    }

    setState(() => _isBidding = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isBidding = false);
    _showSnackBar('تم تقديم المزايدة بنجاح', Colors.green);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auction = widget.auction;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(title: auction.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المزاد
            _buildImageCarousel(auction),
            
            // معلومات المزاد
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والحالة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          auction.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (auction.isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: AnimatedBuilder(
                            animation: _countdownController,
                            builder: (context, child) {
                              return Row(
                                children: [
                                  const Icon(Icons.timer, color: Colors.red, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    auction.timeLeft,
                                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(auction.category, style: TextStyle(color: AppTheme.goldColor)),
                  const SizedBox(height: 24),
                  
                  // معلومات السعر
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('السعر الحالي', style: TextStyle(fontSize: 12)),
                            Text(
                              '${auction.currentPrice.toStringAsFixed(0)} ر.ي',
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('المزايدات', style: TextStyle(fontSize: 12)),
                            Text(
                              '${auction.bidCount}',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // معلومات البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          child: Text(auction.sellerName[0], style: const TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(auction.sellerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('بائع', style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context))),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: const Text('تواصل'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // الوصف
                  const Text('الوصف', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    auction.description,
                    style: TextStyle(height: 1.5, color: AppTheme.getSecondaryTextColor(context)),
                  ),
                  const SizedBox(height: 24),
                  
                  // تقديم مزايدة
                  if (auction.isActive) ...[
                    const Text('تقديم مزايدة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _bidController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'مبلغ المزايدة',
                                    suffixText: 'ر.ي',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: _isBidding ? null : _placeBid,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.goldColor,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                ),
                                child: _isBidding
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                    : const Text('مزايدة'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'الحد الأدنى للمزايدة: ${auction.nextBidAmount.toStringAsFixed(0)} ر.ي',
                            style: TextStyle(fontSize: 12, color: AppTheme.getSecondaryTextColor(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(AuctionModel auction) {
    final images = auction.images.isEmpty ? ['https://picsum.photos/id/1/400/300'] : auction.images;

    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => Container(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  child: const Icon(Icons.image, size: 80, color: AppTheme.goldColor),
                ),
              );
            },
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index ? AppTheme.goldColor : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
