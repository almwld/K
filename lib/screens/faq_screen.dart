import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'الكل';
  
  final List<String> _categories = ['الكل', 'الحساب', 'الدفع', 'الشحن', 'المزادات', 'المحفظة'];
  
  final List<Map<String, dynamic>> _faqs = [
    // الحساب
    {'question': 'كيف يمكنني إنشاء حساب جديد؟', 'answer': 'يمكنك إنشاء حساب جديد بالضغط على "إنشاء حساب" في شاشة تسجيل الدخول، ثم إدخال بياناتك الشخصية.', 'category': 'الحساب'},
    {'question': 'ماذا أفعل إذا نسيت كلمة المرور؟', 'answer': 'يمكنك إعادة تعيين كلمة المرور بالضغط على "نسيت كلمة المرور" في شاشة تسجيل الدخول.', 'category': 'الحساب'},
    {'question': 'كيف يمكنني تغيير بياناتي الشخصية؟', 'answer': 'اذهب إلى صفحة حسابي > الإعدادات > معلومات الحساب لتعديل بياناتك.', 'category': 'الحساب'},
    
    // الدفع
    {'question': 'ما هي طرق الدفع المتاحة؟', 'answer': 'نقبل الدفع عند الاستلام، التحويل البنكي، والمحفظة الإلكترونية.', 'category': 'الدفع'},
    {'question': 'هل الدفع عبر المحفظة آمن؟', 'answer': 'نعم، جميع معاملات المحفظة مشفرة ومحمية بأعلى معايير الأمان.', 'category': 'الدفع'},
    {'question': 'كم تستغرق عملية الدفع؟', 'answer': 'تتم معالجة الدفع فوراً في حالة المحفظة، وخلال 24 ساعة للتحويل البنكي.', 'category': 'الدفع'},
    
    // الشحن
    {'question': 'كم تستغرق عملية التوصيل؟', 'answer': 'يختلف وقت التوصيل حسب المدينة والشركة، من 1 إلى 7 أيام.', 'category': 'الشحن'},
    {'question': 'ما هي تكلفة الشحن؟', 'answer': 'تكلفة الشحن تختلف حسب شركة الشحن والمسافة، تبدأ من 500 ريال.', 'category': 'الشحن'},
    {'question': 'كيف يمكنني تتبع طلبي؟', 'answer': 'يمكنك تتبع طلبك من خلال صفحة "طلباتي" ثم الضغط على "تتبع الطلب".', 'category': 'الشحن'},
    
    // المزادات
    {'question': 'كيف أشارك في المزاد؟', 'answer': 'اختر المنتج المطلوب ثم اضغط على "مزايدة" وأدخل سعرك.', 'category': 'المزادات'},
    {'question': 'ماذا يحدث إذا فزت بالمزاد؟', 'answer': 'سيتم إشعارك وسيتوجب عليك دفع المبلغ خلال 24 ساعة.', 'category': 'المزادات'},
    {'question': 'هل توجد رسوم على المزادات؟', 'answer': 'نعم، رسوم المزاد 5% من قيمة المنتج النهائية.', 'category': 'المزادات'},
    
    // المحفظة
    {'question': 'كيف أشحن رصيد المحفظة؟', 'answer': 'اذهب إلى المحفظة ثم اختر "إيداع" واختر طريقة الدفع المناسبة.', 'category': 'المحفظة'},
    {'question': 'كم الحد الأدنى للسحب؟', 'answer': 'الحد الأدنى للسحب هو 10,000 ريال.', 'category': 'المحفظة'},
    {'question': 'كم تستغرق عملية السحب؟', 'answer': 'تستغرق عملية السحب من 24 إلى 48 ساعة.', 'category': 'المحفظة'},
  ];
  
  List<Map<String, dynamic>> get _filteredFaqs {
    return _faqs.where((faq) {
      final matchesSearch = _searchQuery.isEmpty || 
          faq['question'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['answer'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'الكل' || faq['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأسئلة الشائعة'),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'ابحث في الأسئلة...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          // فلتر الفئات
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.gold : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? AppTheme.gold : AppTheme.getDividerColor(context)),
                    ),
                    child: Text(category, style: TextStyle(color: isSelected ? Colors.black : AppTheme.getTextColor(context))),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // قائمة الأسئلة
          Expanded(
            child: _filteredFaqs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('لا توجد نتائج', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredFaqs.length,
                    itemBuilder: (context, index) {
                      final faq = _filteredFaqs[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: AppTheme.gold.withOpacity(0.1),
                            child: Text('${index + 1}', style: const TextStyle(color: AppTheme.gold)),
                          ),
                          title: Text(faq['question'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(faq['answer'], style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
