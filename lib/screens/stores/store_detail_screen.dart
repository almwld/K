import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/store_model.dart';

class StoreDetailScreen extends StatelessWidget {
  final StoreModel store;
  const StoreDetailScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(store.name), backgroundColor: AppTheme.goldColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(store.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(store.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.star, color: Colors.amber), Text(' ${store.rating}')]),
            const SizedBox(height: 16),
            Text(store.description),
            const SizedBox(height: 16),
            Row(children: [const Icon(Icons.location_on), const SizedBox(width: 8), Expanded(child: Text(store.address))]),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.phone), const SizedBox(width: 8), Text(store.phone)]),
          ],
        ),
      ),
    );
  }
}
