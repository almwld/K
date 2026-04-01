import 'package:flutter/material.dart';

class OrderModel {
  final String id;
  final String productId;
  final String productTitle;
  final double productPrice;
  final int quantity;
  final double shippingCost;
  final double totalPrice;
  final String customerName;
  final String customerPhone;
  final String address;
  final String city;
  final String shippingCompany;
  final String trackingNumber;
  final String status; // pending, processing, shipped, delivered, cancelled
  final DateTime orderDate;
  final DateTime? estimatedDelivery;
  
  OrderModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.quantity,
    required this.shippingCost,
    required this.totalPrice,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.city,
    required this.shippingCompany,
    required this.trackingNumber,
    required this.status,
    required this.orderDate,
    this.estimatedDelivery,
  });
  
  String get statusText {
    switch (status) {
      case 'pending': return 'قيد المراجعة';
      case 'processing': return 'جاري التجهيز';
      case 'shipped': return 'تم الشحن';
      case 'delivered': return 'تم التوصيل';
      case 'cancelled': return 'ملغي';
      default: return 'قيد المراجعة';
    }
  }
  
  Color get statusColor {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'processing': return Colors.blue;
      case 'shipped': return Colors.purple;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_title': productTitle,
      'product_price': productPrice,
      'quantity': quantity,
      'shipping_cost': shippingCost,
      'total_price': totalPrice,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'address': address,
      'city': city,
      'shipping_company': shippingCompany,
      'tracking_number': trackingNumber,
      'status': status,
      'order_date': orderDate.toIso8601String(),
      'estimated_delivery': estimatedDelivery?.toIso8601String(),
    };
  }
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      productId: json['product_id'] ?? '',
      productTitle: json['product_title'] ?? '',
      productPrice: (json['product_price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      shippingCost: (json['shipping_cost'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      customerName: json['customer_name'] ?? '',
      customerPhone: json['customer_phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      shippingCompany: json['shipping_company'] ?? '',
      trackingNumber: json['tracking_number'] ?? '',
      status: json['status'] ?? 'pending',
      orderDate: DateTime.parse(json['order_date']),
      estimatedDelivery: json['estimated_delivery'] != null ? DateTime.parse(json['estimated_delivery']) : null,
    );
  }
}
