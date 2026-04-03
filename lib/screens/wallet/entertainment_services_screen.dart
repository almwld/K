import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class EntertainmentServicesScreen extends StatefulWidget {
  const EntertainmentServicesScreen({super.key});

  @override
  State<EntertainmentServicesScreen> createState() => _EntertainmentServicesScreenState();
}

class _EntertainmentServicesScreenState extends State<EntertainmentServicesScreen> {
  String _selectedCategory = 'all';
  String _selectedService = '';
  final TextEditingController _emailController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'الكل', 'icon': Icons.grid_view, 'color': AppTheme.goldColor},
    {'id': 'streaming', 'name': 'بث مباشر', 'icon': Icons.live_tv, 'color': 0xFFF44336},
    {'id': 'music', 'name': 'موسيقى', 'icon': Icons.music_note, 'color': 0xFF4CAF50},
    {'id': 'gaming', 'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': 0xFF9C27B0},
    {'id': 'sports', 'name': 'رياضة', 'icon': Icons.sports_soccer, 'color': 0xFFFF9800},
  ];

  final List<Map<String, dynamic>> _services = [
    // منصات البث
    {'name': 'Netflix', 'value': 'Basic', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Netflix', 'value': 'Standard', 'price': '22,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Netflix', 'value': 'Premium', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg', 'color': 0xFFF44336, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Shahid', 'value': 'VIP', 'price': '12,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Shahid', 'value': 'VIP+', 'price': '18,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Amazon Prime', 'value': 'شهر', 'price': '14,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/11/Amazon_Prime_Video_logo.svg', 'color': 0xFF2196F3, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Disney+', 'value': 'شهر', 'price': '18,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/3/3e/Disney%2B_logo.svg', 'color': 0xFF2196F3, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'HBO Max', 'value': 'شهر', 'price': '20,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'Apple TV+', 'value': 'شهر', 'price': '15,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Apple_Music_icon.svg', 'color': 0xFF9C27B0, 'category': 'streaming', 'type': 'شهر'},
    {'name': 'YouTube Premium', 'value': 'شهر', 'price': '10,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg', 'color': 0xFFF44336, 'category': 'streaming', 'type': 'شهر'},
    
    // منصات الموسيقى
    {'name': 'Spotify', 'value': 'شهر', 'price': '8,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'music', 'type': 'شهر'},
    {'name': 'Spotify', 'value': 'سنة', 'price': '85,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg', 'color': 0xFF4CAF50, 'category': 'music', 'type': 'سنة'},
    {'name': 'Anghami', 'value': 'شهر', 'price': '7,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE91E63, 'category': 'music', 'type': 'شهر'},
    {'name': 'Anghami', 'value': 'سنة', 'price': '75,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE91E63, 'category': 'music', 'type': 'سنة'},
    {'name': 'Apple Music', 'value': 'شهر', 'price': '9,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5f/Apple_Music_icon.svg', 'color': 0xFF9C27B0, 'category': 'music', 'type': 'شهر'},
    
    // منصات الألعاب
    {'name': 'Steam', 'value': '10\$', 'price': '11,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'gaming', 'type': 'بطاقة'},
    {'name': 'Steam', 'value': '25\$', 'price': '27,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/8/83/Steam_icon_logo.svg', 'color': 0xFF4CAF50, 'category': 'gaming', 'type': 'بطاقة'},
    {'name': 'PlayStation', 'value': '10\$', 'price': '12,500', 'image': 'https://upload.wikimedia.org/wikipedia/commons/2/2a/PlayStation_logo.svg', 'color': 0xFF2196F3, 'category': 'gaming', 'type': 'بطاقة'},
    {'name': 'PlayStation', 'value': '25\$', 'price': '31,250', 'image': 'https://upload.wikimedia.org/wikipedia/commons/2/2a/PlayStation_logo.svg', 'color': 0xFF2196F3, 'category': 'gaming', 'type': 'بطاقة'},
    {'name': 'Xbox', 'value': '10\$', 'price': '12,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Xbox_one_logo.svg', 'color': 0xFF4CAF50, 'category': 'gaming', 'type': 'بطاقة'},
    {'name': 'Xbox', 'value': '25\$', 'price': '30,000', 'image': 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Xbox_one_logo.svg', 'color': 0xFF4CAF50, 'category': 'gaming', 'type': 'بطاقة'},
    
    // منصات الرياضة
    {'name': 'BeIN Sports', 'value': 'شهر', 'price': '25,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20, 'category': 'sports', 'type': 'شهر'},
    {'name': 'BeIN Sports', 'value': 'سنة', 'price': '250,000', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20, 'category': 'sports', 'type': 'سنة'},
  ];

  List<Map<String, dynamic>> get _filteredServices {
    if (_selectedCategory == 'all') return _services;
    return _services.where((s) => s['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredServices;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خدمات ترفيهية'),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final service = filtered[index];
                return _buildServiceCard(service);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category['id'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: FilterChip(
              label: Row(children: [Icon(category['icon'], size: 16), const SizedBox(width: 4), Text(category['name'])]),
              selected: isSelected,
              onSelected: (selected) => setState(() => _selectedCategory = selected ? category['id'] : 'all'),
              selectedColor: AppTheme.goldColor,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () => _showPurchaseDialog(service),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getCardColor(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70, height: 70,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Color(service['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: CachedNetworkImage(imageUrl: service['image'], placeholder: (_, __) => Icon(Icons.apps, color: Color(service['color']), size: 40),
                errorWidget: (_, __, ___) => Icon(Icons.apps, color: Color(service['color']), size: 40)),
            ),
            const SizedBox(height: 12),
            Text(service['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(service['value'], style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 12)),
            Text('${service['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Color(service['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(service['type'], style: TextStyle(color: Color(service['color']), fontSize: 10))),
          ],
        ),
      ),
    );
  }

  void _showPurchaseDialog(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('شراء ${service['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(imageUrl: service['image'], width: 80, height: 80, errorWidget: (_, __, ___) => Icon(Icons.apps, size: 50)),
            const SizedBox(height: 16),
            Text('${service['name']} - ${service['value']}'),
            Text('المدة: ${service['type']}'),
            Text('السعر: ${service['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              if (_emailController.text.isNotEmpty) {
                Navigator.pop(context);
                _showSuccessDialog(service);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('شراء'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> service) {
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
            Text('تم شراء ${service['name']} - ${service['value']}'),
            Text('سيتم إرسال بيانات الدخول إلى بريدك الإلكتروني'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
