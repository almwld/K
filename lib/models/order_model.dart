import 'package:flutter/material.dart';

class OrderModel {
  final String id;
  final String productId;
  final String productTitle;
  final String productImage;
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
  final String? paymentMethod;
  final String? notes;

  OrderModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
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
    this.paymentMethod,
    this.notes,
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
}

