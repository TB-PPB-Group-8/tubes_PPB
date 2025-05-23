import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartController extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItemToCart(Map<String, dynamic> product) {
    _cartItems.add(CartItem(product: product));
    notifyListeners();
  }

  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void increaseItemQuantity(int index) {
    _cartItems[index].increaseQuantity();
    notifyListeners();
  }

  void decreaseItemQuantity(int index) {
    _cartItems[index].decreaseQuantity();
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + item.totalPrice);
  }
}
