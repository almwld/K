import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({super.key});
  @override
  State<CreateAdScreen> createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  String _category = 'إلكترونيات';
  String _city = 'صنعاء';
  bool _negotiable = false;
  bool _featured = false;

  final _categories = ['إلكترونيات', 'سيارات', 'عقارات', 'أزياء', 'أثاث'];
  final _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('إعلان جديد', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11), actions: [TextButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الإعلان!'), backgroundColor: Color(0xFF0ECB81))); }, child: const Text('نشر', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _buildImagePicker(),
        const SizedBox(height: 16),
        _buildTextField(_titleController, 'عنوان الإعلان'),
        const SizedBox(height: 16),
        _buildTextField(_descController, 'وصف الإعلان', maxLines: 4),
        const SizedBox(height: 16),
        _buildDropdown('الفئة', _category, _categories, (v) => setState(() => _category = v!)),
        const SizedBox(height: 16),
        _buildDropdown('المدينة', _city, _cities, (v) => setState(() => _city = v!)),
        const SizedBox(height: 16),
        Row(children: [Expanded(child: _buildTextField(_priceController, 'السعر بالريال', keyboardType: TextInputType.number)), const SizedBox(width: 12), Column(children: [const Text('قابل للتفاوض', style: TextStyle(color: Colors.white, fontSize: 12)), Switch(value: _negotiable, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _negotiable = v))])]),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('إعلان مميز (+50% ظهور)', style: TextStyle(color: Colors.white)), subtitle: const Text('500 ريال', style: TextStyle(color: Color(0xFFD4AF37))), value: _featured, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _featured = v)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم نشر الإعلان!'), backgroundColor: Color(0xFF0ECB81))); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('نشر الإعلان', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  Widget _buildImagePicker() => GestureDetector(onTap: () {}, child: Container(height: 150, decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139), style: BorderStyle.solid)), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate, color: Color(0xFFD4AF37), size: 40), SizedBox(height: 8), Text('أضف صورة', style: TextStyle(color: Color(0xFF9CA3AF)))])));
  Widget _buildTextField(TextEditingController c, String label, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) => TextField(controller: c, maxLines: maxLines, keyboardType: keyboardType, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)));
  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: value, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(), onChanged: onChanged));
  @override
  void dispose() { _titleController.dispose(); _descController.dispose(); _priceController.dispose(); super.dispose(); }
}
