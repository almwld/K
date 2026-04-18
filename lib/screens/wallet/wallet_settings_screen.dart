import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WalletSettingsScreen extends StatefulWidget {
  const WalletSettingsScreen({super.key});

  @override
  State<WalletSettingsScreen> createState() => _WalletSettingsScreenState();
}

class _WalletSettingsScreenState extends State<WalletSettingsScreen> {
  bool _autoSaveEnabled = true;
  bool _transactionNotifications = true;
  bool _balanceNotifications = true;
  bool _fingerprintPayment = false;
  String _defaultCurrency = 'YER';
  String _language = 'ar';

  final List<Map<String, dynamic>> _currencies = [
    {'code': 'YER', 'name': 'ريال يمني', 'symbol': 'ر.ي', 'rate': '1'},
    {'code': 'SAR', 'name': 'ريال سعودي', 'symbol': 'ر.س', 'rate': '67.5'},
    {'code': 'USD', 'name': 'دولار أمريكي', 'symbol': '\$', 'rate': '250'},
  ];

  final List<Map<String, dynamic>> _securitySettings = [
    {'icon': Icons.fingerprint, 'title': 'المصادقة البيومترية', 'subtitle': 'استخدم البصمة للدفع', 'type': 'switch', 'value': false},
    {'icon': Icons.pin, 'title': 'PIN code', 'subtitle': 'تفعيل الرقم السري للمحفظة', 'type': 'switch', 'value': false},
    {'icon': Icons.security, 'title': 'التحقق بخطوتين', 'subtitle': 'تفعيل الأمان الإضافي', 'type': 'switch', 'value': false},
    {'icon': Icons.notifications_active, 'title': 'إشعارات المعاملات', 'subtitle': 'تنبيه عند إجراء معاملة', 'type': 'switch', 'value': true},
  ];

  final List<Map<String, dynamic>> _paymentLimits = [
    {'title': 'الحد اليومي للتحويل', 'value': '100,000', 'icon': Icons.today, 'color': 0xFF2196F3},
    {'title': 'الحد الشهري للتحويل', 'value': '500,000', 'icon': Icons.calendar_month, 'color': 0xFF4CAF50},
    {'title': 'الحد الأقصى للمعاملة', 'value': '50,000', 'icon': Icons.attach_money, 'color': 0xFFFF9800},
    {'title': 'عدد المعاملات اليومي', 'value': '20', 'icon': Icons.swap_horiz, 'color': 0xFF9C27B0},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إعدادات المحفظة'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrencySection(),
                const SizedBox(height: 16),
                _buildSecuritySection(),
                const SizedBox(height: 16),
                _buildPaymentLimits(),
                const SizedBox(height: 16),
                _buildNotificationSection(),
                const SizedBox(height: 16),
                _buildActionsSection(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('العملة الافتراضية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _defaultCurrency,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _currencies.map((currency) {
              return DropdownMenuItem<String>(
                value: currency['code'],
                child: Row(
                  children: [
                    Text(currency['name']),
                    const SizedBox(width: 8),
                    Text('(${currency['symbol']})', style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _defaultCurrency = value!;
              });
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSwitchTile(
                  'الحفظ التلقائي',
                  'حفظ الإعدادات تلقائياً',
                  _autoSaveEnabled,
                  (value) => setState(() => _autoSaveEnabled = value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('الأمان والحماية', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ..._securitySettings.map((setting) => _buildSecurityTile(setting)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.change_circle),
            label: const Text('تغيير PIN code'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.goldAccent,
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTile(Map<String, dynamic> setting) {
    return SwitchListTile(
      title: Text(setting['title']),
      subtitle: Text(setting['subtitle'], style: const TextStyle(fontSize: 12)),
      value: setting['value'],
      onChanged: (value) {
        setState(() {
          setting['value'] = value;
        });
      },
      activeColor: AppTheme.goldAccent,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.goldAccent,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildPaymentLimits() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('حدود المعاملات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _paymentLimits.length,
            itemBuilder: (context, index) {
              final limit = _paymentLimits[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(limit['color']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(limit['icon'], color: Color(limit['color']), size: 24),
                    const SizedBox(height: 8),
                    Text(limit['title'], style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text(
                      limit['value'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(limit['color']),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('الإشعارات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildSwitchTile(
            'إشعارات المعاملات',
            'تنبيه عند إيداع أو سحب أو تحويل',
            _transactionNotifications,
            (value) => setState(() => _transactionNotifications = value),
          ),
          _buildSwitchTile(
            'إشعارات الرصيد',
            'تنبيه عند تغير الرصيد',
            _balanceNotifications,
            (value) => setState(() => _balanceNotifications = value),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.download, color: Colors.blue),
            ),
            title: const Text('تصدير كشف الحساب'),
            subtitle: const Text('تصدير المعاملات إلى PDF أو Excel'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.history, color: Colors.orange),
            ),
            title: const Text('سجل المعاملات'),
            subtitle: const Text('عرض جميع معاملات المحفظة'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline, color: Colors.red),
            ),
            title: const Text('حذف سجل المعاملات'),
            subtitle: const Text('حذف جميع سجلات المعاملات القديمة'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
