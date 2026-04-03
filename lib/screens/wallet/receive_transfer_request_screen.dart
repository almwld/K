import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../widgets/custom_button.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isSubmitting = false;
  String _generatedCode = '';
  
  final String _userPhone = '777123456';
  final String _userName = 'أحمد محمد';
  
  void _generateRequest() {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال المبلغ'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() {
      _generatedCode = 'TRF${DateTime.now().millisecondsSinceEpoch}';
    });
  }
  
  void _shareRequest() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم نسخ رابط الطلب'), backgroundColor: AppTheme.goldColor),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'استلام حوالة'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // معلومات المستخدم
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.getCardColor(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                    child: const Icon(Icons.person, color: AppTheme.goldColor, size: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(_userPhone, style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // المبلغ
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'المبلغ',
                border: OutlineInputBorder(),
                suffixText: 'ر.ي',
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 12),
            
            // ملاحظة
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'السبب (اختياري)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
            ),
            const SizedBox(height: 24),
            
            // زر إنشاء طلب
            CustomButton(
              text: 'إنشاء طلب استلام',
              onPressed: _generateRequest,
              icon: Icons.qr_code,
            ),
            
            if (_generatedCode.isNotEmpty) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Text('رمز الطلب', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    QrImageView(
                      data: _generatedCode,
                      version: QrVersions.auto,
                      size: 150,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    SelectableText(
                      _generatedCode,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.goldColor),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _shareRequest,
                            icon: const Icon(Icons.share),
                            label: const Text('مشاركة'),
                            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor, foregroundColor: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.copy),
                            label: const Text('نسخ'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.goldColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppTheme.goldColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'شارك هذا الرمز مع المرسل ليتمكن من تحويل المبلغ إليك',
                        style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
