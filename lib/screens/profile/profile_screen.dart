import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF0B0E11),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFD4AF37).withOpacity(0.3), const Color(0xFF0B0E11)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD4AF37), Color(0xFFAA8C2C)],
                        ),
                      ),
                      child: const Center(
                        child: Icon(Icons.person, color: Colors.white, size: 60),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'أحمد محمد',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@ahmed_flex',
                      style: TextStyle(color: const Color(0xFFD4AF37), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Color(0xFFD4AF37)),
                onPressed: () {},
              ),
            ],
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // إحصائيات
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2329),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2B3139)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('المتابعون', '1,234'),
                        Container(width: 1, height: 30, color: const Color(0xFF2B3139)),
                        _buildStatItem('المتابَعون', '567'),
                        Container(width: 1, height: 30, color: const Color(0xFF2B3139)),
                        _buildStatItem('النقاط', '8,900'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // قائمة الخيارات
                  _buildMenuItem(Icons.person_outline, 'معلوماتي الشخصية'),
                  _buildMenuItem(Icons.shopping_bag_outlined, 'طلباتي'),
                  _buildMenuItem(Icons.favorite_border, 'المفضلة'),
                  _buildMenuItem(Icons.account_balance_wallet_outlined, 'المحفظة'),
                  _buildMenuItem(Icons.location_on_outlined, 'العناوين المحفوظة'),
                  _buildMenuItem(Icons.notifications_none, 'الإشعارات'),
                  _buildMenuItem(Icons.language, 'اللغة'),
                  _buildMenuItem(Icons.help_outline, 'المساعدة والدعم'),
                  _buildMenuItem(Icons.info_outline, 'عن التطبيق'),
                  
                  const SizedBox(height: 16),
                  
                  // زر تسجيل الخروج
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFF6465D)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('تسجيل الخروج', style: TextStyle(color: Color(0xFFF6465D), fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AF37)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF5E6673), size: 14),
      onTap: () {},
    );
  }
}
