import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  List<Map<String, dynamic>> _tickets = [];
  bool _showForm = false;
  
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPriority = 'متوسطة';
  
  final List<String> _priorities = ['عالية', 'متوسطة', 'منخفضة'];
  
  @override
  void initState() {
    super.initState();
    _loadTickets();
  }
  
  void _loadTickets() {
    _tickets = [
      {'id': '#TKT001', 'title': 'مشكلة في الدفع', 'status': 'قيد المعالجة', 'date': '2026-04-01', 'priority': 'عالية'},
      {'id': '#TKT002', 'title': 'استفسار عن منتج', 'status': 'تم الرد', 'date': '2026-03-30', 'priority': 'متوسطة'},
    ];
  }
  
  void _createTicket() {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _tickets.insert(0, {
        'id': '#TKT${DateTime.now().millisecondsSinceEpoch}',
        'title': _titleController.text,
        'status': 'جديد',
        'date': DateTime.now().toString().substring(0, 10),
        'priority': _selectedPriority,
      });
      _showForm = false;
      _titleController.clear();
      _descriptionController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إنشاء التذكرة بنجاح'), backgroundColor: Colors.green),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'جديد': return Colors.orange;
      case 'قيد المعالجة': return Colors.blue;
      case 'تم الرد': return Colors.green;
      default: return Colors.grey;
    }
  }
  
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'عالية': return Colors.red;
      case 'متوسطة': return Colors.orange;
      case 'منخفضة': return Colors.green;
      default: return Colors.grey;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'تذاكر الدعم'),
      body: Column(
        children: [
          // زر إنشاء تذكرة جديدة
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _showForm = !_showForm),
              icon: const Icon(Icons.add),
              label: const Text('تذكرة جديدة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.gold,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
          
          // نموذج إنشاء تذكرة
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showForm ? 380 : 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'عنوان التذكرة', border: OutlineInputBorder()),
                        validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: 'تفاصيل المشكلة', border: OutlineInputBorder()),
                        validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedPriority,
                        decoration: const InputDecoration(labelText: 'الأولوية', border: OutlineInputBorder()),
                        items: _priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                        onChanged: (v) => setState(() => _selectedPriority = v!),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(() => _showForm = false),
                              child: const Text('إلغاء'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _createTicket,
                              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
                              child: const Text('إرسال'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // قائمة التذاكر
          Expanded(
            child: _tickets.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.confirmation_number, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('لا توجد تذاكر', style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text('اضغط على "تذكرة جديدة" لإنشاء تذكرة', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = _tickets[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ticket['id'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(ticket['priority']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(ticket['priority'], style: TextStyle(color: _getPriorityColor(ticket['priority']), fontSize: 10)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(ticket['title'], style: const TextStyle(fontSize: 16)),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ticket['date'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(ticket['status']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(ticket['status'], style: TextStyle(color: _getStatusColor(ticket['status']), fontSize: 10)),
                                ),
                              ],
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
