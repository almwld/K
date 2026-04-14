import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'store_detail_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key, this.category});

  final String? category;

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _stores = [];
  List<Map<String, dynamic>> _filteredStores = [];
  String _selectedCategory = 'الكل';
  bool _isLoading = true;

  final List<String> _categories = [
    'الكل', 'electronics', 'fashion', 'furniture', 'cars', 'real_estate',
    'services', 'restaurants', 'health_beauty', 'sports', 'jewelry',
    'watches', 'perfumes', 'bags', 'shoes', 'phones', 'laptops',
    'tv', 'home_appliances', 'books', 'gifts', 'flowers', 'bakery',
    'grocery', 'meat', 'vegetables', 'dairy', 'drinks', 'coffee',
    'dates', 'honey', 'incense', 'carpets', 'games', 'baby', 'pets',
    'stationery', 'software', 'training', 'agriculture'
  ];

  final Map<String, String> _categoryNames = {
    'الكل': 'الكل',
    'electronics': 'إلكترونيات',
    'fashion': 'أزياء',
    'furniture': 'أثاث',
    'cars': 'سيارات',
    'real_estate': 'عقارات',
    'services': 'خدمات',
    'restaurants': 'مطاعم',
    'health_beauty': 'صحة وجمال',
    'sports': 'رياضة',
    'jewelry': 'مجوهرات',
    'watches': 'ساعات',
    'perfumes': 'عطور',
    'bags': 'حقائب',
    'shoes': 'أحذية',
    'phones': 'جوالات',
    'laptops': 'كمبيوترات',
    'tv': 'شاشات',
    'home_appliances': 'أجهزة منزلية',
    'books': 'كتب',
    'gifts': 'هدايا',
    'flowers': 'ورود',
    'bakery': 'مخبوزات',
    'grocery': 'مواد غذائية',
    'coffee': 'قهوة',
    'dates': 'تمور',
    'honey': 'عسل',
    'carpets': 'سجاد',
    'games': 'ألعاب',
    'baby': 'أطفال',
    'pets': 'حيوانات',
    'agriculture': 'زراعة',
  };

  @override
  void initState() {
    super.initState();
    _loadStores();
    if (widget.category != null) {
      _selectedCategory = widget.category!;
    }
  }

  Future<void> _loadStores() async {
    setState(() => _isLoading = true);

    final response = await _supabase
        .from('stores')
        .select()
        .eq('is_active', true)
        .order('rating', ascending: false);

    setState(() {
      _stores = List<Map<String, dynamic>>.from(response);
      _filterStores();
      _isLoading = false;
    });
  }

  void _filterStores() {
    if (_selectedCategory == 'الكل') {
      _filteredStores = _stores;
    } else {
      _filteredStores = _stores.where((store) =>
          store['store_category'] == _selectedCategory).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المتاجر'),
      body: Column(
        children: [
          // شريط الفئات
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                final displayName = _categoryNames[category] ?? category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                      _filterStores();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppTheme.goldColor, AppTheme.goldDark],
                            )
                          : null,
                      color: isSelected ? null : (isDark ? Colors.grey[800] : Colors.grey[200]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        displayName,
                        style: TextStyle(
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // قائمة المتاجر
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredStores.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.store, size: 80, color: Colors.grey),
                            const SizedBox(height: 16),
                            const Text('لا توجد متاجر في هذا القسم'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredStores.length,
                        itemBuilder: (context, index) {
                          final store = _filteredStores[index];
                          return _buildStoreCard(store);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(Map<String, dynamic> store) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StoreDetailScreen(storeId: store['id']),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // شعار المتجر
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: store['store_logo'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(store['store_logo'], fit: BoxFit.cover),
                    )
                  : Icon(Icons.store, size: 35, color: AppTheme.goldColor),
            ),
            const SizedBox(width: 12),
            // معلومات المتجر
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          store['store_name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (store['is_verified'] == true)
                        const Icon(Icons.verified, size: 16, color: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    store['store_description'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        store['rating']?.toStringAsFixed(1) ?? '0.0',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          store['address'] ?? 'صنعاء، اليمن',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
