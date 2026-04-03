import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class EntertainmentServicesScreen extends StatefulWidget {
  const EntertainmentServicesScreen({super.key});

  @override
  State<EntertainmentServicesScreen> createState() => _EntertainmentServicesScreenState();
}

class _EntertainmentServicesScreenState extends State<EntertainmentServicesScreen> {
  String _selectedService = 'all';
  
  final List<Map<String, dynamic>> _services = [
    {'id': 'netflix', 'name': 'نتفليكس', 'icon': Icons.movie, 'color': 0xFFE50914, 'plans': [
      {'name': 'أساسي', 'price': '12,000', 'value': '1 شهر'},
      {'name': 'قياسي', 'price': '18,000', 'value': '1 شهر'},
      {'name': 'بريميوم', 'price': '24,000', 'value': '1 شهر'},
    ]},
    {'id': 'shahid', 'name': 'شاهد', 'icon': Icons.play_circle, 'color': 0xFF00A8A8, 'plans': [
      {'name': 'VIP', 'price': '8,000', 'value': '1 شهر'},
      {'name': 'VIP سنوي', 'price': '80,000', 'value': '12 شهر'},
    ]},
    {'id': 'osn', 'name': 'OSN', 'icon': Icons.tv, 'color': 0xFFF26522, 'plans': [
      {'name': 'OSN Basic', 'price': '15,000', 'value': '1 شهر'},
      {'name': 'OSN Plus', 'price': '25,000', 'value': '1 شهر'},
    ]},
    {'id': 'starzplay', 'name': 'Starzplay', 'icon': Icons.star, 'color': 0xFF4B0082, 'plans': [
      {'name': 'شهري', 'price': '10,000', 'value': '1 شهر'},
      {'name': 'سنوي', 'price': '100,000', 'value': '12 شهر'},
    ]},
    {'id': 'spotify', 'name': 'سبوتيفاي', 'icon': Icons.music_note, 'color': 0xFF1DB954, 'plans': [
      {'name': 'فردي', 'price': '9,000', 'value': '1 شهر'},
      {'name': 'عائلي', 'price': '15,000', 'value': '1 شهر'},
    ]},
    {'id': 'anghami', 'name': 'أنغامي', 'icon': Icons.headphones, 'color': 0xFF4A90E2, 'plans': [
      {'name': 'Plus', 'price': '5,000', 'value': '1 شهر'},
      {'name': 'Plus سنوي', 'price': '50,000', 'value': '12 شهر'},
    ]},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'خدمات ترفيهية'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServicesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        return GestureDetector(
          onTap: () {
            _showPlansDialog(service);
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getCardColor(context),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(service['color']).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(service['icon'], color: Color(service['color']), size: 40),
                ),
                const SizedBox(height: 12),
                Text(
                  service['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'اشترك الآن',
                  style: TextStyle(fontSize: 12, color: AppTheme.goldColor),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPlansDialog(Map<String, dynamic> service) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(service['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(service['icon'], color: Color(service['color']), size: 30),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    service['name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'اختر الباقة المناسبة',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...service['plans'].map((plan) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.goldColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plan['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(plan['value'], style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${plan['price']} ر.ي',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _showPurchaseDialog(service['name'], plan);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            minimumSize: const Size(80, 30),
                          ),
                          child: const Text('اشتراك', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  void _showPurchaseDialog(String serviceName, Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('شراء اشتراك $serviceName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.subscriptions, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            Text('الباقة: ${plan['name']}'),
            Text('المدة: ${plan['value']}'),
            Text('السعر: ${plan['price']} ريال'),
            const SizedBox(height: 16),
            const Text('سيتم تفعيل الاشتراك فوراً', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(serviceName, plan);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldColor),
            child: const Text('تأكيد الشراء'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String serviceName, Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم الاشتراك بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تفعيل اشتراك $serviceName'),
            Text('الباقة: ${plan['name']}'),
            Text('المدة: ${plan['value']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
