import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0E11),
          elevation: 0,
          title: const Text('متجر التقنية', style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset('assets/icons/svg/store.svg', width: 30, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('متجر التقنية', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            SvgPicture.asset('assets/icons/svg/verified.svg', width: 14),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            const Text('4.8', style: TextStyle(color: Colors.white)),
                            const SizedBox(width: 4),
                            Text('(128 تقييم)', style: TextStyle(color: Colors.grey[500])),
                            const SizedBox(width: 12),
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF0ECB81), shape: BoxShape.circle)),
                            const SizedBox(width: 4),
                            const Text('مفتوح', style: TextStyle(color: Color(0xFF0ECB81), fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)),
                    child: const Text('متابعة', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            const TabBar(
              labelColor: Color(0xFFD4AF37),
              unselectedLabelColor: Color(0xFF9CA3AF),
              indicatorColor: Color(0xFFD4AF37),
              tabs: [Tab(text: 'المنتجات'), Tab(text: 'التقييمات'), Tab(text: 'معلومات')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: 6, itemBuilder: (c, i) => Container(decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(children: [Expanded(child: Container(decoration: BoxDecoration(color: const Color(0xFFD4AF37).withOpacity(0.1), borderRadius: const BorderRadius.vertical(top: Radius.circular(12))))), Padding(padding: const EdgeInsets.all(8), child: Column(children: [Text('منتج ${i+1}', style: const TextStyle(color: Colors.white)), const Text('100 ريال', style: TextStyle(color: Color(0xFFD4AF37)))])),]),)),
                  ListView.builder(padding: const EdgeInsets.all(16), itemCount: 3, itemBuilder: (c, i) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1E2329), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [const CircleAvatar(radius: 20, child: Icon(Icons.person)), const SizedBox(width: 12), Text('مستخدم ${i+1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const Spacer(), Row(children: List.generate(5, (j) => Icon(j < 4 ? Icons.star : Icons.star_border, color: Colors.amber, size: 16)))]), const SizedBox(height: 8), const Text('منتج رائع وجودة ممتازة', style: TextStyle(color: Color(0xFF9CA3AF)))])),),
                  ListView(padding: const EdgeInsets.all(16), children: [ListTile(leading: SvgPicture.asset('assets/icons/svg/location.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), title: const Text('شارع الستين، صنعاء', style: TextStyle(color: Colors.white))), ListTile(leading: SvgPicture.asset('assets/icons/svg/phone.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), title: const Text('777123456', style: TextStyle(color: Colors.white))), ListTile(leading: SvgPicture.asset('assets/icons/svg/email.svg', width: 20, colorFilter: const ColorFilter.mode(Color(0xFFD4AF37), BlendMode.srcIn)), title: const Text('store@flexyemen.com', style: TextStyle(color: Colors.white)))],),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
