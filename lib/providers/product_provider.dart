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

  /// Distinct category values actually present among current products, so
  /// the filter UI reflects real Firestore data instead of a hardcoded list.
  List<String> get categories =>
      _products.map((product) => product.category).toSet().toList()..sort();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
