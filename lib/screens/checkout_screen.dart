import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';
import '../widgets/custom_button.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final ProductModel? product;
  const CheckoutScreen({super.key, this.product});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  
  String _selectedCompanyId = '';
  String _selectedPaymentMethod = 'cash';
  bool _isSubmitting = false;
  
  final List<Map<String, dynamic>> _shippingCompanies = [
    {'id': '1', 'name': 'سبيدكس اليمن', 'price': 1500, 'days': '2-3 أيام'},
    {'id': '2', 'name': 'يمن إكسبرس', 'price': 2000, 'days': '1-2 أيام'},
    {'id': '3', 'name': 'دليفري بلس', 'price': 1200, 'days': '3-4 أيام'},
    {'id': '4', 'name': 'شحن سريع اليمن', 'price': 2500, 'days': '1-2 أيام'},
    {'id': '5', 'name': 'بريد اليمن', 'price': 800, 'days': '5-7 أيام'},
  ];
  
  double get _productPrice => widget.product?.price ?? 0;
  double get _shippingCost {
    final company = _shippingCompanies.firstWhere((c) => c['id'] == _selectedCompanyId, orElse: () => {});
    return (company['price'] ?? 0).toDouble();
  }
  double get _totalPrice => _productPrice + _shippingCost;
  
  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCompanyId.isEmpty) {
      _showSnackBar('الرجاء اختيار شركة الشحن');
      return;
    }
    
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isSubmitting = false);
      
      final order = OrderModel(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
        productId: widget.product?.id ?? '',
        productTitle: widget.product?.title ?? '',
        productImage: widget.product?.images.isNotEmpty == true ? widget.product!.images.first : '',
        productPrice: _productPrice,
        quantity: 1,
        shippingCost: _shippingCost,
        totalPrice: _totalPrice,
        customerName: _nameController.text,
        customerPhone: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        shippingCompany: _shippingCompanies.firstWhere((c) => c['id'] == _selectedCompanyId)['name'],
        trackingNumber: 'TRK${DateTime.now().millisecondsSinceEpoch}',
        status: 'pending',
        orderDate: DateTime.now(),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(order: order),
        ),
      );
    }
  }
  
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppTheme.goldColor),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'إتمام الشراء'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ملخص الطلب
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.goldColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.image, color: AppTheme.goldColor, size: 30),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.product?.title ?? 'المنتج', style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text('${_productPrice.toStringAsFixed(0)} ر.ي', style: const TextStyle(color: AppTheme.goldColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // معلومات العميل
                  const Text('معلومات العميل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'الاسم الكامل', border: OutlineInputBorder()),
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
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'المدينة', border: OutlineInputBorder()),
                    validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'العنوان التفصيلي', border: OutlineInputBorder()),
                    validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // شركات الشحن
                  const Text('شركة الشحن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ..._shippingCompanies.map((company) => _buildShippingCard(company)),
                  
                  const SizedBox(height: 24),
                  
                  // تفاصيل الأسعار
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildPriceRow('سعر المنتج', _productPrice),
                        _buildPriceRow('تكلفة الشحن', _shippingCost),
                        const Divider(height: 24),
                        _buildPriceRow('الإجمالي', _totalPrice, isTotal: true),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  CustomButton(
                    text: 'تأكيد الطلب',
                    onPressed: _submitOrder,
                    isLoading: _isSubmitting,
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(child: CircularProgressIndicator(color: AppTheme.goldColor)),
            ),
        ],
      ),
    );
  }
  
  Widget _buildShippingCard(Map<String, dynamic> company) {
    final isSelected = _selectedCompanyId == company['id'];
    return GestureDetector(
      onTap: () => setState(() => _selectedCompanyId = company['id']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppTheme.goldColor : Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_shipping, color: AppTheme.goldColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(company['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${company['days']} • ${company['price']} ر.ي', style: TextStyle(color: AppTheme.getSecondaryTextColor(context))),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: AppTheme.goldColor),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(
            '${amount.toStringAsFixed(0)} ر.ي',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppTheme.goldColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
