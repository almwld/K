import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('الأمان', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      ),
      body: ListView(
        children: [
          _buildSection('كلمة المرور'),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'تغيير كلمة المرور',
            subtitle: 'تحديث كلمة المرور الخاصة بك',
            onTap: () => _showChangePasswordDialog(),
          ),
          const Divider(),
          _buildSection('المصادقة'),
          SwitchListTile(
            title: const Text('المصادقة البيومترية', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('بصمة الإصبع أو Face ID'),
            value: _biometricEnabled,
            onChanged: (v) => setState(() => _biometricEnabled = v),
            activeColor: AppTheme.binanceGold,
          ),
          SwitchListTile(
            title: const Text('التحقق بخطوتين (2FA)', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: const Text('حماية إضافية لحسابك'),
            value: _twoFactorEnabled,
            onChanged: (v) => setState(() => _twoFactorEnabled = v),
            activeColor: AppTheme.binanceGold,
          ),
          const Divider(),
          _buildSection('الأجهزة المتصلة'),
          _buildMenuItem(
            icon: Icons.phone_android,
            title: 'iPhone 15 Pro',
            subtitle: 'آخر دخول: اليوم، صنعاء',
            trailing: const Text('هذا الجهاز', style: TextStyle(color: AppTheme.binanceGold, fontSize: 12)),
            onTap: () {},
          ),
          _buildMenuItem(
            icon: Icons.laptop,
            title: 'MacBook Pro',
            subtitle: 'آخر دخول: أمس، صنعاء',
            onTap: () {},
          ),
          const Divider(),
          _buildSection('جلسات الدخول'),
          _buildMenuItem(
            icon: Icons.history,
            title: 'سجل الدخول',
            subtitle: 'عرض جميع جلسات الدخول السابقة',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: TextStyle(color: AppTheme.binanceGold, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.binanceGold),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF5E6673)),
      onTap: onTap,
    );
  }

  void _showChangePasswordDialog() {
    final currentPassword = TextEditingController();
    final newPassword = TextEditingController();
    final confirmPassword = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تغيير كلمة المرور', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPassword,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'كلمة المرور الحالية',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPassword,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'كلمة المرور الجديدة',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPassword,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'تأكيد كلمة المرور',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF)))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تغيير كلمة المرور'), backgroundColor: AppTheme.binanceGreen),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
            child: const Text('تغيير', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
