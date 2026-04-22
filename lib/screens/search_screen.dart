import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasSearched = false;
  
  // بيانات البحث الشائعة
  final List<String> _popularSearches = [
    'iPhone 15 Pro',
    'ثوب يمني',
    'ساعة رولكس',
    'مندي',
    'سيارات',
    'عقارات',
    'عطور',
    'أثاث',
  ];
  
  // سجل البحث
  final List<String> _recentSearches = [
    'سامسونج',
    'ماك بوك',
    'كاميرا',
  ];
  
  // نتائج البحث التجريبية
  final List<Map<String, dynamic>> _searchResults = [
    {'name': 'iPhone 15 Pro', 'price': 350000, 'store': 'متجر التقنية', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=100'},
    {'name': 'iPhone 15 Pro Max', 'price': 450000, 'store': 'متجر التقنية', 'rating': 4.9, 'image': 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=100'},
    {'name': 'Samsung S24 Ultra', 'price': 380000, 'store': 'عالم الجوالات', 'rating': 4.7, 'image': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=100'},
    {'name': 'ثوب يمني فاخر', 'price': 35000, 'store': 'الأزياء العصرية', 'rating': 4.6, 'image': 'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=100'},
    {'name': 'مندي يمني', 'price': 3500, 'store': 'مطعم مندي الملكي', 'rating': 4.8, 'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=100'},
  ];

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _hasSearched = true;
        if (!_recentSearches.contains(query)) {
          _recentSearches.insert(0, query);
          if (_recentSearches.length > 5) _recentSearches.removeLast();
        }
      });
    }
  }

  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'ابحث عن منتجات، متاجر، فئات...',
              hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Color(0xFF9CA3AF)),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _hasSearched = false);
                      },
                    )
                  : null,
              border: InputBorder.none,
            ),
            onSubmitted: _performSearch,
            onChanged: (value) => setState(() {}),
          ),
        ),
        actions: [
          if (_hasSearched)
            TextButton(
              onPressed: () {
                _searchController.clear();
                setState(() => _hasSearched = false);
              },
              child: const Text('إلغاء', style: TextStyle(color: Color(0xFFD4AF37))),
            ),
        ],
      ),
      body: _hasSearched ? _buildSearchResults() : _buildSearchSuggestions(),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // سجل البحث
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عمليات البحث الأخيرة',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: _clearRecentSearches,
                  child: const Text('مسح الكل', style: TextStyle(color: Color(0xFFF6465D))),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = search;
                    _performSearch(search);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2329),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFF2B3139)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.history, color: Color(0xFF9CA3AF), size: 16),
                        const SizedBox(width: 8),
                        Text(search, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
          
          // بحث شائع
          const Text(
            'البحث الشائع',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _popularSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2329),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: const Color(0xFF2B3139)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.trending_up, color: Color(0xFFD4AF37), size: 16),
                      const SizedBox(width: 8),
                      Text(search, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          
          // فئات مقترحة
          const Text(
            'تصفح الفئات',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildCategoryChip('إلكترونيات', Icons.devices, const Color(0xFF2196F3)),
              _buildCategoryChip('أزياء', Icons.checkroom, const Color(0xFFE91E63)),
              _buildCategoryChip('سيارات', Icons.directions_car, const Color(0xFFF6465D)),
              _buildCategoryChip('عقارات', Icons.home, const Color(0xFF4CAF50)),
              _buildCategoryChip('أثاث', Icons.chair, const Color(0xFFFF9800)),
              _buildCategoryChip('مطاعم', Icons.restaurant, const Color(0xFF9C27B0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        _performSearch(label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2329),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2B3139)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2B3139)),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  result['image'] as String,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 60,
                    height: 60,
                    color: const Color(0xFF2B3139),
                    child: const Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['name'] as String,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result['store'] as String,
                      style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${result['price']} ريال',
                          style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text('${result['rating']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/product/${result['name']}');
                },
                icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFD4AF37), size: 18),
              ),
            ],
          ),
        );
      },
    );
  }
}
