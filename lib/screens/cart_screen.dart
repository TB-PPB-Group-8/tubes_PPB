import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('Keranjang')),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          if (cartController.cartItems.isEmpty) {
            return Center(child: Text('Keranjang Anda kosong.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  for (var item in cartController.cartItems)
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.product['image'],
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          item.product['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                        subtitle: Text(
                          'Price: \$${item.product['price']} x ${item.quantity} = \$${item.product['price'] * item.quantity}',
                          style: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                        trailing: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Membatasi ukuran row
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cartController.decreaseItemQuantity(
                                    cartController.cartItems.indexOf(item));
                              },
                            ),
                            Text('${item.quantity}',
                                style: TextStyle(fontSize: screenWidth * 0.04)),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cartController.increaseItemQuantity(
                                    cartController.cartItems.indexOf(item));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  // Total harga
                  Text(
                    'Total Harga: \$${cartController.totalPrice}',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Tombol checkout
                  ElevatedButton(
                    onPressed: () {
                      // Logika checkout
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Checkout',
                        style: TextStyle(fontSize: screenWidth * 0.05)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
