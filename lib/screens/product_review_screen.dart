import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class ProductReviewScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  const ProductReviewScreen({super.key, this.product});

  @override
  State<ProductReviewScreen> createState() => _ProductReviewScreenState();
}

class _ProductReviewScreenState extends State<ProductReviewScreen> {
  double _rating = 5;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  List<String> _selectedTags = [];
  bool _isAnonymous = false;
  bool _isSubmitting = false;
  
  final List<String> _tags = [
    'جودة عالية', 'سعر مناسب', 'توصيل سريع', 'منتج أصلي',
    'تغليف جيد', 'خدمة ممتازة', 'ينصح به', 'سعر مرتفع',
  ];
  
  Future<void> _submitReview() async {
    if (_commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة مراجعة'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إضافة تقييمك بنجاح'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تقييم المنتج'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // معلومات المنتج
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.goldColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.image, color: AppTheme.goldColor, size: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product?['title'] ?? 'منتج مميز',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.product?['price'] ?? 0} ر.ي',
                          style: const TextStyle(color: AppTheme.goldColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // التقييم بالنجوم
            const Text('تقييمك', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 40,
                    ),
                    onPressed: () => setState(() => _rating = index + 1),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _rating == 1 ? 'سيء' : (_rating == 2 ? 'ضعيف' : (_rating == 3 ? 'متوسط' : (_rating == 4 ? 'جيد' : 'ممتاز'))),
                style: const TextStyle(color: AppTheme.goldColor),
              ),
            ),
            const SizedBox(height: 24),
            
            // عنوان المراجعة
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'عنوان المراجعة (اختياري)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // نص المراجعة
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'مراجعتك',
                hintText: 'شارك تجربتك مع هذا المنتج...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            
            // وسوم
            const Text('وسوم المراجعة (اختياري)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    });
                  },
                  selectedColor: AppTheme.goldColor,
                  backgroundColor: AppTheme.getCardColor(context),
                  labelStyle: TextStyle(color: isSelected ? Colors.black : null),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // إضافة صور (اختياري)
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate, color: AppTheme.goldColor),
                      SizedBox(height: 4),
                      Text('إضافة صور (اختياري)', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // إخفاء الاسم
            CheckboxListTile(
              title: const Text('نشر anonymously'),
              subtitle: const Text('لن يظهر اسمك في المراجعة'),
              value: _isAnonymous,
              onChanged: (v) => setState(() => _isAnonymous = v!),
              activeColor: AppTheme.goldColor,
            ),
            
            const SizedBox(height: 32),
            
            CustomButton(
              text: 'نشر التقييم',
              onPressed: _submitReview,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}
