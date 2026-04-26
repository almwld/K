import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = ['iPhone', 'ساعة', 'لابتوب', 'عطر'];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  final List<Map<String, dynamic>> _allProducts = [
    {'name': 'iPhone 15 Pro', 'price': '350,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=100'},
    {'name': 'ساعة أبل الترا', 'price': '45,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=100'},
    {'name': 'لابتوب ديل XPS', 'price': '350,000', 'category': 'إلكترونيات', 'image': 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=100'},
    {'name': 'عطر توم فورد', 'price': '45,000', 'category': 'عطور', 'image': 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=100'},
  ];

  void _performSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      _searchResults = _allProducts.where((p) => p['name'].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _addToRecent(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 10) _recentSearches.removeLast();
      });
    }
  }

  void _clearRecent() {
    setState(() => _recentSearches.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('البحث', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.binanceGold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              onChanged: (v) => _performSearch(v),
              onSubmitted: (v) => _addToRecent(v),
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج...',
                hintStyle: const TextStyle(color: Color(0xFF5E6673)),
                prefixIcon: const Icon(Icons.search, color: AppTheme.binanceGold),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Color(0xFF5E6673)),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.binanceCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          if (!_isSearching)
            _buildRecentSearches(),
          if (_isSearching)
            _buildSearchResults(),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('عمليات البحث الأخيرة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                if (_recentSearches.isNotEmpty)
                  TextButton(
                    onPressed: _clearRecent,
                    child: const Text('مسح الكل', style: TextStyle(color: AppTheme.binanceRed)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) => GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                  _addToRecent(search);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.binanceCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.binanceBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.history, size: 14, color: AppTheme.binanceGold),
                      const SizedBox(width: 6),
                      Text(search, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: AppTheme.binanceGold.withOpacity(0.3)),
              const SizedBox(height: 16),
              const Text('لا توجد نتائج', style: TextStyle(color: Color(0xFF9CA3AF))),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _searchResults.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.binanceCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  _searchResults[index]['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: AppTheme.binanceGold.withOpacity(0.1),
                    child: const Icon(Icons.image, color: AppTheme.binanceGold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _searchResults[index]['name'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _searchResults[index]['category'],
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                    ),
                    Text(
                      '${_searchResults[index]['price']} ريال',
                      style: const TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
