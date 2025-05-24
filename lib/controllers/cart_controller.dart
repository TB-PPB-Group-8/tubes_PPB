import 'package:flutter/material.dart';

class CartItem {
  final Map<String, dynamic> product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartController extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> product) {
    final index =
        _cartItems.indexWhere((item) => item.product['id'] == product['id']);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void increaseItemQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseItemQuantity(int index) {
    if (index >= 0 && index < _cartItems.length) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
        notifyListeners();
      }
    }
  }
}
