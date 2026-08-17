import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../services/firestore_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({FirestoreService? firestoreService})
    : _firestoreService = firestoreService ?? FirestoreService() {
    _subscription = _firestoreService.streamProducts().listen((snapshot) {
      _products = snapshot.docs.map(Product.fromFirestore).toList();
      notifyListeners();
    });
  }

  final FirestoreService _firestoreService;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  List<Product> _products = [];
  List<Product> get products => List.unmodifiable(_products);

  /// Products belonging to [category].
  List<Product> productsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  Future<void> addProduct(Product product) {
    return _firestoreService.createProduct(product.toMap());
  }

  Future<void> updateProduct(String productId, Map<String, dynamic> data) {
    return _firestoreService.updateProduct(productId, data);
  }

  Future<void> deleteProduct(String productId) {
    return _firestoreService.deleteProduct(productId);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
