import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product_review_screen.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> _reviews = [];
  List<Map<String, dynamic>> _myReviews = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadReviews();
  }
  
  void _loadReviews() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _reviews = [
          {'id': '1', 'user': 'أحمد محمد', 'avatar': null, 'rating': 5, 'title': 'منتج رائع', 'comment': 'المنتج مطابق للوصف وجودة عالية، أنصح به بشدة', 'date': '2026-04-01', 'likes': 45, 'images': [], 'tags': ['جودة عالية', 'منتج أصلي']},
          {'id': '2', 'user': 'فاطمة علي', 'avatar': null, 'rating': 4, 'title': 'جيد جداً', 'comment': 'منتج جيد لكن السعر مرتفع قليلاً مقارنة بمنتجات أخرى', 'date': '2026-03-30', 'likes': 23, 'images': [], 'tags': ['سعر مناسب']},
          {'id': '3', 'user': 'خالد محمود', 'avatar': null, 'rating': 5, 'title': 'ممتاز', 'comment': 'خدمة سريعة وتوصيل في الوقت المحدد، المنتج ممتاز', 'date': '2026-03-28', 'likes': 67, 'images': [], 'tags': ['توصيل سريع', 'خدمة ممتازة']},
          {'id': '4', 'user': 'سارة أحمد', 'avatar': null, 'rating': 3, 'title': 'متوسط', 'comment': 'المنتج جيد لكن التغليف كان سيئاً', 'date': '2026-03-25', 'likes': 12, 'images': [], 'tags': ['تغليف جيد']},
        ];
        _myReviews = [_reviews[0], _reviews[2]];
        _isLoading = false;
      });
    });
  }
  
  double get _averageRating {
    if (_reviews.isEmpty) return 0;
    return _reviews.fold(0.0, (sum, r) => sum + r['rating']) / _reviews.length;
  }
  
  Map<int, int> get _ratingDistribution {
    Map<int, int> dist = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in _reviews) {
      dist[review['rating']] = (dist[review['rating']] ?? 0) + 1;
    }
    return dist;
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
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
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _averageRating.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
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
                            Text('${_reviews.length} تقييم', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 100, color: AppTheme.getDividerColor(context)),
                      Expanded(
                        child: Column(
                          children: [
                            _buildRatingBar(5, _ratingDistribution[5] ?? 0, _reviews.length),
                            _buildRatingBar(4, _ratingDistribution[4] ?? 0, _reviews.length),
                            _buildRatingBar(3, _ratingDistribution[3] ?? 0, _reviews.length),
                            _buildRatingBar(2, _ratingDistribution[2] ?? 0, _reviews.length),
                            _buildRatingBar(1, _ratingDistribution[1] ?? 0, _reviews.length),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // تبويبات
                Container(
                  color: AppTheme.getCardColor(context),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppTheme.goldColor,
                    labelColor: AppTheme.goldColor,
                    unselectedLabelColor: AppTheme.getSecondaryTextColor(context),
                    tabs: const [
                      Tab(text: 'جميع المراجعات', icon: Icon(Icons.rate_review)),
                      Tab(text: 'مراجعاتي', icon: Icon(Icons.person)),
                    ],
                  ),
                ),
                
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildReviewsList(_reviews),
                      _buildReviewsList(_myReviews, showAddButton: true),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  
  Widget _buildRatingBar(int stars, int count, int total) {
    final percentage = total > 0 ? (count / total) : 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Row(
              children: [
                Text('$stars', style: const TextStyle(fontSize: 12)),
                const Icon(Icons.star, size: 12, color: Colors.amber),
              ],
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.withOpacity(0.2),
              color: AppTheme.goldColor,
              minHeight: 6,
            ),
          ),
          SizedBox(width: 40, child: Text('$count', style: const TextStyle(fontSize: 12, textAlign: TextAlign.right))),
        ],
      ),
    );
  }
  
  Widget _buildReviewsList(List<Map<String, dynamic>> reviews, {bool showAddButton = false}) {
    if (reviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('لا توجد مراجعات', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('كن أول من يكتب مراجعة', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
            if (showAddButton) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProductReviewScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('إضافة مراجعة'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
              ),
            ],
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length + (showAddButton ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == reviews.length && showAddButton) {
          return Container(
            margin: const EdgeInsets.only(top: 8),
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductReviewScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('إضافة مراجعة جديدة'),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.goldColor)),
            ),
          );
        }
        final review = reviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.goldColor.withOpacity(0.2),
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
              if (review['tags'].isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: review['tags'].map<Widget>((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 10, color: AppTheme.goldColor)),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined, size: 18),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  Text('${review['likes']}', style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined, size: 18),
                    onPressed: () {},
                    color: Colors.grey,
                  ),
                  const Text('0', style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  if (review['user'] == 'أحمد محمد')
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                        const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
