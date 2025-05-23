class CartItem {
  final Map<String, dynamic> product;
  int quantity;
  double totalPrice;

  CartItem({
    required this.product,
    this.quantity = 1,
  }) : totalPrice = product['price'] * quantity;

  void increaseQuantity() {
    quantity++;
    totalPrice = product['price'] * quantity;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      totalPrice = product['price'] * quantity;
    }
  }
}
