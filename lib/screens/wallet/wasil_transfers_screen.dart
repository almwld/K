import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WasilTransfersScreen extends StatefulWidget {
  const WasilTransfersScreen({super.key});

  @override
  State<WasilTransfersScreen> createState() => _WasilTransfersScreenState();
}

class _WasilTransfersScreenState extends State<WasilTransfersScreen> {
  String _selectedAction = 'send'; // send / receive / cancel
  String _selectedWallet = '';
  String _transferCode = '';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final List<Map<String, dynamic>> _wallets = [
    {'name': 'موبايل موني', 'code': 'MobileMoney', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFE31E24},
    {'name': 'كاش', 'code': 'Cash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
    {'name': 'سيا كاش', 'code': 'SiaCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF2196F3},
    {'name': 'سبأ كاش', 'code': 'SabaCash', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'جيب', 'code': 'Jaib', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFD4AF37},
    {'name': 'يمن وانت', 'code': 'YemenWant', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFFFF9800},
    {'name': 'واصل', 'code': 'Wasel', 'image': 'https://play-lh.googleusercontent.com/3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x3x', 'color': 0xFF4CAF50},
  ];

  final List<Map<String, dynamic>> _recentTransfers = [
    {'code': 'WSL-123456', 'amount': '25,000', 'status': 'completed', 'date': '2024-04-03', 'type': 'send', 'receiver': 'أحمد علي'},
    {'code': 'WSL-123457', 'amount': '10,000', 'status': 'completed', 'date': '2024-04-02', 'type': 'receive', 'sender': 'محمد حسن'},
    {'code': 'WSL-123458', 'amount': '5,000', 'status': 'pending', 'date': '2024-04-02', 'type': 'send', 'receiver': 'خالد عبدالله'},
    {'code': 'WSL-123459', 'amount': '15,000', 'status': 'completed', 'date': '2024-04-01', 'type': 'receive', 'sender': 'سارة علي'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'واصل - تحويلات'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildActionTabs(),
            const SizedBox(height: 16),
            if (_selectedAction == 'send') _buildSendForm(),
            if (_selectedAction == 'receive') _buildReceiveForm(),
            if (_selectedAction == 'cancel') _buildCancelForm(),
            const SizedBox(height: 24),
            _buildRecentTransfers(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedAction = 'send'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedAction == 'send' ? AppTheme.goldAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.send, color: _selectedAction == 'send' ? Colors.white : AppTheme.goldAccent, size: 24),
                    const SizedBox(height: 4),
                    Text('إرسال', style: TextStyle(color: _selectedAction == 'send' ? Colors.white : null)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedAction = 'receive'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedAction == 'receive' ? AppTheme.goldAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.download, color: _selectedAction == 'receive' ? Colors.white : AppTheme.goldAccent, size: 24),
                    const SizedBox(height: 4),
                    Text('استلام', style: TextStyle(color: _selectedAction == 'receive' ? Colors.white : null)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedAction = 'cancel'),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedAction == 'cancel' ? AppTheme.goldAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.cancel, color: _selectedAction == 'cancel' ? Colors.white : AppTheme.goldAccent, size: 24),
                    const SizedBox(height: 4),
                    Text('إلغاء', style: TextStyle(color: _selectedAction == 'cancel' ? Colors.white : null)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendForm() {
    final amount = int.tryParse(_amountController.text) ?? 0;
    final fee = amount > 0 ? (amount * 0.01).toInt() : 0; // 1% رسوم
    final total = amount + fee;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إرسال حوالة واصل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedWallet.isEmpty ? null : _selectedWallet,
            decoration: InputDecoration(
              labelText: 'اختر المحفظة المرسلة',
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
            controller: _receiverNameController,
            decoration: InputDecoration(
              labelText: 'اسم المستلم',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _receiverPhoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'رقم جوال المستلم',
              prefixIcon: const Icon(Icons.phone),
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
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.goldAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('المبلغ:'), Text('$amount ر.ي', style: const TextStyle(fontWeight: FontWeight.bold))]),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('رسوم التحويل (1%):'), Text('$fee ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange))]),
                const Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('الإجمالي:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('$total ر.ي', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.goldAccent))]),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_selectedWallet.isNotEmpty && _receiverNameController.text.isNotEmpty && amount > 0)
                  ? () => _sendTransfer(amount, fee, total)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إرسال الحوالة', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiveForm() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('استلام حوالة واصل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'رمز الحوالة',
              prefixIcon: const Icon(Icons.qr_code),
              hintText: 'مثال: WSL-123456',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_codeController.text.isNotEmpty && _selectedWallet.isNotEmpty)
                  ? () => _receiveTransfer()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('استلام الحوالة', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelForm() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('إلغاء حوالة واصل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'رمز الحوالة',
              prefixIcon: const Icon(Icons.cancel),
              hintText: 'مثال: WSL-123456',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _codeController.text.isNotEmpty ? () => _cancelTransfer() : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('إلغاء الحوالة', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransfers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('آخر التحويلات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentTransfers.length,
          itemBuilder: (context, index) {
            final transfer = _recentTransfers[index];
            return _buildTransferItem(transfer);
          },
        ),
      ],
    );
  }

  Widget _buildTransferItem(Map<String, dynamic> transfer) {
    final isSend = transfer['type'] == 'send';
    final statusColor = transfer['status'] == 'completed' ? Colors.green : Colors.orange;
    final statusText = transfer['status'] == 'completed' ? 'مكتمل' : 'قيد الانتظار';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSend ? Colors.blue.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(isSend ? Icons.send : Icons.download, color: isSend ? Colors.blue : Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transfer['code'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(isSend ? 'إلى: ${transfer['receiver']}' : 'من: ${transfer['sender']}', style: const TextStyle(fontSize: 12)),
                Text(transfer['date'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${transfer['amount']} ر.ي', style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(statusText, style: TextStyle(color: statusColor, fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendTransfer(int amount, int fee, int total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد إرسال الحوالة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.send, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            Text('إرسال $amount ر.ي إلى ${_receiverNameController.text}'),
            Text('الرسوم: $fee ر.ي'),
            Text('الإجمالي: $total ر.ي'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog('send', amount);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _receiveTransfer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد استلام الحوالة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.download, size: 60, color: Colors.green),
            const SizedBox(height: 16),
            Text('استلام حوالة برقم: ${_codeController.text}'),
            const SizedBox(height: 8),
            const Text('سيتم إضافة المبلغ إلى محفظتك'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog('receive', 0);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldAccent),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _cancelTransfer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تأكيد إلغاء الحوالة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text('إلغاء حوالة برقم: ${_codeController.text}'),
            const SizedBox(height: 8),
            const Text('سيتم استرداد المبلغ إلى محفظتك', style: TextStyle(color: Colors.red)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog('cancel', 0);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('تأكيد الإلغاء'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String type, int amount) {
    String title = '';
    String message = '';
    IconData icon = Icons.check_circle;
    Color color = Colors.green;

    if (type == 'send') {
      title = 'تم إرسال الحوالة بنجاح';
      message = 'تم إرسال $amount ر.ي بنجاح';
    } else if (type == 'receive') {
      title = 'تم استلام الحوالة بنجاح';
      message = 'تم استلام الحوالة بنجاح';
    } else {
      title = 'تم إلغاء الحوالة بنجاح';
      message = 'تم إلغاء الحوالة بنجاح';
      color = Colors.orange;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 60, color: color),
            const SizedBox(height: 16),
            Text(message),
            if (type == 'send') Text('رمز الحوالة: WSL-${DateTime.now().millisecondsSinceEpoch}'),
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
