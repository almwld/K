import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class PayBundlesScreen extends StatefulWidget {
  const PayBundlesScreen({super.key});

  @override
  State<PayBundlesScreen> createState() => _PayBundlesScreenState();
}

class _PayBundlesScreenState extends State<PayBundlesScreen> {
  String _selectedOperator = 'ymobile';
  String _selectedBundle = '';
  final TextEditingController _phoneController = TextEditingController();

  final List<Map<String, dynamic>> _operators = [
    {'id': 'ymobile', 'name': 'يمن موبايل', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'id': 'you', 'name': 'YOU', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'id': 'sabafon', 'name': 'سبأفون', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
    {'id': 'way', 'name': 'واي', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF9C27B0},
    {'id': 'yemenet', 'name': 'يمن نت', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF1B5E20},
    {'id': 'modem4g', 'name': 'مودم 4G', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF795548},
  ];

  final Map<String, List<Map<String, dynamic>>> _bundles = {
    'ymobile': [
      {'name': 'باقة يومية', 'data': '1GB', 'price': '500', 'validity': '24 ساعة', 'type': 'إنترنت'},
      {'name': 'باقة أسبوعية', 'data': '5GB', 'price': '2,000', 'validity': '7 أيام', 'type': 'إنترنت'},
      {'name': 'باقة شهرية', 'data': '20GB', 'price': '7,000', 'validity': '30 يوم', 'type': 'إنترنت'},
      {'name': 'باقة تواصل', 'data': '10GB', 'price': '5,000', 'validity': '30 يوم', 'type': 'اجتماعي'},
    ],
    'you': [
      {'name': 'باقة يومية', 'data': '2GB', 'price': '600', 'validity': '24 ساعة', 'type': 'إنترنت'},
      {'name': 'باقة أسبوعية', 'data': '7GB', 'price': '2,500', 'validity': '7 أيام', 'type': 'إنترنت'},
      {'name': 'باقة شهرية', 'data': '30GB', 'price': '8,000', 'validity': '30 يوم', 'type': 'إنترنت'},
      {'name': 'باقة وسائل تواصل', 'data': '15GB', 'price': '6,000', 'validity': '30 يوم', 'type': 'اجتماعي'},
    ],
    'sabafon': [
      {'name': 'باقة يومية', 'data': '1.5GB', 'price': '550', 'validity': '24 ساعة', 'type': 'إنترنت'},
      {'name': 'باقة أسبوعية', 'data': '6GB', 'price': '2,200', 'validity': '7 أيام', 'type': 'إنترنت'},
      {'name': 'باقة شهرية', 'data': '25GB', 'price': '7,500', 'validity': '30 يوم', 'type': 'إنترنت'},
    ],
    'way': [
      {'name': 'باقة يومية', 'data': '2GB', 'price': '650', 'validity': '24 ساعة', 'type': 'إنترنت'},
      {'name': 'باقة أسبوعية', 'data': '8GB', 'price': '2,800', 'validity': '7 أيام', 'type': 'إنترنت'},
      {'name': 'باقة شهرية', 'data': '35GB', 'price': '9,000', 'validity': '30 يوم', 'type': 'إنترنت'},
    ],
    'yemenet': [
      {'name': 'باقة شهرية', 'data': '50GB', 'price': '12,000', 'validity': '30 يوم', 'type': 'منزلي'},
      {'name': 'باقة شهرية', 'data': '100GB', 'price': '20,000', 'validity': '30 يوم', 'type': 'منزلي'},
      {'name': 'باقة شهرية', 'data': '200GB', 'price': '35,000', 'validity': '30 يوم', 'type': 'منزلي'},
      {'name': 'باقة شهرية', 'data': 'غير محدود', 'price': '50,000', 'validity': '30 يوم', 'type': 'منزلي'},
      {'name': 'باقة أسبوعية', 'data': '20GB', 'price': '5,000', 'validity': '7 أيام', 'type': 'منزلي'},
    ],
    'modem4g': [
      {'name': 'باقة يومية', 'data': '3GB', 'price': '800', 'validity': '24 ساعة', 'type': 'مودم'},
      {'name': 'باقة أسبوعية', 'data': '15GB', 'price': '3,500', 'validity': '7 أيام', 'type': 'مودم'},
      {'name': 'باقة شهرية', 'data': '60GB', 'price': '10,000', 'validity': '30 يوم', 'type': 'مودم'},
      {'name': 'باقة شهرية', 'data': '150GB', 'price': '18,000', 'validity': '30 يوم', 'type': 'مودم'},
      {'name': 'باقة شهرية', 'data': '300GB', 'price': '30,000', 'validity': '30 يوم', 'type': 'مودم'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bundles = _bundles[_selectedOperator] ?? [];
    final selectedBundle = bundles.firstWhere((b) => b['name'] == _selectedBundle, orElse: () => {});

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'باقات الإنترنت'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOperatorsGrid(),
            const SizedBox(height: 24),
            if (bundles.isNotEmpty) _buildBundlesList(bundles),
            const SizedBox(height: 16),
            if (_selectedBundle.isNotEmpty) _buildPhoneInput(),
            const SizedBox(height: 24),
            if (_selectedBundle.isNotEmpty) _buildPaymentButton(selectedBundle),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر مزود الخدمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: _operators.length,
          itemBuilder: (context, index) {
            final operator = _operators[index];
            final isSelected = _selectedOperator == operator['id'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedOperator = operator['id'];
                  _selectedBundle = '';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldLight.withOpacity(0.1) : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldLight : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(30), child: CachedNetworkImage(imageUrl: operator['image'], width: 50, height: 50, fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(_getOperatorIcon(operator['id']), color: Color(operator['color']), size: 40))),
                    const SizedBox(height: 8),
                    Text(operator['name'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getOperatorIcon(String id) {
    switch (id) {
      case 'ymobile': return Icons.phone_android;
      case 'you': return Icons.phone_android;
      case 'sabafon': return Icons.phone_android;
      case 'way': return Icons.phone_android;
      case 'yemenet': return Icons.wifi;
      case 'modem4g': return Icons.settings_input_antenna;
      default: return Icons.sim_card;
    }
  }

  Widget _buildBundlesList(List<Map<String, dynamic>> bundles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('اختر الباقة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: bundles.length,
          itemBuilder: (context, index) {
            final bundle = bundles[index];
            final isSelected = _selectedBundle == bundle['name'];
            return GestureDetector(
              onTap: () => setState(() => _selectedBundle = bundle['name']),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.goldLight.withOpacity(0.1) : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppTheme.goldLight : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bundle['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Row(children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Color(_operators.firstWhere((o) => o['id'] == _selectedOperator)['color']).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text(bundle['type'], style: TextStyle(fontSize: 10, color: Color(_operators.firstWhere((o) => o['id'] == _selectedOperator)['color'])))),
                            const SizedBox(width: 8),
                            Text('${bundle['data']}', style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 8),
                            Text('${bundle['validity']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          ]),
                        ],
                      ),
                    ),
                    Text('${bundle['price']} ر.ي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.goldLight)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    final operator = _operators.firstWhere((o) => o['id'] == _selectedOperator);
    final isModem = _selectedOperator == 'modem4g' || _selectedOperator == 'yemenet';
    
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: isModem ? 'رقم المودم / رقم الاشتراك' : 'رقم الجوال',
        prefixIcon: Icon(isModem ? Icons.settings_input_antenna : Icons.phone),
        hintText: isModem ? 'مثال: 123456789' : 'مثال: 777123456',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPaymentButton(Map<String, dynamic> bundle) {
    final operator = _operators.firstWhere((o) => o['id'] == _selectedOperator);
    final isModem = _selectedOperator == 'modem4g' || _selectedOperator == 'yemenet';
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_phoneController.text.length >= 9) ? () => _processPayment(bundle, operator, isModem) : null,
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: Text('شراء الباقة بقيمة ${bundle['price']} ر.ي', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _processPayment(Map<String, dynamic> bundle, Map<String, dynamic> operator, bool isModem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الشراء'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isModem ? Icons.settings_input_antenna : Icons.wifi, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('شراء باقة ${bundle['name']}'),
            Text('من ${operator['name']}'),
            Text('${bundle['data']} - ${bundle['validity']}'),
            Text('السعر: ${bundle['price']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () { Navigator.pop(context); _showSuccessDialog(bundle, operator); }, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight), child: const Text('تأكيد')),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> bundle, Map<String, dynamic> operator) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الشراء بنجاح'),
        content: Column(mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم شراء باقة ${bundle['name']}'),
            Text('من ${operator['name']}'),
            Text('سيتم تفعيل الباقة خلال 5 دقائق'),
          ],
        ),
        actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text('حسناً'))],
      ),
    );
  }
}

