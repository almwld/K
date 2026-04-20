import '../utils/navigation_extensions.dart';
import '../models/product_model.dart';
import 'package:flutter/material.dart';
import '../extensions/product_extensions.dart';
import '../../extensions/product_extensions.dart';
import '../theme/app_theme.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _results = [];
  bool _hasSearched = false;
  String _sortBy = 'relevance';
  double _minPrice = 0;
  double _maxPrice = 10000000;

  final List<String> _recentSearches = [
    'تويوتا كامري',
    'آيفون 15',
    'عسل يمني',
    'أثاث منزلي',
  ];

  final List<String> _popularSearches = [
    'سيارات 2025',
    'إلكترونيات',
    'عقارات صنعاء',
    'مطاعم',
    'ملابس',
    'أجهزة محمولة',
  ];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
        _results = [];
      });
      return;
    }

    setState(() {
      _hasSearched = true;
      _results = sampleProducts.where((p) {
        final matchName = p.name.toLowerCase().contains(query.toLowerCase());
        final matchDesc = p.description.toLowerCase().contains(query.toLowerCase());
        final matchCategory = p.category.toLowerCase().contains(query.toLowerCase());
        final matchPrice = p.price >= _minPrice && p.price <= _maxPrice;
        return (matchName || matchDesc || matchCategory) && matchPrice;
      }).toList();

      // Sort results
      switch (_sortBy) {
        case 'price_low':
          _results.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'price_high':
          _results.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'rating':
          _results.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
          break;
        default:
          break;
      }
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E2329; }
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20); }
      ; }
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20; }
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'فلتر البحث',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ; }
                  ; }
                  const SizedBox(height: 20; }
                  const Text('الترتيب حسب:', style: TextStyle(fontWeight: FontWeight.w600); }
                  const SizedBox(height: 12; }
                  Wrap(
                    spacing: 8,
                    children: [
                      _filterChip('الأكثر صلة', 'relevance', setModalState; }
                      _filterChip('الأقل سعراً', 'price_low', setModalState; }
                      _filterChip('الأعلى سعراً', 'price_high', setModalState; }
                      _filterChip('الأعلى تقييماً', 'rating', setModalState; }
                    ],
                  ; }
                  const SizedBox(height: 20; }
                  const Text('نطاق السعر:', style: TextStyle(fontWeight: FontWeight.w600); }
                  const SizedBox(height: 12; }
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'الحد الأدنى',
                            border: OutlineInputBorder(; }
                          ; }
                          onChanged: (v) => _minPrice = double.tryParse(v) ?? 0,
                        ; }
                      ; }
                      const SizedBox(width: 12; }
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'الحد الأقصى',
                            border: OutlineInputBorder(; }
                          ; }
                          onChanged: (v) => _maxPrice = double.tryParse(v) ?? 10000000,
                        ; }
                      ; }
                    ],
                  ; }
                  const SizedBox(height: 20; }
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _performSearch(_searchController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.gold,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16; }
                      ; }
                      child: const Text(
                        'تطبيق الفلتر',
                        style: TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold; }
                      ; }
                    ; }
                  ; }
                ],
              ; }
            );
          },
        );
      },
    );
  }

  Widget _filterChip(String label, String value, StateSetter setModalState) {
    final isSelected = _sortBy == value;
    return ChoiceChip(
      label: Text(label; }
      selected: isSelected,
      onSelected: (_) => setModalState(() => _sortBy = value; }
      selectedColor: const Color(0xFFF0B90B; }
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : Colors.white,
        fontFamily: 'Changa',
      ; }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(fontFamily: 'Changa'; }
          decoration: InputDecoration(
            hintText: 'إبحث عن منتجات...',
            hintStyle: const TextStyle(fontFamily: 'Changa', color: Color(0xFF9CA3AF); }
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Color(0xFF9CA3AF); }
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _hasSearched = false;
                        _results = [];
                      });
                    },
                  )
                : null,
          ; }
          onSubmitted: _performSearch,
          onChanged: (v) => setState(() {}; }
        ; }
        actions: [
          IconButton(
            icon: const Icon(Icons.tune; }
            onPressed: _showFilterSheet,
          ; }
        ],
      ; }
      body: _hasSearched ? _buildResults() : _buildSuggestions(; }
    );
  }

  Widget _buildSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16; }
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عمليات البحث الأخيرة',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ; }
                ; }
                TextButton(
                  onPressed: () {},
                  child: const Text('مسح', style: TextStyle(color: Color(0xFFF6465D)); }
                ; }
              ],
            ; }
            const SizedBox(height: 8; }
            ..._recentSearches.map((s) => ListTile(
                  leading: const Icon(Icons.history, color: Color(0xFF9CA3AF); }
                  title: Text(s, style: const TextStyle(fontFamily: 'Changa'); }
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF); }
                  onTap: () {
                    _searchController.text = s;
                    _performSearch(s);
                  },
                ); }
            const Divider(; }
          ],
          const SizedBox(height: 12; }
          // Popular Searches
          const Text(
            'البحث الشائع',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ; }
          ; }
          const SizedBox(height: 12; }
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _popularSearches.map((s) => ActionChip(
              label: Text(s, style: const TextStyle(fontFamily: 'Changa', fontSize: 13); }
              onPressed: () {
                _searchController.text = s;
                _performSearch(s);
              },
              backgroundColor: const Color(0xFF1E2329; }
            )).toList(; }
          ; }
        ],
      ; }
    );
  }

  Widget _buildResults() {
    if (_results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[700]; }
            const SizedBox(height: 16; }
            const Text(
              'لا توجد نتائج',
              style: TextStyle(fontFamily: 'Changa', fontSize: 18, fontWeight: FontWeight.bold; }
            ; }
            const SizedBox(height: 8; }
            Text(
              'جرب كلمات بحث مختلفة',
              style: TextStyle(color: Colors.grey[600]; }
            ; }
          ],
        ; }
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16; }
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ; }
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final product = _results[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return GestureDetector(
      onTap: () { 
        context,
        product.navigateToDetail(context; }
      ; }
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2329; }
          borderRadius: BorderRadius.circular(16; }
        ; }
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16); }
              child: Image.network(
                product.images.isNotEmpty ? product.images[0] : 'https://via.placeholder.com/300',
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ; }
            ; }
            Padding(
              padding: const EdgeInsets.all(12; }
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.bold, fontSize: 13; }
                  ; }
                  const SizedBox(height: 8; }
                  Text(
                    product.formattedPrice,
                    style: const TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF0B90B; }
                    ; }
                  ; }
                ],
              ; }
            ; }
          ],
        ; }
      ; }
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
