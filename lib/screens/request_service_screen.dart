import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RequestServiceScreen extends StatefulWidget {
  const RequestServiceScreen({super.key});
  @override
  State<RequestServiceScreen> createState() => _RequestServiceScreenState();
}

class _RequestServiceScreenState extends State<RequestServiceScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _serviceType = 'صيانة';
  String _urgency = 'عادي';
  final _services = ['صيانة', 'تنظيف', 'سباكة', 'كهرباء', 'دهان', 'نجارة', 'تكييف', 'نقل'];
  final _urgencies = ['عاجل', 'عادي', 'خلال أسبوع'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('طلب خدمة', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال طلب الخدمة!'), backgroundColor: Color(0xFF0ECB81)));
            },
            child: const Text('إرسال', style: TextStyle(color: Color(0xFFFF9800), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(controller: _titleController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'عنوان الطلب', labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: _serviceType, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'نوع الخدمة', labelStyle: TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) => setState(() => _serviceType = v!))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: _urgency, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'درجة الاستعجال', labelStyle: TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: _urgencies.map((u) => DropdownMenuItem(value: u, child: Text(u, style: TextStyle(color: u == 'عاجل' ? const Color(0xFFF6465D) : Colors.white)))).toList(), onChanged: (v) => setState(() => _urgency = v!))),
        const SizedBox(height: 16),
        TextField(controller: _descController, maxLines: 4, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'وصف الخدمة المطلوبة', labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال الطلب!'), backgroundColor: Color(0xFF0ECB81))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF9800), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('إرسال الطلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  @override
  void dispose() { _titleController.dispose(); _descController.dispose(); super.dispose(); }
}
