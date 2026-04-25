import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({super.key});
  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _category = 'إلكترونيات';
  String _city = 'صنعاء';
  bool _agreeTerms = false;
  final _categories = ['إلكترونيات', 'أزياء', 'مطاعم', 'عقارات', 'خدمات'];
  final _cities = ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E11),
      appBar: AppBar(title: const Text('متجر جديد', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF0B0E11), actions: [TextButton(onPressed: _agreeTerms ? () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء المتجر!'), backgroundColor: Color(0xFF0ECB81))); } : null, child: const Text('إنشاء', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _buildLogoPicker(),
        const SizedBox(height: 16),
        _buildTextField(_nameController, 'اسم المتجر'),
        const SizedBox(height: 16),
        _buildTextField(_descController, 'وصف المتجر', maxLines: 3),
        const SizedBox(height: 16),
        _buildDropdown('الفئة', _category, _categories, (v) => setState(() => _category = v!)),
        const SizedBox(height: 16),
        _buildDropdown('المدينة', _city, _cities, (v) => setState(() => _city = v!)),
        const SizedBox(height: 16),
        _buildTextField(_addressController, 'العنوان التفصيلي'),
        const SizedBox(height: 16),
        _buildTextField(_phoneController, 'رقم الهاتف'),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('أوافق على شروط وأحكام المتجر', style: TextStyle(color: Colors.white)), value: _agreeTerms, activeColor: const Color(0xFFD4AF37), onChanged: (v) => setState(() => _agreeTerms = v)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: _agreeTerms ? () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إنشاء المتجر!'), backgroundColor: Color(0xFF0ECB81))); } : null, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('إنشاء المتجر', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
      ]),
    );
  }

  Widget _buildLogoPicker() => GestureDetector(onTap: () {}, child: Container(height: 120, width: 120, decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2B3139))), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.store, color: Color(0xFFD4AF37), size: 40), SizedBox(height: 8), Text('أضف شعار', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12))])));
  Widget _buildTextField(TextEditingController c, String label, {int maxLines = 1}) => TextField(controller: c, maxLines: maxLines, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), filled: true, fillColor: const Color(0xFF1E2329), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)));
  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: DropdownButtonFormField<String>(value: value, dropdownColor: const Color(0xFF1E2329), style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Color(0xFF9CA3AF)), border: InputBorder.none), items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(), onChanged: onChanged));
  @override
  void dispose() { _nameController.dispose(); _descController.dispose(); _addressController.dispose(); _phoneController.dispose(); super.dispose(); }
}
