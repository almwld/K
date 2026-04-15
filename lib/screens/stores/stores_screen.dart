import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/simple_app_bar.dart';
import '../../data/stores_data.dart';
import '../../models/store_model.dart';
import 'store_detail_screen.dart';

class StoresScreen extends StatefulWidget {
  final String? category;
  const StoresScreen({super.key, this.category});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  List<StoreModel> _stores = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _stores = widget.category != null ? StoresData.getStoresByCategory(widget.category!) : StoresData.getAllStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SimpleAppBar(title: widget.category ?? 'جميع المتاجر'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _stores.length,
        itemBuilder: (context, index) {
          final store = _stores[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Image.network(store.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(store.name),
              subtitle: Text(store.address),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StoreDetailScreen(store: store))),
            ),
          );
        },
      ),
    );
  }
}
