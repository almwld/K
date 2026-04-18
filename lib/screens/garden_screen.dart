import 'package:flutter/material.dart';
import '../services/cache/local_storage_service.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final LocalStorageService _storage = LocalStorageService();
  int _points = 0;
  int _streakDays = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _storage.init();
    setState(() {
      _points = _storage.getGardenPoints();
      _streakDays = _storage.getStreakDays();
      _isLoading = false;
    });
  }

  Future<void> _addPoints(int points) async {
    setState(() {
      _points += points;
    });
    await _storage.setGardenPoints(_points);
  }

  Future<void> _incrementStreak() async {
    setState(() {
      _streakDays++;
    });
    await _storage.setStreakDays(_streakDays);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'حديقة النقاط'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.gold))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green[400]!, Colors.green[700]!],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.park, size: 80, color: Colors.white),
                        const SizedBox(height: 16),
                        const Text('نقاطك', style: TextStyle(fontSize: 18, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('$_points', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
                            const SizedBox(width: 8),
                            Text('$_streakDays يوم متتالي', style: const TextStyle(fontSize: 16, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildActionCard('تسجيل دخول يومي', 'احصل على 10 نقاط', Icons.login, () => _addPoints(10)),
                  const SizedBox(height: 16),
                  _buildActionCard('إتمام عملية شراء', 'احصل على 50 نقطة', Icons.shopping_bag, () => _addPoints(50)),
                  const SizedBox(height: 16),
                  _buildActionCard('دعوة صديق', 'احصل على 100 نقطة', Icons.share, () => _addPoints(100)),
                  const SizedBox(height: 16),
                  _buildActionCard('كتابة تقييم', 'احصل على 20 نقطة', Icons.star, () => _addPoints(20)),
                ],
              ),
            ),
    );
  }

  Widget _buildActionCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.gold),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
