import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _chatNotifications = true;
  bool _offerNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الإشعارات'),
      body: ListView(
        children: [
          _buildSection('الإشعارات العامة'),
          _buildSwitch('إشعارات التطبيق', 'استلام الإشعارات على الهاتف', _pushNotifications, (v) => setState(() => _pushNotifications = v)),
          _buildSwitch('إشعارات البريد', 'استلام الإشعارات عبر البريد الإلكتروني', _emailNotifications, (v) => setState(() => _emailNotifications = v)),
          _buildSwitch('إشعارات SMS', 'استلام الرسائل النصية', _smsNotifications, (v) => setState(() => _smsNotifications = v)),
          
          _buildSection('إشعارات الدردشة'),
          _buildSwitch('رسائل جديدة', 'استلام إشعارات الرسائل الجديدة', _chatNotifications, (v) => setState(() => _chatNotifications = v)),
          _buildSwitch('الصوت', 'تشغيل صوت الإشعارات', _soundEnabled, (v) => setState(() => _soundEnabled = v)),
          _buildSwitch('الاهتزاز', 'تشغيل الاهتزاز', _vibrationEnabled, (v) => setState(() => _vibrationEnabled = v)),
          
          _buildSection('العروض والتنبيهات'),
          _buildSwitch('العروض الخاصة', 'استلام إشعارات العروض والخصومات', _offerNotifications, (v) => setState(() => _offerNotifications = v)),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppTheme.gold,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.whiteSecondary)),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.gold,
    );
  }
}

