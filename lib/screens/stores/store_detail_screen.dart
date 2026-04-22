import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class StoreDetailScreen extends StatelessWidget {
  final String storeId;

  const StoreDetailScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0E11),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: const Color(0xFF0B0E11),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share, color: Color(0xFFD4AF37)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Color(0xFFD4AF37)),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFFD4AF37).withOpacity(0.3), const Color(0xFF0B0E11)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                              color: const Color(0xFF1E2329),
                            ),
                            child: const Icon(Icons.store, color: Color(0xFFD4AF37), size: 40),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'متجر التقنية الحديثة',
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.verified, color: Color(0xFFD4AF37), size: 16),
                              const SizedBox(width: 4),
                              const Text('متجر موثق', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12)),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0ECB81).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF0ECB81),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text('مفتوح', style: TextStyle(color: Color(0xFF0ECB81), fontSize: 11)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottom: const TabBar(
                labelColor: Color(0xFFD4AF37),
                unselectedLabelColor: Color(0xFF9CA3AF),
                indicatorColor: Color(0xFFD4AF37),
                tabs: [
                  Tab(text: 'المنتجات'),
                  Tab(text: 'التقييمات'),
                  Tab(text: 'معلومات'),
                ],
              ),
            ),
            
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  _buildProductsTab(),
                  _buildReviewsTab(),
                  _buildInfoTab(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0E11),
            border: Border(top: BorderSide(color: const Color(0xFF2B3139))),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4AF37)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('متابعة', style: TextStyle(color: Color(0xFFD4AF37))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('تواصل مع المتجر', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.1),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Center(child: Icon(Icons.shopping_bag, color: Color(0xFFD4AF37), size: 40)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('منتج $index', style: TextStyle(color: Colors.white, fontSize: 13)),
                    const SizedBox(height: 4),
                    const Text('١٠٠ ريال', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2329),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 20, child: Icon(Icons.person, size: 24)),
                  const SizedBox(width: 12),
                  Text('مستخدم $index', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(
                    children: List.generate(5, (i) => Icon(Icons.star, color: i < 4 ? Colors.amber : Colors.grey, size: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('منتج رائع وجودة ممتازة، أنصح بالتعامل مع هذا المتجر.', style: TextStyle(color: Color(0xFF9CA3AF))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.location_on, 'العنوان', 'شارع الستين، صنعاء'),
          _buildInfoRow(Icons.phone, 'الهاتف', '777123456'),
          _buildInfoRow(Icons.email, 'البريد', 'store@flexyemen.com'),
          _buildInfoRow(Icons.access_time, 'ساعات العمل', '٩ صباحاً - ١٠ مساءً'),
          const SizedBox(height: 16),
          const Text('عن المتجر', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('متجر متخصص في بيع أحدث الأجهزة الإلكترونية والجوالات بأسعار منافسة وجودة عالية.', style: TextStyle(color: Color(0xFF9CA3AF))),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 20),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(color: Color(0xFF9CA3AF))),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
