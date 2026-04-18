import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List<Map<String, dynamic>> _following = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadFollowing();
  }
  
  void _loadFollowing() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _following = [
          {'name': 'متجر التقنية', 'products': 45, 'followers': 1234, 'avatar': null},
          {'name': 'عقارات فلكس', 'products': 128, 'followers': 5678, 'avatar': null},
          {'name': 'أزياء فلكس', 'products': 89, 'followers': 2345, 'avatar': null},
        ];
        _isLoading = false;
      });
    });
  }
  
  void _unfollow(int index) {
    setState(() {
      _following.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إلغاء المتابعة'), backgroundColor: Colors.orange),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المتابعة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _following.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.people_outline, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                      const SizedBox(height: 16),
                      const Text('لا تتابع أي بائع', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('تابع البائعين لترى إعلاناتهم', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/all_ads'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                        child: const Text('تصفح البائعين'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _following.length,
                  itemBuilder: (context, index) {
                    final seller = _following[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppTheme.gold.withOpacity(0.2),
                            child: Text(seller['name'][0], style: const TextStyle(fontSize: 20)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(seller['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 4),
                                Text('${seller['products']} منتج • ${seller['followers']} متابع', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => _unfollow(index),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.gold),
                            ),
                            child: const Text('إلغاء المتابعة'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
