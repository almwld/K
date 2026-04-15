import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/stores_data.dart';
import '../../models/store_model.dart';
import 'store_detail_screen.dart';

class StoresScreen extends StatefulWidget {
  final String? category;
  
  const StoresScreen({super.key, this.category});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  List<StoreModel> _stores = [];
  List<StoreModel> _filteredStores = [];
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  
  final List<String> _categories = [
    'الكل', 'سيارات', 'عقارات', 'إلكترونيات', 'أثاث', 'أزياء', 
    'مواد غذائية', 'مطاعم', 'صحة', 'خدمات'
  ];

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  void _loadStores() {
    if (widget.category != null && widget.category != 'الكل') {
      _stores = StoresData.getStoresByCategory(widget.category!);
      _selectedCategory = widget.category!;
    } else {
      _stores = StoresData.getAllStores();
    }
    _filteredStores = _stores;
  }

  void _filterStores(String query) {
    setState(() {
      _searchQuery = query;
      _filteredStores = _stores.where((store) {
        final matchesCategory = _selectedCategory == 'الكل' || store.category == _selectedCategory;
        final matchesSearch = query.isEmpty || 
            store.name.toLowerCase().contains(query.toLowerCase()) ||
            store.description.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'الكل') {
        _stores = StoresData.getAllStores();
      } else {
        _stores = StoresData.getStoresByCategory(category);
      }
      _filterStores(_searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: SimpleAppBar(
        title: widget.category != null ? 'متاجر ${widget.category}' : 'جميع المتاجر',
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoriesFilter(),
          Expanded(
            child: _filteredStores.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredStores.length,
                    itemBuilder: (context, index) {
                      return _buildStoreCard(_filteredStores[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: TextField(
        onChanged: _filterStores,
        decoration: InputDecoration(
          hintText: 'ابحث عن متجر...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.goldColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(bottom: 8),
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
              onSelected: (_) => _onCategoryChanged(category),
              backgroundColor: Theme.of(context).cardColor,
              selectedColor: AppTheme.goldColor,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoreCard(StoreModel store) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(store: store))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(store.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(store.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: store.isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(store.isOpen ? 'مفتوح' : 'مغلق', style: TextStyle(color: store.isOpen ? Colors.green : Colors.red, fontSize: 11)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(store.description, style: TextStyle(color: Colors.grey[600], fontSize: 13), maxLines: 2),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppTheme.goldColor),
                      const SizedBox(width: 4),
                      Expanded(child: Text(store.address, style: TextStyle(color: Colors.grey[600], fontSize: 12))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: AppTheme.goldColor),
                      const SizedBox(width: 4),
                      Text(store.phone, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${store.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(' (${store.totalProducts} منتج)', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.store, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('لا توجد متاجر', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
