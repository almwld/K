import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = AppTheme.gold;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعد الذكي'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.smart_toy, color: primaryColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'مرحباً! أنا مساعد Flex الذكي. كيف يمكنني مساعدتك اليوم؟',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'اقتراحات للأسئلة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getPrimaryTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSuggestionChip(context, 'كيف أضيف إعلان؟', primaryColor),
                _buildSuggestionChip(context, 'طرق الدفع المتاحة', primaryColor),
                _buildSuggestionChip(context, 'كيف أتواصل مع البائع؟', primaryColor),
                _buildSuggestionChip(context, 'سياسة الإرجاع', primaryColor),
                _buildSuggestionChip(context, 'خدمة التوصيل', primaryColor),
                _buildSuggestionChip(context, 'المزادات', primaryColor),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'المحادثات الأخيرة',
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.getPrimaryTextColor(context),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  _buildChatItem(context, 'كيف أبيع منتج؟', 'منذ ساعتين', primaryColor),
                  _buildChatItem(context, 'رسوم المنصة', 'أمس', primaryColor),
                  _buildChatItem(context, 'تفعيل المحفظة', 'منذ 3 أيام', primaryColor),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'اكتب سؤالك هنا...',
                      hintStyle: const TextStyle(fontFamily: 'Changa'),
                      filled: true,
                      fillColor: isDark ? AppTheme.nightCard : AppTheme.lightCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.goldGradient,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('سيتم الرد عليك قريباً'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(BuildContext context, String label, Color primaryColor) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('سؤال: $label'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.nightCard
              : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: primaryColor.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Changa',
            fontSize: 13,
            color: AppTheme.getTextColor(context),
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String question, String time, Color primaryColor) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.chat_bubble_outline, color: primaryColor, size: 20),
      ),
      title: Text(
        question,
        style: const TextStyle(
          fontFamily: 'Changa',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          fontFamily: 'Changa',
          fontSize: 12,
          color: Colors.grey[500],
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('جاري فتح المحادثة...')),
        );
      },
    );
  }
}

