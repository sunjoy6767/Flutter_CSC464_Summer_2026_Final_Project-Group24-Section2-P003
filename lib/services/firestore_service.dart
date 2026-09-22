import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

/// A service for interacting with the Firestore database.
class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection('orders');

  /// Streams live updates for the full products collection.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() {
    return _products.snapshots();
  }

  /// Streams live updates for products in a single [category].
  Stream<QuerySnapshot<Map<String, dynamic>>> streamProductsByCategory(
    String category,
  ) {
    return _products.where('category', isEqualTo: category).snapshots();
  }

  /// Streams live updates for the full orders collection, newest first.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamOrders() {
    return _orders.orderBy('createdAt', descending: true).snapshots();
  } 

  /// Creates a new order document. Returns the generated order ID.
  Future<String> placeOrder({
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required List<OrderItem> items,
    required double total,
  }) async {
    final docRef = await _orders.add({
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'status': 'placed',
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }
}
