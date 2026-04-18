import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class AuctionDetailScreen extends StatefulWidget {
  final Map<String, dynamic> auction;

  const AuctionDetailScreen({super.key, required this.auction});

  @override
  State<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends State<AuctionDetailScreen> {
  final TextEditingController _bidController = TextEditingController();
  int _currentBid = 0;
  List<Map<String, dynamic>> _bidHistory = [];

  @override
  void initState() {
    super.initState();
    _currentBid = widget.auction['currentBid'];
    _bidHistory = [
      {'name': 'أحمد علي', 'bid': widget.auction['currentBid'] - 50000, 'time': 'منذ ساعة'},
      {'name': 'محمد حسن', 'bid': widget.auction['currentBid'] - 100000, 'time': 'منذ ساعتين'},
      {'name': 'خالد عبدالله', 'bid': widget.auction['currentBid'] - 150000, 'time': 'منذ 3 ساعات'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.auction['endTime'] as DateTime;
    
    return Scaffold(
      appBar: SimpleAppBar(title: widget.auction['title']),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            _buildInfo(),
            _buildBidSection(remaining),
            _buildBidHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Image.network(
        widget.auction['image'],
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.image, size: 80),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.auction['title'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('السعر الحالي', style: TextStyle(color: Colors.grey)),
                  Text(
                    '$_currentBid ريال',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.goldPrimary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('السعر المبدئي', style: TextStyle(color: Colors.grey)),
                  Text('${widget.auction['startingBid']} ريال'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('عدد المزايدات', style: TextStyle(color: Colors.grey)),
                  Text('${widget.auction['bids']} مزايد'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBidSection(DateTime remaining) {
    final now = DateTime.now();
    final diff = remaining.difference(now);
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;
    final minBid = _currentBid + 10000;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.goldPrimary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.goldPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('الوقت المتبقي', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        days > 0
                            ? '$days يوم $hours ساعة $minutes دقيقة'
                            : hours > 0
                                ? '$hours ساعة $minutes دقيقة'
                                : '$minutes دقيقة',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _bidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'أدخل مبلغ المزايدة',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixText: 'ريال',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => _placeBid(minBid),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('زايد'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'الحد الأدنى للمزايدة: $minBid ريال',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildBidHistory() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سجل المزايدات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _bidHistory.length,
            itemBuilder: (context, index) {
              final bid = _bidHistory[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(bid['name'][0]),
                ),
                title: Text(bid['name']),
                subtitle: Text(bid['time']),
                trailing: Text(
                  '${bid['bid']} ريال',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _placeBid(int minBid) {
    final bidAmount = int.tryParse(_bidController.text);
    
    if (bidAmount == null || bidAmount < minBid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('المبلغ يجب أن يكون $minBid ريال على الأقل'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    setState(() {
      _currentBid = bidAmount;
      _bidHistory.insert(0, {
        'name': 'أنت',
        'bid': bidAmount,
        'time': 'الآن',
      });
    });
    
    _bidController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم تقديم مزايدتك بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
