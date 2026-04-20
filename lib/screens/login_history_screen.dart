import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class LoginHistoryScreen extends StatefulWidget {
  const LoginHistoryScreen({super.key});

  @override
  State<LoginHistoryScreen> createState() => _LoginHistoryScreenState();
}

class _LoginHistoryScreenState extends State<LoginHistoryScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }
  
  void _loadHistory() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _history = [
          {'date': '2026-04-03 14:30', 'ip': '192.168.1.1', 'device': 'iPhone 14 Pro', 'location': 'صنعاء، اليمن', 'status': 'ناجح'},
          {'date': '2026-04-02 09:15', 'ip': '192.168.1.1', 'device': 'MacBook Pro', 'location': 'صنعاء، اليمن', 'status': 'ناجح'},
          {'date': '2026-04-01 22:00', 'ip': '10.0.0.1', 'device': 'Samsung Galaxy S23', 'location': 'عدن، اليمن', 'status': 'ناجح'},
          {'date': '2026-03-31 08:30', 'ip': '192.168.1.1', 'device': 'iPhone 14 Pro', 'location': 'صنعاء، اليمن', 'status': 'فاشل'},
        ];
        _isLoading = false;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سجل تسجيل الدخول'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final record = _history[index];
                final isSuccess = record['status'] == 'ناجح';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(isSuccess ? Icons.check : Icons.close, color: isSuccess ? Colors.green : Colors.red),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(record['date'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('${record['device']} • ${record['location']}', style: const TextStyle(fontSize: 12)),
                            Text('IP: ${record['ip']}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(record['status'], style: TextStyle(color: isSuccess ? Colors.green : Colors.red, fontSize: 10)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

