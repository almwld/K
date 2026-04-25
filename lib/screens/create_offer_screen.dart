import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateOfferScreen extends StatefulWidget {
  const CreateOfferScreen({super.key});
  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  double _discount = 30;
  String _type = 'أسبوع';
  bool _featured = false;
  final _codeController = TextEditingController(text: 'FLEX30');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('عرض خاص', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11), actions: [TextButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر العرض!'), backgroundColor: Color(0xFF0ECB81))); }, child: const Text('نشر', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _buildSection('نوع العرض'),
        ...['24 ساعة', 'أسبوع', 'شهر'].map((t) => RadioListTile(title: Text(t, style: const TextStyle(color: Colors.white)), value: t, groupValue: _type, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _type = v!))),
        const SizedBox(height: 16),
        _buildSection('نسبة الخصم'),
        Row(children: [Text('10%', style: const TextStyle(color: Color(0xFF9CA3AF))), Expanded(child: Slider(value: _discount, min: 10, max: 90, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _discount = v))), Text('90%', style: const TextStyle(color: Color(0xFF9CA3AF)))]),
        Center(child: Text('${_discount.toInt()}%', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 24, fontWeight: FontWeight.bold))),
        const SizedBox(height: 16),
        _buildSection('كود الخصم'),
        TextField(controller: _codeController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('عرض مميز (+100% ظهور)', style: TextStyle(color: Colors.white)), subtitle: const Text('1,000 ريال', style: TextStyle(color: Color(0xFFD4AF37))), value: _featured, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _featured = v)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر العرض!'), backgroundColor: Color(0xFF0ECB81))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('نشر العرض', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  Widget _buildSection(String title) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)));
  @override
  void dispose() { _codeController.dispose(); super.dispose(); }
}
