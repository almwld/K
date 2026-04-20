import 'package:flutter/material.dart';
import '../../providers/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class SavedPaymentMethodsScreen extends StatefulWidget {
  const SavedPaymentMethodsScreen({super.key});

  @override
  State<SavedPaymentMethodsScreen> createState() => _SavedPaymentMethodsScreenState();
}

class _SavedPaymentMethodsScreenState extends State<SavedPaymentMethodsScreen> {
  List<Map<String, dynamic>> _paymentMethods = [];
  bool _isLoading = true;
  bool _showAddForm = false;
  
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderController = TextEditingController();
  String _selectedType = 'card';
  
  @override
  void initState() {
    super.initState();
    _loadPaymentMethods();
  }
  
  void _loadPaymentMethods() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _paymentMethods = [
          {'id': '1', 'type': 'card', 'last4': '4242', 'brand': 'Visa', 'expiry': '12/26', 'isDefault': true},
          {'id': '2', 'type': 'wallet', 'name': 'محفظة فلكس', 'balance': '250,000', 'isDefault': false},
        ];
        _isLoading = false;
      });
    });
  }
  
  void _addPaymentMethod() {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _paymentMethods.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': _selectedType,
        'last4': _cardNumberController.text.substring(_cardNumberController.text.length - 4),
        'brand': _cardNumberController.text.startsWith('4') ? 'Visa' : 'Mastercard',
        'expiry': _expiryController.text,
        'isDefault': _paymentMethods.isEmpty,
      });
      _showAddForm = false;
      _cardNumberController.clear();
      _expiryController.clear();
      _cvvController.clear();
      _cardHolderController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إضافة بطاقة الدفع بنجاح'), backgroundColor: Colors.green),
    );
  }
  
  void _setDefault(int index) {
    setState(() {
      for (var i = 0; i < _paymentMethods.length; i++) {
        _paymentMethods[i]['isDefault'] = (i == index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعيين طريقة الدفع كافتراضية'), backgroundColor: Colors.green),
    );
  }
  
  void _deleteMethod(int index) {
    setState(() {
      _paymentMethods.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف طريقة الدفع'), backgroundColor: Colors.red),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'طرق الدفع المحفوظة'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // زر إضافة طريقة دفع جديدة
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _showAddForm = !_showAddForm),
                    icon: const Icon(Icons.add),
                    label: const Text('إضافة بطاقة جديدة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.gold,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ),
                
                // نموذج إضافة بطاقة
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _showAddForm ? 450 : 0,
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
                            // اختيار نوع الدفع
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTypeOption('card', 'بطاقة ائتمانية', Icons.credit_card),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildTypeOption('wallet', 'محفظة فلكس', Icons.account_balance_wallet),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            if (_selectedType == 'card') ...[
                              TextFormField(
                                controller: _cardNumberController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'رقم البطاقة',
                                  hintText: '1234 5678 9012 3456',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.credit_card),
                                ),
                                validator: (v) => v?.length != 16 ? 'رقم بطاقة غير صالح' : null,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _expiryController,
                                      decoration: const InputDecoration(
                                        labelText: 'تاريخ الانتهاء',
                                        hintText: 'MM/YY',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (v) => v?.length != 5 ? 'صيغة غير صالحة' : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _cvvController,
                                      keyboardType: TextInputType.number,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'CVV',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (v) => v?.length != 3 ? 'غير صالح' : null,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _cardHolderController,
                                decoration: const InputDecoration(
                                  labelText: 'اسم صاحب البطاقة',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                              ),
                            ],
                            
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () => setState(() => _showAddForm = false),
                                    child: const Text('إلغاء'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _addPaymentMethod,
                                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: Colors.black),
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
                
                // قائمة طرق الدفع
                Expanded(
                  child: _paymentMethods.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card_off, size: 80, color: AppTheme.gold.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              const Text('لا توجد طرق دفع محفوظة', style: TextStyle(fontSize: 18)),
                              const SizedBox(height: 8),
                              Text('أضف بطاقة ائتمانية أو محفظة', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _paymentMethods.length,
                          itemBuilder: (context, index) {
                            final method = _paymentMethods[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16),
                                border: method['isDefault'] ? Border.all(color: AppTheme.gold, width: 2) : null,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: method['type'] == 'card' ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      method['type'] == 'card' ? Icons.credit_card : Icons.account_balance_wallet,
                                      color: method['type'] == 'card' ? Colors.blue : Colors.green,
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              method['type'] == 'card' ? '${method['brand']} •••• ${method['last4']}' : method['name'],
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            if (method['isDefault'])
                                              Container(
                                                margin: const EdgeInsets.only(left: 8),
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.gold.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Text('افتراضي', style: TextStyle(fontSize: 10, color: AppTheme.gold)),
                                              ),
                                          ],
                                        ),
                                        if (method['type'] == 'card')
                                          Text('تنتهي في ${method['expiry']}', style: const TextStyle(fontSize: 12)),
                                        if (method['type'] == 'wallet')
                                          Text('الرصيد: ${method['balance']} ر.ي', style: const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      if (!method['isDefault'])
                                        const PopupMenuItem(value: 'default', child: Text('تعيين كافتراضي')),
                                      const PopupMenuItem(value: 'delete', child: Text('حذف', style: TextStyle(color: Colors.red))),
                                    ],
                                    onSelected: (value) {
                                      if (value == 'default') _setDefault(index);
                                      if (value == 'delete') _deleteMethod(index);
                                    },
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
  
  Widget _buildTypeOption(String type, String label, IconData icon) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppTheme.gold : Colors.grey.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppTheme.gold : Colors.grey),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isSelected ? AppTheme.gold : Colors.grey)),
          ],
        ),
      ),
    );
  }
}

