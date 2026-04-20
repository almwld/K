import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../data/market_data.dart';
import '../models/market_item.dart';
import 'product/product_detail_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final _searchController = TextEditingController();
  List<MarketItem> _searchResults = [];
  bool _hasSearched = false;
  bool _isLoading = false;

  void _performSearch() {
    if (_searchController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });
    
    Future.delayed(const Duration(milliseconds: 500), () {
      final results = MarketData.getAllItems()
          .where((p) => p.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                       p.category.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
      
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SimpleAppBar(
        title: 'البحث المتقدم',
        actions: [IconButton(onPressed: _performSearch, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.gold),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: _hasSearched
                ? _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchResults.isEmpty
                        ? const Center(child: Text('لا توجد نتائج'))
                        : GridView.builder(
                            padding: const EdgeInsets.all(12),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final product = _searchResults[index];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(
                                      productId: product.name,
                                      productName: product.name,
                                      storeName: product.store,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                        child: Image.network(product.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text(product.formattedPrice, style: TextStyle(color: AppTheme.gold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                : const Center(child: Text('ابحث عن منتجات، متاجر، أو فئات')),
          ),
        ],
      ),
    );
  }
}

