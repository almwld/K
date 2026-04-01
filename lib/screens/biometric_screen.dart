import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  bool enabled = false;
  String method = 'Touch ID / Face ID';

  void _toggle() {
    setState(() => enabled = !enabled);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(enabled ? 'تم تفعيل البيومتريك' : 'تم تعطيل البيومتريك')));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المصادقة البيومترية'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('الاستخدام البيومتري'),
              subtitle: Text(enabled ? 'مفعل' : 'غير مفعل'),
              trailing: Switch(value: enabled, onChanged: (_) => _toggle(), activeColor: AppTheme.goldColor),
            ),
            const SizedBox(height: 12),
            if (enabled)
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(method),
                subtitle: const Text('استخدم إعدادات النظام لإدارة طرق البيومتريك'),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('اختبار المصادقة'))),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
              child: const Text('اختبار'),
            ),
          ],
        ),
      ),
    );
  }
}
