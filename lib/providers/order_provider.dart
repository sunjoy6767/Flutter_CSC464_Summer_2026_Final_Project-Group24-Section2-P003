import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/order_model.dart';
import '../services/firestore_service.dart';

class OrderProvider extends ChangeNotifier {
  OrderProvider({FirestoreService? firestoreService})
    : _firestoreService = firestoreService ?? FirestoreService() {
    _subscription = _firestoreService.streamOrders().listen((snapshot) {
      _orders = snapshot.docs.map(OrderModel.fromFirestore).toList();
      notifyListeners();
    });
  }

  final FirestoreService _firestoreService;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  List<OrderModel> _orders = [];
  List<OrderModel> get orders => List.unmodifiable(_orders);

  List<OrderModel> ordersByStatus(String status) {
    return _orders.where((order) => order.status == status).toList();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
