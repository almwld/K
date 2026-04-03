import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  final TextEditingController _searchController = TextEditingController();
  
  final List<String> _categories = ['الكل', 'إنتاجية', 'تواصل', 'تخزين', 'أمان', 'عروض'];
  
  final List<Map<String, dynamic>> _apps = [
    // إنتاجية
    {'name': 'مايكروسوفت 365', 'price': '15,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'إنتاجية', 'discount': '0'},
    {'name': 'مايكروسوفت 365 - سنوي', 'price': '150,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'إنتاجية', 'discount': '10%'},
    {'name': 'جوجل درايف 100GB', 'price': '2,500', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تخزين', 'discount': '0'},
    {'name': 'جوجل درايف 200GB', 'price': '4,500', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تخزين', 'discount': '5%'},
    {'name': 'جوجل درايف 2TB', 'price': '15,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تخزين', 'discount': '10%'},
    {'name': 'أدوبي كريتيف كلاود', 'price': '25,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'إنتاجية', 'discount': '0'},
    {'name': 'أدوبي كريتيف كلاود - سنوي', 'price': '250,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'إنتاجية', 'discount': '15%'},
    
    // تواصل
    {'name': 'زووم برو', 'price': '8,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تواصل', 'discount': '0'},
    {'name': 'زووم برو - سنوي', 'price': '80,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تواصل', 'discount': '15%'},
    {'name': 'تيليجرام بريميوم', 'price': '3,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تواصل', 'discount': '0'},
    {'name': 'تيليجرام بريميوم - سنوي', 'price': '30,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تواصل', 'discount': '10%'},
    {'name': 'واتساب بيزنس API', 'price': '12,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'تواصل', 'discount': '0'},
    
    // أمان
    {'name': 'نورد VPN', 'price': '6,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '0'},
    {'name': 'نورد VPN - سنوي', 'price': '60,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '20%'},
    {'name': 'إكسبريس VPN', 'price': '8,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '0'},
    {'name': 'إكسبريس VPN - سنوي', 'price': '80,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '25%'},
    {'name': 'كاسبرسكي', 'price': '5,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '0'},
    {'name': 'كاسبرسكي - سنوي', 'price': '50,000', 'period': 'سنوي', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'أمان', 'discount': '15%'},
    
    // عروض خاصة
    {'name': 'باقة الإنتاجية المتكاملة', 'price': '40,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'عروض', 'discount': '30%'},
    {'name': 'باقة الأمان الشامل', 'price': '15,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'عروض', 'discount': '25%'},
    {'name': 'باقة التخزين السحابي', 'price': '20,000', 'period': 'شهري', 'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=200', 'category': 'عروض', 'discount': '20%'},
  ];

  List<Map<String, dynamic>> get _filteredApps {
    var apps = _apps;
    
    if (_selectedCategory != 'الكل') {
      apps = apps.where((a) => a['category'] == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      apps = apps.where((a) => 
        a['name'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return apps;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final apps = _filteredApps;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'التطبيقات والاشتراكات'),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(),
          Expanded(
            child: apps.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.apps, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد تطبيقات', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      final app = apps[index];
                      return _buildAppCard(app);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'بحث عن تطبيق...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _searchController.clear();
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.goldColor, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppCard(Map<String, dynamic> app) {
    final discount = app['discount'] != '0' ? app['discount'] : null;
    final originalPrice = app['price'];
    int? discountedPrice;
    
    if (discount != null) {
      final discountPercent = int.parse(discount.replaceAll('%', ''));
      discountedPrice = int.parse(originalPrice) * (100 - discountPercent) ~/ 100;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.apps, size: 30, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  '${app['period']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (discountedPrice != null) ...[
                Text(
                  '$discountedPrice ر.ي',
                  style: TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${app['price']} ر.ي',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ] else ...[
                Text(
                  '${app['price']} ر.ي',
                  style: TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
              const SizedBox(height: 4),
              ElevatedButton(
                onPressed: () {
                  _showPurchaseDialog(app);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  minimumSize: const Size(80, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('اشتراك', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPurchaseDialog(Map<String, dynamic> app) {
    final discount = app['discount'] != '0' ? app['discount'] : null;
    final originalPrice = app['price'];
    int? discountedPrice;
    
    if (discount != null) {
      final discountPercent = int.parse(discount.replaceAll('%', ''));
      discountedPrice = int.parse(originalPrice) * (100 - discountPercent) ~/ 100;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('اشتراك ${app['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.subscriptions, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            Text('المدة: ${app['period']}'),
            const SizedBox(height: 8),
            if (discountedPrice != null) ...[
              Text(
                'السعر الأصلي: ${app['price']} ر.ي',
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
              Text(
                'السعر بعد الخصم: $discountedPrice ر.ي',
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ] else ...[
              Text('السعر: ${app['price']} ر.ي'),
            ],
            const SizedBox(height: 16),
            const Text('سيتم تفعيل الاشتراك فوراً', style: TextStyle(fontSize: 12)),
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
              _showSuccessDialog(app);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الاشتراك بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تفعيل اشتراك ${app['name']}'),
            Text('لمدة ${app['period']}'),
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
