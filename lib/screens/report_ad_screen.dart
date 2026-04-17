import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ReportAdScreen extends StatefulWidget {
  final String adId;
  const ReportAdScreen({super.key, required this.adId});

  @override
  State<ReportAdScreen> createState() => _ReportAdScreenState();
}

class _ReportAdScreenState extends State<ReportAdScreen> {
  final _reasonController = TextEditingController();
  String _selectedReason = 'احتيال';
  bool _isSubmitting = false;

  final List<String> _reasons = [
    'احتيال',
    'منتج مزيف',
    'مخالف للقوانين',
    'إعلان مكرر',
    'معلومات خاطئة',
    'أخرى',
  ];

  Future<void> _submitReport() async {
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isSubmitting = false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال التبليغ بنجاح'), backgroundColor: Colors.green),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تبليغ عن إعلان'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('سبب التبليغ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._reasons.map((reason) => RadioListTile(
              title: Text(reason),
              value: reason,
              groupValue: _selectedReason,
              onChanged: (value) => setState(() => _selectedReason = value.toString()),
              activeColor: AppTheme.goldPrimary,
            )),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'تفاصيل إضافية (اختياري)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                    : const Text('إرسال التبليغ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
