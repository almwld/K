import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/product_model.dart';
import '../models/auction_model.dart';
import '../models/order_model.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance = LocalDatabaseService._internal();
  factory LocalDatabaseService() => _instance;
  LocalDatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'flex_yemen.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    debugPrint('Creating local database...');
    
    // جدول المنتجات
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        images TEXT,
        category TEXT NOT NULL,
        city TEXT NOT NULL,
        seller_id TEXT NOT NULL,
        seller_name TEXT NOT NULL,
        rating REAL,
        review_count INTEGER,
        created_at INTEGER NOT NULL,
        is_featured INTEGER DEFAULT 0,
        is_auction INTEGER DEFAULT 0
      )
    ''');
    
    // جدول المزادات
    await db.execute('''
      CREATE TABLE auctions (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        images TEXT,
        starting_price REAL NOT NULL,
        current_price REAL NOT NULL,
        seller_id TEXT NOT NULL,
        seller_name TEXT NOT NULL,
        end_time INTEGER NOT NULL,
        status TEXT NOT NULL,
        bid_count INTEGER DEFAULT 0,
        category TEXT NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');
    
    // جدول الطلبات
    await db.execute('''
      CREATE TABLE orders (
        id TEXT PRIMARY KEY,
        product_id TEXT NOT NULL,
        product_title TEXT NOT NULL,
        product_price REAL NOT NULL,
        quantity INTEGER DEFAULT 1,
        shipping_cost REAL NOT NULL,
        total_price REAL NOT NULL,
        customer_name TEXT NOT NULL,
        customer_phone TEXT NOT NULL,
        address TEXT NOT NULL,
        city TEXT NOT NULL,
        shipping_company TEXT NOT NULL,
        tracking_number TEXT NOT NULL,
        status TEXT NOT NULL,
        order_date INTEGER NOT NULL
      )
    ''');
    
    // جدول المحادثات
    await db.execute('''
      CREATE TABLE chats (
        id TEXT PRIMARY KEY,
        user1_id TEXT NOT NULL,
        user2_id TEXT NOT NULL,
        user1_name TEXT NOT NULL,
        user2_name TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_title TEXT,
        product_image TEXT,
        last_message TEXT,
        last_message_time INTEGER NOT NULL,
        unread_count INTEGER DEFAULT 0
      )
    ''');
    
    // جدول الرسائل
    await db.execute('''
      CREATE TABLE messages (
        id TEXT PRIMARY KEY,
        chat_id TEXT NOT NULL,
        sender_id TEXT NOT NULL,
        message TEXT NOT NULL,
        image_url TEXT,
        created_at INTEGER NOT NULL,
        is_read INTEGER DEFAULT 0
      )
    ''');
    
    // جدول المحفظة
    await db.execute('''
      CREATE TABLE wallet (
        user_id TEXT PRIMARY KEY,
        balance REAL DEFAULT 0,
        points INTEGER DEFAULT 0,
        updated_at INTEGER NOT NULL
      )
    ''');
    
    // جدول المعاملات
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT,
        created_at INTEGER NOT NULL
      )
    ''');
    
    // جدول المفضلة
    await db.execute('''
      CREATE TABLE favorites (
        user_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        PRIMARY KEY (user_id, product_id)
      )
    ''');
    
    debugPrint('Local database created successfully!');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('Upgrading database from $oldVersion to $newVersion');
  }

  // ==================== المنتجات ====================
  Future<void> saveProducts(List<ProductModel> products) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var product in products) {
        await txn.insert(
          'products',
          {
            'id': product.id,
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'images': product.images.join(','),
            'category': product.category,
            'city': product.city,
            'seller_id': product.sellerId,
            'seller_name': product.sellerName,
            'rating': product.rating,
            'review_count': product.reviewCount,
            'created_at': product.createdAt.millisecondsSinceEpoch,
            'is_featured': product.isFeatured ? 1 : 0,
            'is_auction': product.isAuction ? 1 : 0,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<ProductModel>> getProducts({String? category, bool? featured}) async {
    final db = await database;
    String whereClause = '1=1';
    List<Object?> whereArgs = [];
    
    if (category != null) {
      whereClause += ' AND category = ?';
      whereArgs.add(category);
    }
    if (featured != null) {
      whereClause += ' AND is_featured = ?';
      whereArgs.add(featured ? 1 : 0);
    }
    
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => ProductModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      images: (map['images'] as String).split(','),
      category: map['category'],
      city: map['city'],
      sellerId: map['seller_id'],
      sellerName: map['seller_name'],
      rating: map['rating'],
      reviewCount: map['review_count'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      isFeatured: map['is_featured'] == 1,
      isAuction: map['is_auction'] == 1,
    )).toList();
  }

  // ==================== الطلبات ====================
  Future<void> saveOrder(OrderModel order) async {
    final db = await database;
    await db.insert(
      'orders',
      {
        'id': order.id,
        'product_id': order.productId,
        'product_title': order.productTitle,
        'product_price': order.productPrice,
        'quantity': order.quantity,
        'shipping_cost': order.shippingCost,
        'total_price': order.totalPrice,
        'customer_name': order.customerName,
        'customer_phone': order.customerPhone,
        'address': order.address,
        'city': order.city,
        'shipping_company': order.shippingCompany,
        'tracking_number': order.trackingNumber,
        'status': order.status,
        'order_date': order.orderDate.millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<OrderModel>> getOrders(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'orders',
      where: 'customer_phone = ?',
      whereArgs: [userId],
      orderBy: 'order_date DESC',
    );
    
    return maps.map((map) => OrderModel(
      id: map['id'],
      productId: map['product_id'],
      productTitle: map['product_title'],
      productPrice: map['product_price'],
      quantity: map['quantity'],
      shippingCost: map['shipping_cost'],
      totalPrice: map['total_price'],
      customerName: map['customer_name'],
      customerPhone: map['customer_phone'],
      address: map['address'],
      city: map['city'],
      shippingCompany: map['shipping_company'],
      trackingNumber: map['tracking_number'],
      status: map['status'],
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['order_date']),
    )).toList();
  }

  // ==================== المحفظة ====================
  Future<void> saveWallet(String userId, double balance, int points) async {
    final db = await database;
    await db.insert(
      'wallet',
      {
        'user_id': userId,
        'balance': balance,
        'points': points,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getWallet(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'wallet',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    
    if (maps.isEmpty) return null;
    return maps.first;
  }

  // ==================== المفضلة ====================
  Future<void> toggleFavorite(String userId, String productId) async {
    final db = await database;
    final exists = await db.query(
      'favorites',
      where: 'user_id = ? AND product_id = ?',
      whereArgs: [userId, productId],
    );
    
    if (exists.isNotEmpty) {
      await db.delete(
        'favorites',
        where: 'user_id = ? AND product_id = ?',
        whereArgs: [userId, productId],
      );
    } else {
      await db.insert(
        'favorites',
        {
          'user_id': userId,
          'product_id': productId,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        },
      );
    }
  }

  Future<List<ProductModel>> getFavorites(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT p.* FROM products p
      INNER JOIN favorites f ON p.id = f.product_id
      WHERE f.user_id = ?
      ORDER BY f.created_at DESC
    ''', [userId]);
    
    return maps.map((map) => ProductModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      images: (map['images'] as String).split(','),
      category: map['category'],
      city: map['city'],
      sellerId: map['seller_id'],
      sellerName: map['seller_name'],
      rating: map['rating'],
      reviewCount: map['review_count'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      isFeatured: map['is_featured'] == 1,
      isAuction: map['is_auction'] == 1,
    )).toList();
  }

  // ==================== تنظيف البيانات ====================
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('products');
    await db.delete('auctions');
    await db.delete('orders');
    await db.delete('chats');
    await db.delete('messages');
    await db.delete('wallet');
    await db.delete('transactions');
    await db.delete('favorites');
  }

  Future<int> getCacheSize() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT SUM(length(title) + length(description) + length(images)) as size
      FROM products
    ''');
    return result.first['size'] as int? ?? 0;
  }
}
