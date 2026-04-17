import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class SellerReviewScreen extends StatefulWidget {
  final Map<String, dynamic>? seller;
  const SellerReviewScreen({super.key, this.seller});

  @override
  State<SellerReviewScreen> createState() => _SellerReviewScreenState();
}

class _SellerReviewScreenState extends State<SellerReviewScreen> {
  double _rating = 5;
  final TextEditingController _commentController = TextEditingController();
  List<String> _selectedAspects = [];
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _aspects = [
    {'name': 'سرعة الرد', 'icon': Icons.chat, 'color': 0xFF2196F3},
    {'name': 'جودة المنتج', 'icon': Icons.star, 'color': 0xFFFF9800},
    {'name': 'التغليف', 'icon': Icons.inventory, 'color': 0xFF4CAF50},
    {'name': 'سرعة التوصيل', 'icon': Icons.local_shipping, 'color': 0xFFE74C3C},
    {'name': 'التعامل', 'icon': Icons.people, 'color': 0xFF9C27B0},
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
      const SnackBar(content: Text('تم إضافة تقييم البائع بنجاح'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تقييم البائع'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // معلومات البائع
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.goldPrimary.withOpacity(0.2),
                    child: Text(widget.seller?['name']?[0] ?? 'ب', style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.seller?['name'] ?? 'متجر التقنية', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('${widget.seller?['products'] ?? 45} منتج • ${widget.seller?['followers'] ?? 1234} متابع'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // التقييم بالنجوم
            const Text('تقييمك للبائع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 24),
            
            // جوانب التقييم
            const Text('جوانب التقييم', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _aspects.map((aspect) {
                final isSelected = _selectedAspects.contains(aspect['name']);
                return FilterChip(
                  label: Text(aspect['name']),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAspects.add(aspect['name']);
                      } else {
                        _selectedAspects.remove(aspect['name']);
                      }
                    });
                  },
                  avatar: Icon(aspect['icon'], size: 18, color: isSelected ? Colors.black : Color(aspect['color'])),
                  selectedColor: Color(aspect['color']),
                  backgroundColor: AppTheme.getCardColor(context),
                  labelStyle: TextStyle(color: isSelected ? Colors.black : null),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // نص المراجعة
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'مراجعتك للبائع',
                hintText: 'شارك تجربتك مع هذا البائع...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            
            CustomButton(
              text: 'إرسال التقييم',
              onPressed: _submitReview,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }
}
