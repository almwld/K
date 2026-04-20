import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  // Push Notifications
  bool _pushOrders = true;
  bool _pushPromotions = true;
  bool _pushMessages = true;
  bool _pushPriceDrops = true;
  bool _pushFlashSales = true;
  bool _pushNewFollowers = false;

  // Email Notifications
  bool _emailOrders = true;
  bool _emailPromotions = false;
  bool _emailNewsletter = true;
  bool _emailSecurity = true;

  // SMS Notifications
  bool _smsOrders = true;
  bool _smsPromotions = false;
  bool _smsSecurity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'إعدادات الإشعارات'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Master Toggle
          _buildMasterToggle(),
          const SizedBox(height: 20),

          // Push Notifications
          _sectionTitle('إشعارات Push'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.shopping_bag,
              title: 'الطلبات',
              subtitle: 'تحديثات حالة الطلبات',
              value: _pushOrders,
              onChanged: (v) => setState(() => _pushOrders = v),
            ),
            _buildSwitchTile(
              icon: Icons.local_offer,
              title: 'العروض والخصومات',
              subtitle: 'آخر العروض والكوبونات',
              value: _pushPromotions,
              onChanged: (v) => setState(() => _pushPromotions = v),
            ),
            _buildSwitchTile(
              icon: Icons.message,
              title: 'الرسائل',
              subtitle: 'رسائل المحادثات الجديدة',
              value: _pushMessages,
              onChanged: (v) => setState(() => _pushMessages = v),
            ),
            _buildSwitchTile(
              icon: Icons.trending_down,
              title: 'انخفاض الأسعار',
              subtitle: 'عند انخفاض سعر منتج تتابعه',
              value: _pushPriceDrops,
              onChanged: (v) => setState(() => _pushPriceDrops = v),
            ),
            _buildSwitchTile(
              icon: Icons.flash_on,
              title: 'عروض البرق',
              subtitle: 'تنبيهات عروض البرق',
              value: _pushFlashSales,
              onChanged: (v) => setState(() => _pushFlashSales = v),
            ),
            _buildSwitchTile(
              icon: Icons.person_add,
              title: 'متابعين جدد',
              subtitle: 'عند متابعة جديدة لمتجرك',
              value: _pushNewFollowers,
              onChanged: (v) => setState(() => _pushNewFollowers = v),
            ),
          ]),
          const SizedBox(height: 20),

          // Email
          _sectionTitle('البريد الإلكتروني'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.receipt,
              title: 'تأكيد الطلبات',
              subtitle: 'إيصالات وتحديثات الطلبات',
              value: _emailOrders,
              onChanged: (v) => setState(() => _emailOrders = v),
            ),
            _buildSwitchTile(
              icon: Icons.campaign,
              title: 'العروض الترويجية',
              subtitle: 'رسائل ترويجية وخصومات',
              value: _emailPromotions,
              onChanged: (v) => setState(() => _emailPromotions = v),
            ),
            _buildSwitchTile(
              icon: Icons.article,
              title: 'النشرة الإخبارية',
              subtitle: 'آخر أخبار Flex Yemen',
              value: _emailNewsletter,
              onChanged: (v) => setState(() => _emailNewsletter = v),
            ),
            _buildSwitchTile(
              icon: Icons.security,
              title: 'تنبيهات الأمان',
              subtitle: 'تسجيل دخول وتغييرات أمنية',
              value: _emailSecurity,
              onChanged: (v) => setState(() => _emailSecurity = v),
            ),
          ]),
          const SizedBox(height: 20),

          // SMS
          _sectionTitle('رسائل SMS'),
          _buildCard([
            _buildSwitchTile(
              icon: Icons.shopping_bag,
              title: 'تأكيد الطلبات',
              subtitle: 'تأكيدات عبر الرسائل',
              value: _smsOrders,
              onChanged: (v) => setState(() => _smsOrders = v),
            ),
            _buildSwitchTile(
              icon: Icons.campaign,
              title: 'العروض',
              subtitle: 'عروض خاصة عبر SMS',
              value: _smsPromotions,
              onChanged: (v) => setState(() => _smsPromotions = v),
            ),
            _buildSwitchTile(
              icon: Icons.security,
              title: 'تنبيهات الأمان',
              subtitle: 'رموز التحقق والتنبيهات',
              value: _smsSecurity,
              onChanged: (v) => setState(() => _smsSecurity = v),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildMasterToggle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF0B90B), Color(0xFFFFA000)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'جميع الإشعارات',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'تفعيل/تعطيل جميع الإشعارات',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: Colors.white,
            activeTrackColor: Colors.black.withOpacity(0.3),
          ),
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
}
