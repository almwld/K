import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import 'stores/store_detail_screen.dart';
import 'map/interactive_map_screen.dart';

class NearbyScreen extends StatelessWidget {
  const NearbyScreen({super.key});

  // بيانات المتاجر القريبة مع شعار Flex Yemen
  final List<Map<String, dynamic>> _nearbyStores = const [
    {
      'id': '1',
      'name': 'متجر الذهبية',
      'category': 'إلكترونيات',
      'distance': '0.3 كم',
      'rating': 4.5,
      'reviews': 128,
      'isOpen': true,
      'address': 'شارع الستين، صنعاء',
      'lat': 15.3694,
      'lng': 44.1910,
    },
    {
      'id': '2',
      'name': 'متجر الكس',
      'category': 'أزياء',
      'distance': '0.8 كم',
      'rating': 4.8,
      'reviews': 256,
      'isOpen': true,
      'address': 'شارع حدة، صنعاء',
      'lat': 15.3650,
      'lng': 44.1950,
    },
    {
      'id': '3',
      'name': 'متجر السيم',
      'category': 'سوبر ماركت',
      'distance': '1.2 كم',
      'rating': 4.3,
      'reviews': 89,
      'isOpen': false,
      'address': 'شارع الزراعة، صنعاء',
      'lat': 15.3720,
      'lng': 44.1960,
    },
    {
      'id': '4',
      'name': 'مطعم النور',
      'category': 'مطاعم',
      'distance': '0.5 كم',
      'rating': 4.6,
      'reviews': 345,
      'isOpen': true,
      'address': 'شارع التحرير، صنعاء',
      'lat': 15.3680,
      'lng': 44.1930,
    },
    {
      'id': '5',
      'name': 'صيدلية الحياة',
      'category': 'صحة',
      'distance': '0.7 كم',
      'rating': 4.4,
      'reviews': 67,
      'isOpen': true,
      'address': 'شارع القاهرة، صنعاء',
      'lat': 15.3630,
      'lng': 44.1890,
    },
    {
      'id': '6',
      'name': 'مخبز الريف',
      'category': 'مخبوزات',
      'distance': '1.0 كم',
      'rating': 4.7,
      'reviews': 156,
      'isOpen': true,
      'address': 'شارع خولان، صنعاء',
      'lat': 15.3660,
      'lng': 44.2000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('بالقرب منك', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/svg/search.svg', width: 24, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // خريطة تفاعلية مصغرة
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InteractiveMapScreen())),
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD4AF37), width: 1),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      color: const Color(0xFF1A2A44),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/svg/location.svg', width: 40, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                          const SizedBox(height: 8),
                          const Text('اضغط لعرض الخريطة التفاعلية', style: TextStyle(color: Colors.white70)),
                          const Text('📍 صنعاء، اليمن', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/svg/map.svg', width: 14, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                          const SizedBox(width: 4),
                          const Text('فتح الخريطة', style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // فلتر المسافة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text('المسافة:', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 12),
                  _buildDistanceChip('1 كم', true),
                  _buildDistanceChip('3 كم', false),
                  _buildDistanceChip('5 كم', false),
                  _buildDistanceChip('10 كم', false),
                  _buildDistanceChip('كل المتاجر', false),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // عنوان المتاجر القريبة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المتاجر القريبة منك', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${_nearbyStores.length} متجر', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // قائمة المتاجر
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _nearbyStores.length,
              itemBuilder: (context, index) {
                final store = _nearbyStores[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(storeId: store['id']!))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2329),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2B3139)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // شعار المتجر مع شارة Flex Yemen
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/svg/store.svg', width: 35, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                              // شارة Flex Yemen على المتجر
                              Positioned(
                                bottom: -2,
                                right: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD4AF37),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFF0B0E11), width: 2),
                                  ),
                                  child: SvgPicture.asset('assets/icons/svg/crown.svg', width: 12, height: 12, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      store['name']!,
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: (store['isOpen'] as bool) ? const Color(0xFF0ECB81).withOpacity(0.2) : const Color(0xFFF6465D).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      store['isOpen'] as bool ? 'مفتوح' : 'مغلق',
                                      style: TextStyle(
                                        color: store['isOpen'] as bool ? const Color(0xFF0ECB81) : const Color(0xFFF6465D),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(store['category']!, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/svg/location.svg', width: 12, colorFilter: const ColorFilter.mode(Color(0xFF5E6673), BlendMode.srcIn)),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(store['address']!, style: const TextStyle(color: Color(0xFF5E6673), fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4AF37).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/svg/location.svg', width: 10, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                                        const SizedBox(width: 4),
                                        Text(store['distance']!, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Row(
                                    children: [
                                      ...List.generate(5, (i) => SvgPicture.asset('assets/icons/svg/star_gold.svg', width: 12, colorFilter: ColorFilter.mode(i < (store['rating'] as double).floor() ? Colors.amber : Colors.grey, BlendMode.srcIn))),
                                      const SizedBox(width: 6),
                                      Text('${store['rating']}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                                      const SizedBox(width: 4),
                                      Text('(${store['reviews']}+)', style: const TextStyle(color: Color(0xFF5E6673), fontSize: 10)),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 12)),
        selected: isSelected,
        onSelected: (_) {},
        backgroundColor: const Color(0xFF1E2329),
        selectedColor: const Color(0xFFD4AF37),
        checkmarkColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}
