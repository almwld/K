import 'package:flutter/material.dart';
import '../services/recommendation_service.dart';
import '../models/market_item.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import 'product/product_detail_screen.dart';

class SmartSearchScreen extends StatefulWidget {
  const SmartSearchScreen({super.key});

  @override
  State<SmartSearchScreen> createState() => _SmartSearchScreenState();
}

class _SmartSearchScreenState extends State<SmartSearchScreen> {
  final SmartRecommendationEngine _engine = SmartRecommendationEngine();
  final TextEditingController _searchController = TextEditingController();
  final RecommendationService _service = RecommendationService();
  
  List<String> _suggestions = [];
  List<MarketItem> _searchResults = [];
  bool _isSearching = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _loadPopularSearches();
  }

  void _loadPopularSearches() {
    setState(() {
      _suggestions = _engine.getSmartSuggestions('');
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _suggestions = _engine.getSmartSuggestions(query);
    });
  }

  void _performSearch(String query) async {
    if (query.isEmpty) return;
    
    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });
    
    await _service.trackSearch(query);
    
    // البحث في المنتجات
    final allProducts = MarketData.getAllItemsComplete();
    final results = allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
             product.category.toLowerCase().contains(query.toLowerCase()) ||
             product.store.toLowerCase().contains(query.toLowerCase());
    }).toList();
    
    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'البحث الذكي',
        actions: [
          IconButton(
            onPressed: () => _performSearch(_searchController.text),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج، متجر، أو فئة...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.goldColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
              onChanged: _onSearchChanged,
              onSubmitted: _performSearch,
            ),
          ),
          
          // المحتوى
          Expanded(
            child: _hasSearched
                ? _buildSearchResults()
                : _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text('🔥 عمليات بحث شائعة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _suggestions.map((suggestion) {
            return GestureDetector(
              onTap: () {
                _searchController.text = suggestion;
                _performSearch(suggestion);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(suggestion),
              ),
            );
          }).toList(),
        ),
        
        const SizedBox(height: 24),
        const Text('📊 فئات مقترحة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        // فئات مقترحة
        ...MarketData.getAllSections().take(8).map((category) {
          return ListTile(
            leading: const Icon(Icons.category, color: AppTheme.goldColor),
            title: Text(category),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              _searchController.text = category;
              _performSearch(category);
            },
          );
        }),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('لا توجد نتائج', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text('جرب البحث بكلمة أخرى', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return _buildSearchResultCard(product);
      },
    );
  }

  Widget _buildSearchResultCard(MarketItem product) {
    return GestureDetector(
      onTap: () async {
        await _service.trackProductView(product.name, product.category, product.store);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              productId: product.name,
              productName: product.name,
              storeName: product.store,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
              child: Image.network(
                product.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(product.store, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(height: 8),
                    Text(
                      product.formattedPrice,
                      style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
