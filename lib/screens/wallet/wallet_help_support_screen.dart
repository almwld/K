import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WalletHelpSupportScreen extends StatefulWidget {
  const WalletHelpSupportScreen({super.key});

  @override
  State<WalletHelpSupportScreen> createState() => _WalletHelpSupportScreenState();
}

class _WalletHelpSupportScreenState extends State<WalletHelpSupportScreen> {
  String _searchQuery = '';
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _faqCategories = [
    {'id': 0, 'name': 'الكل', 'icon': Icons.list},
    {'id': 1, 'name': 'الحساب', 'icon': Icons.person},
    {'id': 2, 'name': 'التحويلات', 'icon': Icons.swap_horiz},
    {'id': 3, 'name': 'الأمان', 'icon': Icons.security},
    {'id': 4, 'name': 'الرسوم', 'icon': Icons.percent},
  ];

  final List<Map<String, dynamic>> _faqs = [
    {'id': 1, 'question': 'كيف يمكنني إيداع الأموال في محفظتي؟', 'answer': 'يمكنك إيداع الأموال من خلال عدة طرق: التحويل البنكي، المحافظ الإلكترونية، بطاقات الهدايا، أو الإيداع النقدي عبر فروع فلكس يمن.', 'category': 1},
    {'id': 2, 'question': 'ما هي رسوم التحويل بين المحافظ؟', 'answer': 'رسوم التحويل تختلف حسب المحفظة: فلكس باي (0 ريال)، جيب (100 ريال)، واصل (250 ريال)، باقي المحافظ (200 ريال).', 'category': 3},
    {'id': 3, 'question': 'كم تستغرق عملية التحويل؟', 'answer': 'التحويلات بين محافظ فلكس باي فورية، التحويلات إلى المحافظ الأخرى تستغرق من فوري إلى 24 ساعة حسب المحفظة.', 'category': 2},
    {'id': 4, 'question': 'كيف يمكنني تفعيل المصادقة البيومترية؟', 'answer': 'اذهب إلى الإعدادات > الأمان > المصادقة البيومترية، ثم قم بتفعيل الخيار واتبع التعليمات لتسجيل بصمتك.', 'category': 3},
    {'id': 5, 'question': 'ماذا أفعل إذا لم تصل الحوالة؟', 'answer': 'إذا لم تصل الحوالة بعد 24 ساعة، يرجى التواصل مع خدمة العملاء على الرقم 712345678 أو عبر تطبيق الدعم.', 'category': 2},
    {'id': 6, 'question': 'كيف يمكنني استرداد الأموال إذا أرسلتها بالخطأ؟', 'answer': 'يمكنك إلغاء الحوالة إذا كانت لا تزال معلقة من قسم "إلغاء حوالة". إذا كانت مكتملة، يرجى التواصل مع خدمة العملاء.', 'category': 2},
    {'id': 7, 'question': 'ما هو الحد الأقصى للتحويل اليومي؟', 'answer': 'الحد الأقصى للتحويل اليومي هو 100,000 ريال يمني، والحد الشهري 500,000 ريال يمني.', 'category': 3},
    {'id': 8, 'question': 'كيف يمكنني تغيير الرقم السري للمحفظة؟', 'answer': 'اذهب إلى الإعدادات > الأمان > تغيير PIN code، ثم أدخل الرقم الحالي والجديد.', 'category': 1},
    {'id': 9, 'question': 'هل توجد رسوم على الإيداع؟', 'answer': 'الإيداع مجاني بالكامل ولا توجد أي رسوم إضافية على عمليات الإيداع.', 'category': 3},
    {'id': 10, 'question': 'كيف يمكنني الاتصال بخدمة العملاء؟', 'answer': 'يمكنك الاتصال على الرقم 712345678 أو إرسال واتساب على نفس الرقم أو عبر البريد الإلكتروني support@flexyemen.com', 'category': 4},
  ];

  List<Map<String, dynamic>> get _filteredFaqs {
    var faqs = _faqs;
    if (_selectedIndex != 0) {
      faqs = faqs.where((f) => f['category'] == _selectedIndex).toList();
    }
    if (_searchQuery.isNotEmpty) {
      faqs = faqs.where((f) => f['question'].contains(_searchQuery) || f['answer'].contains(_searchQuery)).toList();
    }
    return faqs;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredFaqs;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'المساعدة والدعم'),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategories(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.help_outline, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد نتائج', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => _buildFaqCard(filtered[index]),
                  ),
          ),
          _buildContactSection(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'ابحث عن سؤال...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchQuery = ''))
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _faqCategories.length,
        itemBuilder: (context, index) {
          final category = _faqCategories[index];
          final isSelected = _selectedIndex == category['id'];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FilterChip(
              label: Text(category['name']),
              selected: isSelected,
              onSelected: (selected) => setState(() => _selectedIndex = selected ? category['id'] : 0),
              selectedColor: AppTheme.goldAccent,
              labelStyle: TextStyle(color: isSelected ? Colors.white : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFaqCard(Map<String, dynamic> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppTheme.getCardColor(context),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            faq['question'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                faq['answer'],
                style: TextStyle(color: AppTheme.getSecondaryTextColor(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldAccent, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'لا تزال بحاجة للمساعدة؟',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildContactButton(
                  icon: Icons.phone,
                  label: 'اتصال',
                  color: Colors.white,
                  onTap: () => launchUrl(Uri.parse('tel:712345678')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactButton(
                  icon: Icons.chat,
                  label: 'واتساب',
                  color: Colors.green,
                  onTap: () => launchUrl(Uri.parse('https://wa.me/967712345678')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContactButton(
                  icon: Icons.email,
                  label: 'بريد',
                  color: Colors.white,
                  onTap: () => launchUrl(Uri.parse('mailto:support@flexyemen.com')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
