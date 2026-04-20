import 'package:flutter/material.dart';

class MarketModel {
  final String id;
  final String name;
  final String nameAr;
  final double change;
  final String volume;
  final int items;
  final int sellers;
  final String icon;
  final Color color;
  final List<String> topProducts;
  final bool isTrending;
  final DateTime lastUpdated;

  MarketModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.change,
    required this.volume,
    required this.items,
    required this.sellers,
    required this.icon,
    required this.color,
    this.topProducts = const [],
    this.isTrending = false,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  bool get isPositive => change >= 0;
  String get formattedChange => '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%';
  Color get changeColor => isPositive ? const Color(0xFF0ECB81) : const Color(0xFFF6465D);

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['nameAr'] ?? '',
      change: (json['change'] ?? 0).toDouble(),
      volume: json['volume'] ?? '0',
      items: json['items'] ?? 0,
      sellers: json['sellers'] ?? 0,
      icon: json['icon'] ?? 'store',
      color: Color(json['color'] ?? 0xFFF0B90B),
      topProducts: List<String>.from(json['topProducts'] ?? []),
      isTrending: json['isTrending'] ?? false,
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated']) 
          : DateTime.now(),
    );
  }
}

// البيانات الوهمية للأسواق
final List<MarketModel> mockMarkets = [
  MarketModel(
    id: 'yemeni_market',
    name: 'Yemeni Market',
    nameAr: 'السوق اليمني',
    change: 2.5,
    volume: '1.2M',
    items: 1250,
    sellers: 340,
    icon: 'store',
    color: const Color(0xFFF0B90B),
    topProducts: ['تمور', 'عسل', 'بن', 'بهارات'],
    isTrending: true,
  ),
  MarketModel(
    id: 'malls',
    name: 'Shopping Malls',
    nameAr: 'المولات',
    change: 1.8,
    volume: '890K',
    items: 450,
    sellers: 120,
    icon: 'shopping_bag',
    color: const Color(0xFF0ECB81),
    topProducts: ['ملابس', 'إلكترونيات', 'أحذية'],
  ),
  MarketModel(
    id: 'cafes',
    name: 'Cafes & Restaurants',
    nameAr: 'المقاهي والمطاعم',
    change: 3.2,
    volume: '567K',
    items: 320,
    sellers: 85,
    icon: 'restaurant',
    color: const Color(0xFF2196F3),
    topProducts: ['مندي', 'فروج', 'قهوة تركية'],
    isTrending: true,
  ),
  MarketModel(
    id: 'hotels',
    name: 'Hotels & Tourism',
    nameAr: 'الفنادق والسياحة',
    change: -0.5,
    volume: '456K',
    items: 95,
    sellers: 45,
    icon: 'hotel',
    color: const Color(0xFFF6465D),
    topProducts: ['غرف فاخرة', 'جولات سياحية'],
  ),
  MarketModel(
    id: 'electronics',
    name: 'Electronics Market',
    nameAr: 'سوق الإلكترونيات',
    change: 4.1,
    volume: '2.1M',
    items: 890,
    sellers: 210,
    icon: 'devices',
    color: const Color(0xFF9C27B0),
    topProducts: ['آيفون', 'سماعات', 'لابتوب'],
    isTrending: true,
  ),
  MarketModel(
    id: 'real_estate',
    name: 'Real Estate',
    nameAr: 'العقارات',
    change: 1.2,
    volume: '3.5M',
    items: 230,
    sellers: 67,
    icon: 'apartment',
    color: const Color(0xFF00BCD4),
    topProducts: ['شقق', 'أراضي', 'فلل'],
  ),
  MarketModel(
    id: 'cars',
    name: 'Auto Market',
    nameAr: 'سوق السيارات',
    change: -1.8,
    volume: '1.8M',
    items: 560,
    sellers: 150,
    icon: 'directions_car',
    color: const Color(0xFFFF9800),
    topProducts: ['تويوتا', 'هونداي', 'شيفروليه'],
  ),
  MarketModel(
    id: 'fashion',
    name: 'Fashion Market',
    nameAr: 'سوق الأزياء',
    change: 2.9,
    volume: '780K',
    items: 670,
    sellers: 200,
    icon: 'checkroom',
    color: const Color(0xFFE91E63),
    topProducts: ['ثياب', 'أحذية', 'ساعات'],
    isTrending: true,
  ),
];
