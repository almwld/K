import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricAuth = false;
  bool _twoFactorAuth = false;
  bool _loginAlerts = true;
  bool _savePasswords = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'إعدادات الأمان'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Password Section
          _sectionTitle('كلمة المرور'),
          _buildCard([
            _buildListTile(
              icon: Icons.lock,
              title: 'تغيير كلمة المرور',
              subtitle: 'آخر تحديث: منذ شهر',
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 20),

          // Biometric Section
          _sectionTitle('المصادقة البيومترية'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.fingerprint,
              title: 'قفل البصمة / Face ID',
              subtitle: 'فتح التطبيق بالبصمة',
              value: _biometricAuth,
              onChanged: (v) => setState(() => _biometricAuth = v),
            ),
          ]),
          const SizedBox(height: 20),

          // 2FA Section
          _sectionTitle('المصادقة الثنائية'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.security,
              title: 'تفعيل 2FA',
              subtitle: 'حماية إضافية لحسابك',
              value: _twoFactorAuth,
              onChanged: (v) => setState(() => _twoFactorAuth = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Login Alerts
          _sectionTitle('تنبيهات تسجيل الدخول'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.notifications_active,
              title: 'تنبيه عند تسجيل الدخول',
              subtitle: 'إشعار عند دخول جديد',
              value: _loginAlerts,
              onChanged: (v) => setState(() => _loginAlerts = v),
            ),
            _buildSwitchTile(
              icon: Icons.password,
              title: 'حفظ كلمات المرور',
              subtitle: 'تذكر كلمات المرور للدخول السريع',
              value: _savePasswords,
              onChanged: (v) => setState(() => _savePasswords = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Connected Devices
          _sectionTitle('الأجهزة المتصلة'),
          _buildCard([
            _buildDeviceTile('iPhone 15 Pro', 'صنعاء، اليمن', true, 'الآن'),
            _buildDeviceTile('Chrome - Windows', 'صنعاء، اليمن', false, 'منذ 2 يوم'),
          ]),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF0B90B),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0B90B).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFFF0B90B), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF)),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF0B90B).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFFF0B90B), size: 22),
      ),
      title: Text(title, style: const TextStyle(fontFamily: 'Changa', fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFFF0B90B),
    );
  }

  Widget _buildDeviceTile(String name, String location, bool isCurrent, String time) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFF0ECB81).withOpacity(0.2) : Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          isCurrent ? Icons.phone_iphone : Icons.computer,
          color: isCurrent ? const Color(0xFF0ECB81) : Colors.grey,
          size: 22,
        ),
      ),
      title: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (isCurrent)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF0ECB81).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'الجهاز الحالي',
                style: TextStyle(fontSize: 10, color: Color(0xFF0ECB81)),
              ),
            ),
        ],
      ),
      subtitle: Text('$location · $time', style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
      trailing: isCurrent
          ? null
          : TextButton(
              onPressed: () {},
              child: const Text('إنهاء', style: TextStyle(color: Color(0xFFF6465D))),
            ),
    );
  }
}
