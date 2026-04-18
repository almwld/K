import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';

class WalletStatementScreen extends StatefulWidget {
  const WalletStatementScreen({super.key});

  @override
  State<WalletStatementScreen> createState() => _WalletStatementScreenState();
}

class _WalletStatementScreenState extends State<WalletStatementScreen> {
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
  String _selectedType = 'all';
  String _selectedExportFormat = 'pdf';
  
  final List<Map<String, dynamic>> _types = [
    {'id': 'all', 'name': 'الكل', 'icon': Icons.list},
    {'id': 'deposit', 'name': 'إيداع', 'icon': Icons.arrow_downward, 'color': Colors.green},
    {'id': 'withdraw', 'name': 'سحب', 'icon': Icons.arrow_upward, 'color': Colors.red},
    {'id': 'transfer', 'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.blue},
    {'id': 'payment', 'name': 'دفع', 'icon': Icons.payment, 'color': Colors.orange},
  ];

  final List<Map<String, dynamic>> _exportFormats = [
    {'id': 'pdf', 'name': 'PDF', 'icon': Icons.picture_as_pdf, 'color': 0xFFF44336},
    {'id': 'excel', 'name': 'Excel', 'icon': Icons.table_chart, 'color': 0xFF4CAF50},
    {'id': 'csv', 'name': 'CSV', 'icon': Icons.data_usage, 'color': 0xFF2196F3},
  ];

  final List<Map<String, dynamic>> _transactions = [
    {'id': '1', 'title': 'إيداع نقدي', 'amount': '+10,000', 'type': 'deposit', 'date': DateTime.now().subtract(const Duration(days: 1)), 'time': '10:30', 'status': 'completed', 'reference': 'DEP-20240401-001'},
    {'id': '2', 'title': 'تحويل إلى جيب', 'amount': '-5,000', 'type': 'transfer', 'date': DateTime.now().subtract(const Duration(days: 2)), 'time': '14:20', 'status': 'completed', 'reference': 'TRF-20240331-002'},
    {'id': '3', 'title': 'شراء باقة نت', 'amount': '-2,000', 'type': 'payment', 'date': DateTime.now().subtract(const Duration(days: 3)), 'time': '09:15', 'status': 'completed', 'reference': 'PAY-20240330-003'},
    {'id': '4', 'title': 'استلام حوالة', 'amount': '+25,000', 'type': 'deposit', 'date': DateTime.now().subtract(const Duration(days: 4)), 'time': '16:45', 'status': 'completed', 'reference': 'REC-20240329-004'},
    {'id': '5', 'title': 'سحب نقدي', 'amount': '-3,000', 'type': 'withdraw', 'date': DateTime.now().subtract(const Duration(days: 5)), 'time': '11:00', 'status': 'completed', 'reference': 'WTH-20240328-005'},
    {'id': '6', 'title': 'تحويل إلى واصل', 'amount': '-2,500', 'type': 'transfer', 'date': DateTime.now().subtract(const Duration(days: 6)), 'time': '13:30', 'status': 'pending', 'reference': 'TRF-20240327-006'},
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    return _transactions.where((t) {
      if (_selectedType != 'all' && t['type'] != _selectedType) return false;
      if (t['date'].isBefore(_selectedDateRange.start) || t['date'].isAfter(_selectedDateRange.end)) return false;
      return true;
    }).toList();
  }

  double get _totalIncome {
    return _filteredTransactions
        .where((t) => t['amount'].startsWith('+'))
        .fold(0.0, (sum, t) => sum + double.parse(t['amount'].substring(1).replaceAll(',', '')));
  }

  double get _totalExpense {
    return _filteredTransactions
        .where((t) => t['amount'].startsWith('-'))
        .fold(0.0, (sum, t) => sum + double.parse(t['amount'].substring(1).replaceAll(',', '')));
  }

  double get _balance {
    return _totalIncome - _totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredTransactions;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.nightSurface : AppTheme.lightBackground,
      appBar: const SimpleAppBar(title: 'كشف الحساب'),
      body: Column(
        children: [
          _buildSummaryCards(),
          _buildFilters(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text('لا توجد معاملات في هذه الفترة', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => _buildTransactionCard(filtered[index]),
                  ),
          ),
          _buildExportButton(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.goldLight, AppTheme.goldDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('الإيرادات', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text(
                  '${NumberFormat('#,###').format(_totalIncome)} ر.ي',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          Expanded(
            child: Column(
              children: [
                const Text('المصروفات', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text(
                  '${NumberFormat('#,###').format(_totalExpense)} ر.ي',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          Expanded(
            child: Column(
              children: [
                const Text('الرصيد', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text(
                  '${NumberFormat('#,###').format(_balance)} ر.ي',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // فلتر التاريخ
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2024, 1, 1),
                      lastDate: DateTime.now(),
                      initialDateRange: _selectedDateRange,
                    );
                    if (picked != null) {
                      setState(() => _selectedDateRange = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.goldLight.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.date_range, color: AppTheme.goldLight),
                        const SizedBox(width: 8),
                        Text(
                          '${DateFormat('dd/MM/yyyy').format(_selectedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange.end)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // فلتر النوع
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.goldLight.withOpacity(0.3)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedType,
                    items: _types.map((type) {
                      return DropdownMenuItem<String>(
                        value: type['id'],
                        child: Row(
                          children: [
                            Icon(type['icon'], size: 18, color: type.containsKey('color') ? type['color'] : null),
                            const SizedBox(width: 4),
                            Text(type['name']),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedType = value!),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isIncome = transaction['amount'].startsWith('+');
    final amountColor = isIncome ? Colors.green : Colors.red;
    final typeData = _types.firstWhere((t) => t['id'] == transaction['type']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(typeData['color']).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(typeData['icon'], color: Color(typeData['color']), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(transaction['date'])} • ${transaction['time']}',
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    Text(transaction['reference'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              Text(
                '${transaction['amount']} ر.ي',
                style: TextStyle(fontWeight: FontWeight.bold, color: amountColor),
              ),
            ],
          ),
          if (transaction['status'] == 'pending')
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.pending, size: 12, color: Colors.orange),
                  SizedBox(width: 4),
                  Text('قيد الانتظار', style: TextStyle(color: Colors.orange, fontSize: 10)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExportButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _selectedExportFormat,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              items: _exportFormats.map((format) {
                return DropdownMenuItem<String>(
                  value: format['id'],
                  child: Row(
                    children: [
                      Icon(format['icon'], color: Color(format['color']), size: 20),
                      const SizedBox(width: 8),
                      Text(format['name']),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedExportFormat = value!),
            ),
          ),
          Container(width: 1, height: 30, color: Colors.grey[300]),
          TextButton.icon(
            onPressed: () => _showExportDialog(),
            icon: const Icon(Icons.download),
            label: const Text('تصدير'),
            style: TextButton.styleFrom(foregroundColor: AppTheme.goldLight),
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    final format = _exportFormats.firstWhere((f) => f['id'] == _selectedExportFormat);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تصدير كشف الحساب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(format['icon'], size: 60, color: Color(format['color'])),
            const SizedBox(height: 16),
            Text('تصدير كشف الحساب بصيغة ${format['name']}'),
            const SizedBox(height: 8),
            Text(
              'الفترة: ${DateFormat('dd/MM/yyyy').format(_selectedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange.end)}',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text('عدد المعاملات: ${_filteredTransactions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(format);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.goldLight),
            child: const Text('تصدير'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(Map<String, dynamic> format) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('تم التصدير بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('تم تصدير كشف الحساب بصيغة ${format['name']}'),
            const Text('سيتم حفظ الملف في مجلد التنزيلات'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }
}
