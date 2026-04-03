import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String _selectedCategory = 'الكل';
  
  final List<String> _categories = ['الكل', 'متاجر', 'مطاعم', 'ألعاب', 'مواقع', 'طيران'];
  
  final List<Map<String, dynamic>> _giftCards = [
    {'name': 'أمازون', 'value': '50', 'currency': 'USD', 'price': '28,000', 'image': 'https://images.unsplash.com/photo-1523474253046-8cd2748b5fd2?w=200', 'category': 'مواقع', 'discount': '5%'},
    {'name': 'ستاربكس', 'value': '20', 'currency': 'USD', 'price': '11,000', 'image': 'https://images.unsplash.com/photo-1507133750040-4a8f57021571?w=200', 'category': 'مطاعم', 'discount': '10%'},
    {'name': 'بلاي ستيشن', 'value': '50', 'currency': 'USD', 'price': '27,000', 'image': 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=200', 'category': 'ألعاب', 'discount': '8%'},
    {'name': 'نيتفليكس', 'value': '30', 'currency': 'USD', 'price': '16,000', 'image': 'https://images.unsplash.com/photo-1574375927938-d5a98e8ffe85?w=200', 'category': 'مواقع', 'discount': '12%'},
    {'name': 'جوجل بلاي', 'value': '25', 'currency': 'USD', 'price': '13,500', 'image': 'https://images.unsplash.com/photo-1611162617213-7d7a39e9b1d7?w=200', 'category': 'ألعاب', 'discount': '7%'},
    {'name': 'آبل', 'value': '100', 'currency': 'USD', 'price': '54,000', 'image': 'https://images.unsplash.com/photo-1611162616475-46b635cb6868?w=200', 'category': 'متاجر', 'discount': '10%'},
  ];

  List<Map<String, dynamic>> get _filteredCards {
    if (_selectedCategory == 'الكل') return _giftCards;
    return _giftCards.where((card) => card['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cards = _filteredCards;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'بطاقات الهدايا'),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: cards.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.card_giftcard, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد بطاقات', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return _buildGiftCard(card);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : 'الكل';
                });
              },
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGiftCard(Map<String, dynamic> card) {
    return GestureDetector(
      onTap: () {
        _showPurchaseDialog(card);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                card['image'],
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  color: Colors.grey[300],
                  child: const Icon(Icons.card_giftcard, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          card['discount'],
                          style: const TextStyle(color: Colors.green, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${card['value']} ${card['currency']}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${card['price']} ر.ي',
                        style: TextStyle(
                          color: AppTheme.goldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        card['category'],
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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

  void _showPurchaseDialog(Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('شراء بطاقة ${card['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(card['image'], height: 80, errorBuilder: (_, __, ___) => const Icon(Icons.card_giftcard, size: 50)),
            const SizedBox(height: 16),
            Text('القيمة: ${card['value']} ${card['currency']}'),
            Text('السعر: ${card['price']} ريال'),
            Text('الخصم: ${card['discount']}'),
            const SizedBox(height: 16),
            const Text('سيتم إرسال البطاقة إلى بريدك الإلكتروني', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(card);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('شراء الآن'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشراء بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شراء بطاقة ${card['name']}'),
            Text('بمبلغ ${card['price']} ريال'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
