import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Map<String, dynamic>> _reviews = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadReviews();
  }
  
  void _loadReviews() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _reviews = [
          {'user': 'أحمد محمد', 'rating': 5, 'title': 'منتج رائع', 'comment': 'المنتج مطابق للوصف وجودة عالية', 'date': '2026-04-01'},
          {'user': 'فاطمة علي', 'rating': 4, 'title': 'جيد جداً', 'comment': 'منتج جيد لكن السعر مرتفع قليلاً', 'date': '2026-03-30'},
          {'user': 'خالد محمود', 'rating': 5, 'title': 'ممتاز', 'comment': 'خدمة سريعة وتوصيل في الوقت المحدد', 'date': '2026-03-28'},
        ];
        _isLoading = false;
      });
    });
  }
  
  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.fold(0.0, (sum, r) => sum + r['rating']) / _reviews.length;
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المراجعات'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // ملخص التقييم
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _averageRating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.gold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < _averageRating.round() ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 18,
                                );
                              }),
                            ),
                            const SizedBox(height: 8),
                            Text('${_reviews.length} تقييم', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 80, color: AppTheme.getDividerColor(context)),
                      Expanded(
                        child: Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('سيتم إضافة ميزة إضافة مراجعة قريباً'), backgroundColor: AppTheme.gold),
                              );
                            },
                            icon: const Icon(Icons.rate_review),
                            label: const Text('أضف تقييمك'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gold,
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // قائمة المراجعات
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppTheme.gold.withOpacity(0.2),
                                  child: Text(review['user'][0], style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(review['user'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Row(
                                        children: List.generate(5, (i) {
                                          return Icon(
                                            i < review['rating'] ? Icons.star : Icons.star_border,
                                            color: Colors.amber,
                                            size: 14,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(review['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(review['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 8),
                            Text(review['comment'], style: TextStyle(height: 1.4)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

