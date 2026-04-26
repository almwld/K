import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String _selectedCurrency = 'ريال يمني (YER)';
  String _selectedSymbol = 'ر.ي';

  final List<Map<String, String>> _currencies = [
    {'name': 'ريال يمني', 'code': 'YER', 'symbol': 'ر.ي', 'flag': '🇾🇪'},
    {'name': 'دولار أمريكي', 'code': 'USD', 'symbol': '\$', 'flag': '🇺🇸'},
    {'name': 'ريال سعودي', 'code': 'SAR', 'symbol': 'ر.س', 'flag': '🇸🇦'},
    {'name': 'درهم إماراتي', 'code': 'AED', 'symbol': 'د.إ', 'flag': '🇦🇪'},
    {'name': 'دينار كويتي', 'code': 'KWD', 'symbol': 'د.ك', 'flag': '🇰🇼'},
    {'name': 'ريال قطري', 'code': 'QAR', 'symbol': 'ر.ق', 'flag': '🇶🇦'},
    {'name': 'دينار بحريني', 'code': 'BHD', 'symbol': 'د.ب', 'flag': '🇧🇭'},
    {'name': 'ريال عماني', 'code': 'OMR', 'symbol': 'ر.ع', 'flag': '🇴🇲'},
    {'name': 'يورو', 'code': 'EUR', 'symbol': '€', 'flag': '🇪🇺'},
    {'name': 'جنيه إسترليني', 'code': 'GBP', 'symbol': '£', 'flag': '🇬🇧'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
      appBar: AppBar(
        title: const Text('العملة', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: isDark ? AppTheme.binanceDark : AppTheme.lightBackground,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تغيير العملة'), backgroundColor: AppTheme.binanceGreen),
              );
              Navigator.pop(context);
            },
            child: const Text('حفظ', style: TextStyle(color: AppTheme.binanceGold)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _currencies.length,
        itemBuilder: (context, index) {
          final currency = _currencies[index];
          final isSelected = _selectedCurrency.contains(currency['name']!);
          return ListTile(
            leading: Text(currency['flag']!, style: const TextStyle(fontSize: 24)),
            title: Text(currency['name']!, style: TextStyle(color: Colors.white)),
            subtitle: Text('${currency['code']} - ${currency['symbol']}', style: const TextStyle(color: Color(0xFF9CA3AF))),
            trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.binanceGold) : null,
            onTap: () {
              setState(() {
                _selectedCurrency = '${currency['name']} (${currency['code']})';
                _selectedSymbol = currency['symbol']!;
              });
            },
          );
        },
      ),
    );
  }
}
