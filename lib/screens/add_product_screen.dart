import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _category = 'إلكترونيات';
  bool _inStock = true;
  final _categories = ['إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث', 'مطاعم'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(
        title: const Text('إضافة منتج', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0B0E11),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة المنتج بنجاح!'), backgroundColor: Color(0xFF0ECB81)));
            },
            child: const Text('حفظ', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        GestureDetector(onTap: () {}, child: Container(height: 150, decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139))), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate, color: Color(0xFF4CAF50), size: 40), SizedBox(height: 8), Text('أضف صور المنتج', style: TextStyle(color: Color(0xFF9CA3AF)))]))),
        const SizedBox(height: 16),
        TextField(controller: _nameController, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'اسم المنتج', labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: _category, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: 'الفئة', labelStyle: TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) => setState(() => _category = v!))),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: TextField(controller: _priceController, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'السعر', labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)))), const SizedBox(width: 12), Expanded(child: TextField(controller: _stockController, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'الكمية', labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))))]),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('متوفر في المخزون', style: TextStyle(color: Colors.white)), value: _inStock, activeColor: const Color(0xFF4CAF50), onChanged: (v) => setState(() => _inStock = v)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إضافة المنتج!'), backgroundColor: Color(0xFF0ECB81))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('حفظ المنتج', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  @override
  void dispose() { _nameController.dispose(); _priceController.dispose(); _stockController.dispose(); super.dispose(); }
}
