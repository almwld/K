import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class SimpleMapScreen extends StatelessWidget {
  const SimpleMapScreen({super.key});

  final List<Map<String, String>> _locations = const [
    {'name': 'صنعاء', 'lat': '15.3694', 'lng': '44.1910'},
    {'name': 'عدن', 'lat': '12.7855', 'lng': '45.0187'},
    {'name': 'تعز', 'lat': '13.5776', 'lng': '44.0179'},
    {'name': 'الحديدة', 'lat': '14.7909', 'lng': '42.9712'},
    {'name': 'المكلا', 'lat': '14.5424', 'lng': '49.1278'},
  ];

  void _openGoogleMaps(String lat, String lng, String name) {
    // فتح خرائط جوجل
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    // يمكن استخدام url_launcher لفتح الرابط
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الخريطة'),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://www.google.com/maps/vt/data=sample'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 50, color: AppTheme.goldColor),
                  const SizedBox(height: 8),
                  Text(
                    'خريطة اليمن',
                    style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                final location = _locations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.location_on, color: AppTheme.goldColor),
                    title: Text(location['name']!),
                    subtitle: Text('خط العرض: ${location['lat']}، خط الطول: ${location['lng']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('سيتم فتح ${location['name']} في خرائط جوجل قريباً')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
