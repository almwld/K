import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class ConnectedDevicesScreen extends StatefulWidget {
  const ConnectedDevicesScreen({super.key});

  @override
  State<ConnectedDevicesScreen> createState() => _ConnectedDevicesScreenState();
}

class _ConnectedDevicesScreenState extends State<ConnectedDevicesScreen> {
  List<Map<String, dynamic>> _devices = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadDevices();
  }
  
  void _loadDevices() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _devices = [
          {'name': 'iPhone 14 Pro', 'os': 'iOS 17.2', 'location': 'صنعاء، اليمن', 'lastActive': 'الآن', 'current': true},
          {'name': 'MacBook Pro', 'os': 'macOS 14.1', 'location': 'صنعاء، اليمن', 'lastActive': 'قبل ساعة', 'current': false},
          {'name': 'Samsung Galaxy S23', 'os': 'Android 14', 'location': 'عدن، اليمن', 'lastActive': 'أمس', 'current': false},
        ];
        _isLoading = false;
      });
    });
  }
  
  void _removeDevice(int index) {
    setState(() {
      _devices.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تسجيل الخروج من الجهاز'), backgroundColor: Colors.green),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الأجهزة المتصلة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: device['current'] ? Border.all(color: AppTheme.goldPrimary, width: 1.5) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.goldPrimary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(device['name'].contains('iPhone') || device['name'].contains('Samsung') ? Icons.phone_android : Icons.computer, color: AppTheme.goldPrimary),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(device['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('${device['os']} • ${device['location']}', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                          if (device['current'])
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('حالي', style: TextStyle(color: Colors.green, fontSize: 10)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('آخر نشاط: ${device['lastActive']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          if (!device['current'])
                            TextButton(
                              onPressed: () => _removeDevice(index),
                              style: TextButton.styleFrom(foregroundColor: Colors.red),
                              child: const Text('تسجيل الخروج'),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
