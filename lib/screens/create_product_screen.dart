import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});
  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _oldPriceController = TextEditingController();
  final _stockController = TextEditingController();
  String _category = 'إلكترونيات';
  bool _inStock = true;
  final _categories = ['إلكترونيات', 'أزياء', 'سيارات', 'عقارات', 'أثاث'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('منتج جديد', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11), actions: [TextButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ المنتج!'), backgroundColor: Color(0xFF0ECB81))); }, child: const Text('حفظ', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _buildImageGrid(),
        const SizedBox(height: 16),
        _buildTextField(_nameController, 'اسم المنتج'),
        const SizedBox(height: 16),
        _buildTextField(_descController, 'وصف المنتج', maxLines: 3),
        const SizedBox(height: 16),
        _buildDropdown('الفئة', _category, _categories, (v) => setState(() => _category = v!)),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField(_priceController, 'السعر')), const SizedBox(width: 12), Expanded(child: _buildTextField(_oldPriceController, 'السعر قبل الخصم')), const SizedBox(width: 12), Expanded(child: _buildTextField(_stockController, 'المخزون'))]),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('متوفر في المخزون', style: TextStyle(color: Colors.white)), value: _inStock, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _inStock = v)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ المنتج!'), backgroundColor: Color(0xFF0ECB81))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('حفظ المنتج', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  Widget _buildImageGrid() => Row(children: List.generate(5, (i) => Container(margin: const EdgeInsets.only(right: 8), width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF2B3139))), child: Icon(i == 4 ? Icons.add : Icons.image, color: const Color(0xFFD4AF37), size: 24))));
  Widget _buildTextField(TextEditingController c, String label, {int maxLines = 1}) => TextField(controller: c, maxLines: maxLines, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)));
  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: value, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(), onChanged: onChanged));
  @override
  void dispose() { _nameController.dispose(); _descController.dispose(); _priceController.dispose(); _oldPriceController.dispose(); _stockController.dispose(); super.dispose(); }
}
