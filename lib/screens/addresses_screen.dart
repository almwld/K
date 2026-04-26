import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'title': 'المنزل',
      'address': 'شارع الستين، صنعاء',
      'city': 'صنعاء',
      'phone': '777123456',
      'isDefault': true,
    },
    {
      'id': '2',
      'title': 'العمل',
      'address': 'شارع حدة، صنعاء',
      'city': 'صنعاء',
      'phone': '777234567',
      'isDefault': false,
    },
  ];

  void _setDefault(String id) {
    setState(() {
      for (var address in _addresses) {
        address['isDefault'] = address['id'] == id;
      }
    });
  }

  void _deleteAddress(String id) {
    setState(() {
      _addresses.removeWhere((a) => a['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.binanceDark,
      appBar: AppBar(
        title: const Text('العناوين', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.binanceDark,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _addresses.length,
        itemBuilder: (context, index) => _buildAddressCard(_addresses[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAddressDialog(),
        backgroundColor: AppTheme.binanceGold,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.binanceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: address['isDefault'] ? AppTheme.binanceGold : AppTheme.binanceBorder,
          width: address['isDefault'] ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: address['isDefault'] ? AppTheme.binanceGold.withOpacity(0.2) : AppTheme.binanceCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  address['title'],
                  style: TextStyle(
                    color: address['isDefault'] ? AppTheme.binanceGold : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              if (!address['isDefault'])
                TextButton(
                  onPressed: () => _setDefault(address['id']),
                  child: const Text('تعيين افتراضي', style: TextStyle(color: AppTheme.binanceGold)),
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _deleteAddress(address['id']),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 8),
              Expanded(child: Text(address['address'], style: const TextStyle(color: Colors.white))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone, size: 16, color: Color(0xFF9CA3AF)),
              const SizedBox(width: 8),
              Text(address['phone'], style: const TextStyle(color: Color(0xFF9CA3AF))),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog() {
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.binanceCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('إضافة عنوان جديد', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'الاسم (المنزل - العمل)',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'العنوان',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cityController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'المدينة',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'رقم الهاتف',
                hintStyle: TextStyle(color: Color(0xFF5E6673)),
                filled: true,
                fillColor: Color(0xFF0B0E11),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _addresses.add({
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'title': titleController.text,
                  'address': addressController.text,
                  'city': cityController.text,
                  'phone': phoneController.text,
                  'isDefault': false,
                });
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.binanceGold),
            child: const Text('إضافة', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
