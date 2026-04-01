import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class MapNearbyScreen extends StatefulWidget {
  const MapNearbyScreen({super.key});

  @override
  State<MapNearbyScreen> createState() => _MapNearbyScreenState();
}

class _MapNearbyScreenState extends State<MapNearbyScreen> {
  String filter = 'كل الأماكن';
  final List<Map<String, String>> places = [
    {'name': 'مقهى النور', 'type': 'مقهى', 'distance': '200 م'},
    {'name': 'مول الرياض', 'type': 'مول', 'distance': '1.2 كم'},
    {'name': 'متجر التقنية', 'type': 'متجر', 'distance': '450 م'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأماكن القريبة'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: filter,
                    items: const [
                      DropdownMenuItem(value: 'كل الأماكن', child: Text('كل الأماكن')),
                      DropdownMenuItem(value: 'المطاعم', child: Text('المطاعم')),
                      DropdownMenuItem(value: 'المولات', child: Text('المولات')),
                      DropdownMenuItem(value: 'المتاجر', child: Text('المتاجر')),
                    ],
                    onChanged: (v) => setState(() => filter = v ?? 'كل الأماكن'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.getCardColor(context),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تحديث الموقع'))),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: places.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final p = places[i];
                return ListTile(
                  tileColor: AppTheme.getCardColor(context),
                  leading: const Icon(Icons.location_on),
                  title: Text(p['name']!),
                  subtitle: Text('${p['type']} • ${p['distance']}'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                    child: const Text('عرض'),
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
