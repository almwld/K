import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
class ProductModel {
  final String id;
  final String title;
  final String name;
  final String description;
  final double price;
  final double? oldPrice;
  final List<String> images;
  final String category;
  final String? sellerId;
  final String? sellerName;
  final double? rating;
  final int? reviewCount;
  final int stock;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? condition;
  final String? location;
  final String? city;

  ProductModel({
    required this.id,
    required this.title,
    required this.name,
    required this.description,
    required this.price,
    this.oldPrice,
    required this.images,
    required this.category,
    this.sellerId,
    this.sellerName,
    this.rating,
    this.reviewCount,
    required this.stock,
    required this.isAvailable,
    required this.createdAt,
    this.updatedAt,
    this.condition,
    this.location,
    this.city,
  });

  // دالة لتحويل JSON إلى كائن
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['name'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      oldPrice: json['old_price']?.toDouble(),
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      category: json['category'] ?? '',
      sellerId: json['seller_id']?.toString(),
      sellerName: json['seller_name'],
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'],
      stock: json['stock'] ?? 0,
      isAvailable: json['is_available'] ?? true,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
      condition: json['condition'],
      location: json['location'],
      city: json['city'] ?? json['location'],
    );
  }

  // دالة لتحويل كائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'description': description,
      'price': price,
      'old_price': oldPrice,
      'images': images,
      'category': category,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'rating': rating,
      'review_count': reviewCount,
      'stock': stock,
      'is_available': isAvailable,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'condition': condition,
      'location': location,
      'city': city,
    };
  }

  // دالة للحصول على سعر منسق
  String get formattedPrice {
    return '${price.toStringAsFixed(0)} ريال';
  }

  // دالة للحصول على نسبة الخصم
  double? get discountPercentage {
    if (oldPrice != null && oldPrice! > 0) {
      return ((oldPrice! - price) / oldPrice!) * 100;
    }
    return null;
  }
}

// عينات من المنتجات للاختبار - باستخدام الـ constructor الصحيح
final List<ProductModel> sampleProducts = [
  ProductModel(
    id: '1',
    title: 'تويوتا كامري 2024',
    name: 'تويوتا كامري 2024',
    description: 'سيارة جديدة بالكامل، فاخرة وموفرة للوقود',
    price: 8500000,
    oldPrice: 9000000,
    images: ['https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=400'],
    category: 'سيارات',
    sellerId: 'seller1',
    sellerName: 'معرض السيارات الحديثة',
    rating: 4.8,
    reviewCount: 45,
    stock: 5,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
  ProductModel(
    id: '2',
    title: 'ماك بوك برو M3',
    name: 'ماك بوك برو M3',
    description: 'أحدث إصدار من أجهزة ماك بوك برو',
    price: 1800000,
    oldPrice: 2000000,
    images: ['https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400'],
    category: 'إلكترونيات',
    sellerId: 'seller2',
    sellerName: 'متجر التقنية',
    rating: 4.9,
    reviewCount: 120,
    stock: 10,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
  ProductModel(
    id: '3',
    title: 'ايفون 15 برو',
    name: 'ايفون 15 برو',
    description: 'هاتف ذكي من Apple بأحدث التقنيات',
    price: 450000,
    oldPrice: 500000,
    images: ['https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400'],
    category: 'إلكترونيات',
    sellerId: 'seller2',
    sellerName: 'متجر التقنية',
    rating: 4.7,
    reviewCount: 89,
    stock: 15,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
  ProductModel(
    id: '4',
    title: 'فيلا فاخرة صنعاء',
    name: 'فيلا فاخرة صنعاء',
    description: 'فيلا فاخرة في موقع ممتاز',
    price: 45000000,
    oldPrice: 50000000,
    images: ['https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400'],
    category: 'عقارات',
    sellerId: 'seller3',
    sellerName: 'شركة العقارات اليمنية',
    rating: 4.6,
    reviewCount: 12,
    stock: 1,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
  ProductModel(
    id: '5',
    title: 'مندي يمني',
    name: 'مندي يمني',
    description: 'أشهى المأكولات اليمنية',
    price: 3500,
    oldPrice: 4000,
    images: ['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400'],
    category: 'مطاعم',
    sellerId: 'seller4',
    sellerName: 'مطعم مندي يمني',
    rating: 4.9,
    reviewCount: 200,
    stock: 100,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
  ProductModel(
    id: '6',
    title: 'ثوب يمني فاخر',
    name: 'ثوب يمني فاخر',
    description: 'ثوب يمني تقليدي فاخر',
    price: 35000,
    oldPrice: 45000,
    images: ['https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=400'],
    category: 'أزياء',
    sellerId: 'seller5',
    sellerName: 'متجر الأزياء اليمنية',
    rating: 4.8,
    reviewCount: 75,
    stock: 20,
    isAvailable: true,
    createdAt: DateTime.now(),
    condition: 'جديد',
    location: 'صنعاء',
    city: 'صنعاء',
  ),
];



