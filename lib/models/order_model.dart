import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity']?.toInt() ?? 1,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class OrderModel {
  final String orderId;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime? createdAt;

  OrderModel({
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.items,
    required this.total,
    this.status = 'placed',
    this.createdAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final rawItems = data['items'] as List<dynamic>? ?? [];
    final createdAtValue = data['createdAt'];
    return OrderModel(
      orderId: doc.id,
      customerName: data['customerName'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      customerAddress: data['customerAddress'] ?? '',
      items: rawItems
          .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      total: (data['total'] as num?)?.toDouble() ?? 0.0,
      status: data['status'] ?? 'placed',
      createdAt: createdAtValue is Timestamp ? createdAtValue.toDate() : null,
    );
  }
}