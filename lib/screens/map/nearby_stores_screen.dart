import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/store_model.dart';
import '../../widgets/simple_app_bar.dart';

class NearbyStoresScreen extends StatefulWidget {
  const NearbyStoresScreen({super.key});

  @override
  State<NearbyStoresScreen> createState() => _NearbyStoresScreenState();
}

class _NearbyStoresScreenState extends State<NearbyStoresScreen> {
  String _selectedCategory = 'الكل';
  String _searchQuery = '';

  final List<String> _categories = ['الكل', 'إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'مطاعم'];

  List<StoreModel> get _filteredStores {
    return sampleStores.where((store) {
      final matchesCategory = _selectedCategory == 'الكل' || store.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          store.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          store.address.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList()
      ..sort((a, b) => a.distance.compareTo(b.distance));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المتاجر القريبة'),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'البحث عن متجر...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: AppTheme.getCardColor(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppTheme.goldColor, AppTheme.goldLight],
                            )
                          : null,
                      color: isSelected ? null : AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.black : AppTheme.getTextColor(context),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Stores List
          Expanded(
            child: _filteredStores.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store_outlined,
                          size: 80,
                          color: AppTheme.getSecondaryTextColor(context),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد متاجر',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildStoreCard(StoreModel store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/seller_profile'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.store, color: AppTheme.goldColor, size: 40),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            store.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppTheme.getTextColor(context),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: store.isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            store.isOpen ? 'مفتوح' : 'مغلق',
                            style: TextStyle(
                              fontSize: 10,
                              color: store.isOpen ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      store.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.getSecondaryTextColor(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber.shade600, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${store.rating}',
                          style: TextStyle(
                            color: AppTheme.getTextColor(context),
                          ),
                        ),
                        if (store.reviewCount != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${store.reviewCount})',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.getSecondaryTextColor(context),
                            ),
                          ),
                        ],
                        const Spacer(),
                        Icon(Icons.location_on, size: 14, color: AppTheme.getSecondaryTextColor(context)),
                        const SizedBox(width: 4),
                        Text(
                          '${store.distance.toInt()} م',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.getSecondaryTextColor(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.place, size: 14, color: AppTheme.getSecondaryTextColor(context)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            store.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.getSecondaryTextColor(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
