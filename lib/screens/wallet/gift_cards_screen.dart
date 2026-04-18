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
  
  final List<String> _categories = ['الكل', 'أمازون', 'جوجل بلاي', 'آب ستور', 'ستيم', 'نتفليكس'];
  
  final List<Map<String, dynamic>> _giftCards = [
    {'name': 'أمازون', 'value': '10\$', 'price': '12,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg', 'category': 'أمازون', 'stock': 'متوفر'},
    {'name': 'أمازون', 'value': '25\$', 'price': '31,250', 'image': 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg', 'category': 'أمازون', 'stock': 'متوفر'},
    {'name': 'أمازون', 'value': '50\$', 'price': '62,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg', 'category': 'أمازون', 'stock': 'متوفر'},
    {'name': 'جوجل بلاي', 'value': '10\$', 'price': '11,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'category': 'جوجل بلاي', 'stock': 'متوفر'},
    {'name': 'جوجل بلاي', 'value': '25\$', 'price': '28,750', 'image': 'https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_2022_logo.png', 'category': 'جوجل بلاي', 'stock': 'متوفر'},
    {'name': 'آب ستور', 'value': '10\$', 'price': '12,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'category': 'آب ستور', 'stock': 'متوفر'},
    {'name': 'آب ستور', 'value': '25\$', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/6/67/App_Store_Logo.svg', 'category': 'آب ستور', 'stock': 'نفد'},
    {'name': 'ستيم', 'value': '10\$', 'price': '11,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'category': 'ستيم', 'stock': 'متوفر'},
    {'name': 'ستيم', 'value': '20\$', 'price': '22,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'category': 'ستيم', 'stock': 'متوفر'},
    {'name': 'نتفليكس', 'value': '1 شهر', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'category': 'نتفليكس', 'stock': 'متوفر'},
  ];

  List<Map<String, dynamic>> get _filteredCards {
    if (_selectedCategory == 'الكل') return _giftCards;
    return _giftCards.where((c) => c['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredCards;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'بطاقات الهدايا'),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final card = filtered[index];
                return _buildGiftCard(card);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 45,
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
              selectedColor: AppTheme.goldAccent,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGiftCard(Map<String, dynamic> card) {
    final isOutOfStock = card['stock'] == 'نفد';
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  card['image'],
                  errorBuilder: (_, __, ___) => Icon(Icons.card_giftcard, size: 50, color: AppTheme.goldAccent),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                card['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                card['value'],
                style: TextStyle(color: AppTheme.goldAccent, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                '${card['price']} ر.ي',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: isOutOfStock ? null : () => _buyGiftCard(card),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(isOutOfStock ? 'نفد' : 'شراء'),
              ),
            ],
          ),
          if (isOutOfStock)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('نفد', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
        ],
      ),
    );
  }

  void _buyGiftCard(Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشراء'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.card_giftcard, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('شراء بطاقة ${card['name']} - ${card['value']}'),
            const SizedBox(height: 8),
            Text('السعر: ${card['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(card);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
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
            Text('تم شراء بطاقة ${card['name']} - ${card['value']}'),
            const SizedBox(height: 8),
            Text('سيتم إرسال الكود إلى بريدك الإلكتروني'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
