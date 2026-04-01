import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<Map<String, dynamic>> reviews = [
    {
      'author': 'سارة',
      'rating': 5,
      'title': 'منتج ممتاز',
      'body': 'الخدمة كانت سريعة والمنتج مطابق للوصف.',
      'date': '2026-03-20'
    },
    {
      'author': 'أحمد',
      'rating': 4,
      'title': 'جيد',
      'body': 'جودة جيدة لكن التعبئة بحاجة لتحسين.',
      'date': '2026-02-10'
    },
  ];

  void _showAddReviewDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    int rating = 5;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مراجعة'),
        content: StatefulBuilder(
          builder: (context, setStateSB) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: List.generate(5, (i) {
                  return IconButton(
                    onPressed: () => setStateSB(() => rating = i + 1),
                    icon: Icon(
                      i < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    ),
                  );
                }),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'عنوان المراجعة'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'تفاصيل المراجعة'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                reviews.insert(0, {
                  'author': 'أنت',
                  'rating': rating,
                  'title': titleController.text.isEmpty ? 'مراجعة' : titleController.text,
                  'body': bodyController.text,
                  'date': DateTime.now().toIso8601String().split('T').first,
                });
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت إضافة المراجعة')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('نشر'),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> r, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppTheme.goldColor.withOpacity(0.2),
            child: Text(r['author'][0], style: const TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(r['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text(r['date'], style: TextStyle(color: AppTheme.getSecondaryTextColor(context), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(5, (i) {
                    return Icon(i < r['rating'] ? Icons.star : Icons.star_border, color: Colors.amber, size: 16);
                  }),
                ),
                const SizedBox(height: 8),
                Text(r['body'], style: const TextStyle(height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 80).ms);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المراجعات'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: reviews.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.reviews_outlined, size: 80, color: AppTheme.goldColor.withOpacity(0.5)),
                          const SizedBox(height: 12),
                          const Text('لا توجد مراجعات بعد'),
                          const SizedBox(height: 8),
                          Text('كن أول من يكتب مراجعة', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) => _buildReviewCard(reviews[index], index),
                    ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showAddReviewDialog,
                icon: const Icon(Icons.rate_review),
                label: const Text('أضف مراجعتك'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
