import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simple_app_bar.dart';

class SellerDashboard extends StatelessWidget {
  const SellerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const SimpleAppBar(title: 'لوحة تحكم البائع'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Seller Info Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0ECB81), Color(0xFF00C853)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.store,
                                size: 40,
                                color: Color(0xFF0ECB81),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'متجرك التجاري',
                                    style: TextStyle(
                                      fontFamily: 'Changa',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'بائع نشط',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _infoChip('التقييم', '4.8'),
                            _infoChip('المبيعات', '156'),
                            _infoChip('المنتجات', '42'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Earnings
                  _buildEarningsSection(),
                  const SizedBox(height: 20),

                  // Quick Actions
                  const Text(
                    'إجراءات سريعة',
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _actionButton('إضافة منتج', Icons.add_box, const Color(0xFF2196F3)),
                      _actionButton('طلباتي', Icons.receipt_long, const Color(0xFF0ECB81)),
                      _actionButton('الإحصائيات', Icons.bar_chart, const Color(0xFFF0B90B)),
                      _actionButton('الرسائل', Icons.message, const Color(0xFF9C27B0)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Changa',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الأرباح',
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _earningCard('هذا الأسبوع', '45,000 ر.ي', Icons.calendar_today),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _earningCard('هذا الشهر', '180,000 ر.ي', Icons.date_range),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _earningCard('إجمالي الأرباح', '1,250,000 ر.ي', Icons.account_balance_wallet,
              isTotal: true),
        ],
      ),
    );
  }

  Widget _earningCard(String label, String value, IconData icon, {bool isTotal = false}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isTotal
            ? const Color(0xFFF0B90B).withOpacity(0.2)
            : const Color(0xFF0B0E11),
        borderRadius: BorderRadius.circular(12),
        border: isTotal
            ? Border.all(color: const Color(0xFFF0B90B).withOpacity(0.5))
            : null,
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 22,
              color: isTotal ? const Color(0xFFF0B90B) : const Color(0xFF9CA3AF)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: isTotal ? 18 : 14,
                    fontWeight: FontWeight.bold,
                    color: isTotal ? const Color(0xFFF0B90B) : Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2329),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
