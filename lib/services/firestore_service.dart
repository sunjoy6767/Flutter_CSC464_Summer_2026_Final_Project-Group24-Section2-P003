import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

/// Firestore schema — collection: "products"
///
/// products/{productId}
///   name        : string   — product name, e.g. "Wireless Mouse"
///   category    : string   — e.g. "Electronics"
///   price       : number   — unit price in BDT (e.g. 1250.0)
///   description : string   — short product description
///   imageUrl    : string   — remote image URL (e.g. Unsplash) or
///                            placeholder/asset path
///
/// {productId} is the Firestore-generated document ID; it is not stored
/// as a field inside the document itself.
///
/// Read-only: products are never created/edited/deleted from the app UI —
/// they only get into Firestore via the seed script
/// (lib/utils/seed_data.dart).
///
/// Firestore schema — collection: "orders"
///
/// orders/{orderId}
///   customerName    : string
///   customerPhone   : string
///   customerAddress : string
///   items           : [ { productId, name, quantity, price } ]
///   total           : number
///   status          : string — "placed" on creation
///   createdAt       : timestamp — server time, set on creation
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
