import 'package:flutter/foundation.dart';

import '../models/cart_item_model.dart';
import '../models/product_model.dart';

/// Local, in-memory shopping cart — not persisted to Firestore. Cleared on
/// app restart and after a successful checkout.
class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get cartTotal =>
      _items.fold(0, (sum, item) => sum + item.subtotal);

  int get itemCount =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.productId == product.id);
    if (index == -1) {
      _items.add(
        CartItem(
          productId: product.id,
          name: product.name,
          price: product.price,
          quantity: 1,
        ),
      );
    } else {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return;
    _items[index] = _items[index].copyWith(
      quantity: _items[index].quantity + 1,
    );
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return;
    final newQuantity = _items[index].quantity - 1;
    if (newQuantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: newQuantity);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
