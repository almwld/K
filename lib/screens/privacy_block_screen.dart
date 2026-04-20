import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class PrivacyBlockScreen extends StatefulWidget {
  const PrivacyBlockScreen({super.key});

  @override
  State<PrivacyBlockScreen> createState() => _PrivacyBlockScreenState();
}

class _PrivacyBlockScreenState extends State<PrivacyBlockScreen> {
  List<Map<String, dynamic>> _blockedUsers = [];
  List<Map<String, dynamic>> _reportedIssues = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  void _loadData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _blockedUsers = [
          {'id': '1', 'name': 'مستخدم مزعج', 'reason': 'رسائل مزعجة', 'date': '2026-04-01'},
          {'id': '2', 'name': 'حساب وهمي', 'reason': 'منتجات مزيفة', 'date': '2026-03-28'},
        ];
        _reportedIssues = [
          {'id': '1', 'type': 'منتج', 'target': 'آيفون مزيف', 'reason': 'منتج غير أصلي', 'status': 'قيد المراجعة', 'date': '2026-04-01'},
          {'id': '2', 'type': 'مستخدم', 'target': 'أحمد محمد', 'reason': 'مضايقة', 'status': 'تمت المعالجة', 'date': '2026-03-30'},
        ];
        _isLoading = false;
      });
    });
  }
  
  void _unblockUser(int index) {
    setState(() {
      _blockedUsers.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إلغاء حظر المستخدم'), backgroundColor: Colors.green),
    );
  }
  
  void _blockUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حظر مستخدم'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'اسم المستخدم أو البريد'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'سبب الحظر'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم حظر المستخدم'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حظر'),
          ),
        ],
      ),
    );
  }
  
  void _reportUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('الإبلاغ عن مستخدم'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'اسم المستخدم'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'نوع الإبلاغ'),
              items: const [
                DropdownMenuItem(value: 'مضايقة', child: Text('مضايقة')),
                DropdownMenuItem(value: 'احتيال', child: Text('احتيال')),
                DropdownMenuItem(value: 'منتجات مزيفة', child: Text('منتجات مزيفة')),
                DropdownMenuItem(value: 'لغة غير لائقة', child: Text('لغة غير لائقة')),
              ],
              onChanged: (v) {},
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'تفاصيل إضافية'),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال البلاغ بنجاح'), backgroundColor: Colors.green),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold),
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'الحظر والإبلاغ'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      indicatorColor: AppTheme.gold,
                      labelColor: AppTheme.gold,
                      unselectedLabelColor: Theme.of(context).textTheme.bodyMedium!.color,
                      tabs: const [
                        Tab(text: 'المستخدمون المحظورون', icon: Icon(Icons.block)),
                        Tab(text: 'بلاغاتي', icon: Icon(Icons.report)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // المستخدمون المحظورون
                        _blockedUsers.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.block, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                                    const SizedBox(height: 16),
                                    const Text('لا توجد مستخدمين محظورين', style: TextStyle(fontSize: 18)),
                                    const SizedBox(height: 8),
                                    Text('يمكنك حظر المستخدمين المزعجين', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      onPressed: _blockUser,
                                      icon: const Icon(Icons.block),
                                      label: const Text('حظر مستخدم'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _blockedUsers.length,
                                itemBuilder: (context, index) {
                                  final user = _blockedUsers[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: AppTheme.gold.withOpacity(0.2),
                                          child: Text(user['name'][0], style: const TextStyle(color: AppTheme.gold)),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(user['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                              Text('السبب: ${user['reason']}', style: const TextStyle(fontSize: 12)),
                                              Text('تاريخ: ${user['date']}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                            ],
                                          ),
                                        ),
                                        TextButton.icon(
                                          onPressed: () => _unblockUser(index),
                                          icon: const Icon(Icons.check_circle, size: 16),
                                          label: const Text('إلغاء الحظر'),
                                          style: TextButton.styleFrom(foregroundColor: Colors.green),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                        
                        // البلاغات
                        _reportedIssues.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.report_off, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                                    const SizedBox(height: 16),
                                    const Text('لا توجد بلاغات سابقة', style: TextStyle(fontSize: 18)),
                                    const SizedBox(height: 8),
                                    Text('يمكنك الإبلاغ عن المستخدمين أو المنتجات المخالفة', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      onPressed: _reportUser,
                                      icon: const Icon(Icons.report),
                                      label: const Text('إبلاغ عن مستخدم'),
                                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: _reportedIssues.length,
                                itemBuilder: (context, index) {
                                  final report = _reportedIssues[index];
                                  final isCompleted = report['status'] == 'تمت المعالجة';
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: isCompleted ? null : Border.all(color: AppTheme.gold.withOpacity(0.3)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: report['type'] == 'منتج' ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(report['type'], style: TextStyle(color: report['type'] == 'منتج' ? Colors.blue : Colors.orange)),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(report['status'], style: TextStyle(color: isCompleted ? Colors.green : Colors.orange)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(report['target'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text('السبب: ${report['reason']}', style: const TextStyle(fontSize: 12)),
                                        Text('تاريخ: ${report['date']}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: _blockedUsers.isEmpty && _reportedIssues.isEmpty
          ? FloatingActionButton(
              onPressed: _blockUser,
              backgroundColor: AppTheme.gold,
              child: const Icon(Icons.block, color: Colors.black),
            )
          : null,
    );
  }
}

