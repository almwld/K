import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  List<Map<String, dynamic>> _addresses = [];
  bool _isLoading = true;
  bool _showForm = false;
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }
  
  void _loadAddresses() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _addresses = [
          {'id': '1', 'name': 'المنزل', 'phone': '777123456', 'city': 'صنعاء', 'address': 'شارع حدة، مبنى رقم 10', 'isDefault': true},
          {'id': '2', 'name': 'العمل', 'phone': '777123456', 'city': 'صنعاء', 'address': 'شارع التحرير، برج فلكس', 'isDefault': false},
        ];
        _isLoading = false;
      });
    });
  }
  
  void _addAddress() {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _addresses.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'phone': _phoneController.text,
        'city': _cityController.text,
        'address': _addressController.text,
        'isDefault': _addresses.isEmpty,
      });
      _showForm = false;
      _nameController.clear();
      _phoneController.clear();
      _cityController.clear();
      _addressController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إضافة العنوان بنجاح'), backgroundColor: Colors.green),
    );
  }
  
  void _setDefault(int index) {
    setState(() {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = (i == index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعيين العنوان كافتراضي'), backgroundColor: Colors.green),
    );
  }
  
  void _deleteAddress(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف العنوان'), backgroundColor: Colors.red),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'عناويني'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // زر إضافة عنوان جديد
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _showForm = !_showForm),
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة عنوان جديد'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldPrimary,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
                
                // نموذج إضافة عنوان
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _showForm ? 420 : 0,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.getCardColor(context),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(labelText: 'اسم العنوان (المنزل، العمل)', border: OutlineInputBorder()),
                              validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(labelText: 'رقم الجوال', border: OutlineInputBorder()),
                              validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _cityController.text.isEmpty ? null : _cityController.text,
                              decoration: const InputDecoration(labelText: 'المدينة', border: OutlineInputBorder()),
                              items: ['صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                              onChanged: (v) => setState(() => _cityController.text = v!),
                              validator: (v) => v == null ? 'مطلوب' : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _addressController,
                              maxLines: 2,
                              decoration: const InputDecoration(labelText: 'العنوان التفصيلي', border: OutlineInputBorder()),
                              validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
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
                                    onPressed: _addAddress,
                                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldPrimary, foregroundColor: Colors.black),
                                    child: const Text('حفظ'),
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
                
                // قائمة العناوين
                Expanded(
                  child: _addresses.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_off, size: 80, color: AppTheme.goldPrimary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              const Text('لا توجد عناوين', style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 8),
                              Text('أضف عنواناً جديداً', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _addresses.length,
                          itemBuilder: (context, index) {
                            final address = _addresses[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.getCardColor(context),
                                borderRadius: BorderRadius.circular(16),
                                border: address['isDefault'] ? Border.all(color: AppTheme.goldPrimary, width: 2) : null,
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
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.location_on, color: AppTheme.goldPrimary, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(address['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                                if (address['isDefault'])
                                                  Container(
                                                    margin: const EdgeInsets.only(left: 8),
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: AppTheme.goldPrimary.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: const Text('افتراضي', style: TextStyle(fontSize: 10, color: AppTheme.goldPrimary)),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(address['city'], style: const TextStyle(fontSize: 12)),
                                            Text(address['address'], style: const TextStyle(fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      PopupMenuButton(
                                        itemBuilder: (context) => [
                                          if (!address['isDefault'])
                                            const PopupMenuItem(value: 'default', child: Text('تعيين كافتراضي')),
                                          const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                                        ],
                                        onSelected: (value) {
                                          if (value == 'default') _setDefault(index);
                                          if (value == 'delete') _deleteAddress(index);
                                        },
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
