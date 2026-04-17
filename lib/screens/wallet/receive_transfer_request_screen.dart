import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class ReceiveTransferRequestScreen extends StatefulWidget {
  const ReceiveTransferRequestScreen({super.key});

  @override
  State<ReceiveTransferRequestScreen> createState() => _ReceiveTransferRequestScreenState();
}

class _ReceiveTransferRequestScreenState extends State<ReceiveTransferRequestScreen> {
  String _selectedWallet = '';
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<Map<String, dynamic>> _wallets = [
    {'name': 'موبايل موني', 'code': 'MobileMoney', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'name': 'كاش', 'code': 'Cash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'جيب', 'code': 'Jaib', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37},
    {'name': 'واصل', 'code': 'Wasel', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
  ];

  final List<Map<String, dynamic>> _requests = [
    {'code': 'REQ-123456', 'amount': '25,000', 'sender': 'أحمد علي', 'date': '2024-04-03', 'status': 'pending', 'wallet': 'جيب'},
    {'code': 'REQ-123457', 'amount': '10,000', 'sender': 'محمد حسن', 'date': '2024-04-02', 'status': 'pending', 'wallet': 'واصل'},
    {'code': 'REQ-123458', 'amount': '5,000', 'sender': 'خالد عبدالله', 'date': '2024-04-02', 'status': 'completed', 'wallet': 'موبايل موني'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'استلام طلب تحويل'),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [Tab(text: 'طلبات مستلمة'), Tab(text: 'استلام برمز')],
              labelColor: AppTheme.goldAccent,
              indicatorColor: AppTheme.goldAccent,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildRequestsList(),
                  _buildReceiveByCode(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _requests.length,
      itemBuilder: (context, index) {
        final request = _requests[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.request_page, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('رمز: ${request['code']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('من: ${request['sender']}', style: const TextStyle(fontSize: 12)),
                    Text(request['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${request['amount']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  if (request['status'] == 'pending')
                    ElevatedButton(
                      onPressed: () => _acceptRequest(request),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
                      child: const Text('استلام', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReceiveByCode() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedWallet.isEmpty ? null : _selectedWallet,
            decoration: InputDecoration(
              labelText: 'اختر المحفظة المستلمة',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            items: _wallets.map((wallet) {
              return DropdownMenuItem<String>(
                value: wallet['code'],
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: wallet['image'],
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Icon(Icons.account_balance_wallet, size: 20, color: Color(wallet['color'])),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(wallet['name']),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedWallet = value!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'رمز الطلب',
              prefixIcon: const Icon(Icons.qr_code),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'المبلغ',
              prefixIcon: const Icon(Icons.attach_money),
              suffixText: 'ر.ي',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_selectedWallet.isNotEmpty && _codeController.text.isNotEmpty && _amountController.text.isNotEmpty) ? () => _receiveByCode() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('استلام', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  void _acceptRequest(Map<String, dynamic> request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد استلام الطلب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('استلام طلب تحويل بقيمة ${request['amount']} ر.ي'),
            Text('من: ${request['sender']}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(request['amount']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _receiveByCode() {
    final amount = _amountController.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد الاستلام'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.qr_code, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            Text('استلام $amount ر.ي'),
            Text('برمز الطلب: ${_codeController.text}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(amount);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم استلام التحويل بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم استلام $amount ر.ي'),
            const Text('سيتم إضافتها إلى محفظتك'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
