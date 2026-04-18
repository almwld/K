import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class TransfersHistoryScreen extends StatefulWidget {
  const TransfersHistoryScreen({super.key});

  @override
  State<TransfersHistoryScreen> createState() => _TransfersHistoryScreenState();
}

class _TransfersHistoryScreenState extends State<TransfersHistoryScreen> {
  String _selectedTab = 'المرسلة';
  
  final List<Map<String, dynamic>> _sentTransfers = [
    {'id': '1', 'to': 'أحمد محمد علي', 'amount': '2,500', 'currency': 'YER', 'date': '2024-04-03', 'time': '15:45', 'status': 'completed', 'phone': '712345678', 'note': 'فاتورة شهر مارس'},
    {'id': '2', 'to': 'فاطمة علي حسن', 'amount': '100', 'currency': 'SAR', 'date': '2024-04-01', 'time': '16:30', 'status': 'pending', 'phone': '712345679', 'note': 'هدية'},
    {'id': '3', 'to': 'محمد سعيد أحمد', 'amount': '500', 'currency': 'YER', 'date': '2024-03-28', 'time': '10:15', 'status': 'completed', 'phone': '712345680', 'note': ''},
    {'id': '4', 'to': 'نورة عبدالله', 'amount': '50', 'currency': 'USD', 'date': '2024-03-25', 'time': '20:00', 'status': 'completed', 'phone': '712345681', 'note': 'حفلة عيد ميلاد'},
  ];

  final List<Map<String, dynamic>> _receivedTransfers = [
    {'id': '5', 'from': 'خالد عبدالرحمن', 'amount': '1,000', 'currency': 'YER', 'date': '2024-04-02', 'time': '11:30', 'status': 'completed', 'phone': '712345682', 'note': 'رد دين'},
    {'id': '6', 'from': 'سارة أحمد', 'amount': '200', 'currency': 'SAR', 'date': '2024-03-30', 'time': '14:20', 'status': 'completed', 'phone': '712345683', 'note': ''},
    {'id': '7', 'from': 'عمر حسن', 'amount': '30', 'currency': 'USD', 'date': '2024-03-27', 'time': '09:45', 'status': 'completed', 'phone': '712345684', 'note': 'شحن'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final transfers = _selectedTab == 'المرسلة' ? _sentTransfers : _receivedTransfers;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'سجل الحوالات'),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: transfers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.compare_arrows, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد حوالات', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: transfers.length,
                    itemBuilder: (context, index) {
                      final transfer = transfers[index];
                      return _buildTransferCard(transfer, _selectedTab == 'المرسلة');
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
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
              onTap: () {
                setState(() {
                  _selectedTab = 'المرسلة';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 'المرسلة' ? AppTheme.goldLight : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'حوالات مرسلة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 'المرسلة' ? Colors.white : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTab = 'المستلمة';
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _selectedTab == 'المستلمة' ? AppTheme.goldLight : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'حوالات مستلمة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _selectedTab == 'المستلمة' ? Colors.white : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferCard(Map<String, dynamic> transfer, bool isSent) {
    final person = isSent ? transfer['to'] : transfer['from'];
    final statusColor = transfer['status'] == 'completed' ? Colors.green :
                       transfer['status'] == 'pending' ? Colors.orange : Colors.red;
    final statusText = transfer['status'] == 'completed' ? 'مكتمل' :
                       transfer['status'] == 'pending' ? 'قيد الانتظار' : 'فشل';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSent ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSent ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isSent ? Colors.red : Colors.green,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transfer['phone'],
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isSent ? '-' : '+'}${transfer['amount']} ${transfer['currency']}',
                    style: TextStyle(
                      color: isSent ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(fontSize: 9, color: statusColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (transfer['note'].isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.goldLight.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.note, size: 14, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      transfer['note'],
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${transfer['date']} - ${transfer['time']}',
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
