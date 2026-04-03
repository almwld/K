import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _orderUpdates = true;
  bool _auctionUpdates = true;
  bool _chatMessages = true;
  bool _promotions = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _dailyDigest = false;
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات الإشعارات'),
      body: ListView(
        children: [
          _buildSection('عام'),
          _buildSwitch('إشعارات التطبيق', 'استلام الإشعارات على الهاتف', _pushNotifications, (v) => setState(() => _pushNotifications = v)),
          _buildSwitch('إشعارات البريد الإلكتروني', 'استلام الإشعارات عبر البريد', _emailNotifications, (v) => setState(() => _emailNotifications = v)),
          _buildSwitch('إشعارات SMS', 'استلام الرسائل النصية', _smsNotifications, (v) => setState(() => _smsNotifications = v)),
          
          _buildSection('نوع الإشعارات'),
          _buildSwitch('تحديثات الطلبات', 'إشعارات حالة الطلب والتوصيل', _orderUpdates, (v) => setState(() => _orderUpdates = v)),
          _buildSwitch('تحديثات المزادات', 'إشعارات المزادات والعروض', _auctionUpdates, (v) => setState(() => _auctionUpdates = v)),
          _buildSwitch('رسائل الدردشة', 'إشعارات الرسائل الجديدة', _chatMessages, (v) => setState(() => _chatMessages = v)),
          _buildSwitch('العروض والخصومات', 'إشعارات العروض الحصرية', _promotions, (v) => setState(() => _promotions = v)),
          _buildSwitch('الملخص اليومي', 'ملخص يومي للنشاط', _dailyDigest, (v) => setState(() => _dailyDigest = v)),
          
          _buildSection('التفضيلات'),
          _buildSwitch('الصوت', 'تشغيل صوت الإشعارات', _soundEnabled, (v) => setState(() => _soundEnabled = v)),
          _buildSwitch('الاهتزاز', 'تشغيل الاهتزاز', _vibrationEnabled, (v) => setState(() => _vibrationEnabled = v)),
          
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حفظ إعدادات الإشعارات'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('حفظ الإعدادات'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(title, style: const TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
  
  Widget _buildSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.goldColor,
    );
  }
}
